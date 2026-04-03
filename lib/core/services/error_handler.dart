import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as developer;

/// Error severity levels
enum ErrorSeverity {
  low,
  medium,
  high,
  critical,
}

/// Error context for better debugging
class ErrorContext {
  final String? userId;
  final String? screenName;
  final String? action;
  final Map<String, dynamic>? additionalData;
  final DateTime timestamp;

  ErrorContext({
    this.userId,
    this.screenName,
    this.action,
    this.additionalData,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'screenName': screenName,
        'action': action,
        'additionalData': additionalData,
        'timestamp': timestamp.toIso8601String(),
      };
}

/// Custom exception for business logic errors
class AppException implements Exception {
  final String message;
  final ErrorSeverity severity;
  final String? code;
  final dynamic originalError;

  AppException({
    required this.message,
    this.severity = ErrorSeverity.medium,
    this.code,
    this.originalError,
  });

  @override
  String toString() => 'AppException($code): $message';
}

/// Global error handler service
class ErrorHandler {
  ErrorHandler._();

  static final ErrorHandler instance = ErrorHandler._();

  final List<void Function(String, ErrorContext, dynamic)> _errorListeners = [];
  final List<void Function(String)> _infoListeners = [];

  /// Register an error listener
  void addErrorListener(
      void Function(String, ErrorContext, dynamic) listener) {
    _errorListeners.add(listener);
  }

  /// Register an info listener
  void addInfoListener(void Function(String) listener) {
    _infoListeners.add(listener);
  }

  /// Handle an error with context
  void handleError(
    dynamic error,
    StackTrace stackTrace, {
    ErrorContext? context,
    ErrorSeverity severity = ErrorSeverity.medium,
  }) {
    final errorMessage = _formatError(error);
    final errorContext = context ?? ErrorContext();

    // Log to console in debug mode
    if (kDebugMode) {
      developer.log(
        'ERROR: $errorMessage',
        name: 'ErrorHandler',
        error: error,
        stackTrace: stackTrace,
      );
    }

    // Notify listeners
    for (final listener in _errorListeners) {
      try {
        listener(errorMessage, errorContext, error as Object);
      } catch (e, st) {
        // Prevent listener errors from crashing
        if (kDebugMode) {
          developer.log('Error in error listener: $e', stackTrace: st);
        }
      }
    }

    // Report to Flutter error zone in release mode
    if (!kDebugMode) {
      FlutterError.reportError(FlutterErrorDetails(
        exception: error,
        stack: stackTrace,
        library: 'Linfa',
        context: ErrorDescription(errorContext.screenName ?? 'Unknown'),
      ));
    }
  }

  /// Log an info message
  void logInfo(String message, {ErrorContext? context}) {
    if (kDebugMode) {
      developer.log('INFO: $message', name: 'Linfa');
    }

    for (final listener in _infoListeners) {
      try {
        listener(message);
      } catch (e) {
        // Prevent listener errors
      }
    }
  }

  /// Show error snackbar
  void showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red.shade400,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        action: SnackBarAction(
          label: 'Dismiss',
          textColor: Colors.white,
          onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
        ),
      ),
    );
  }

  /// Format error message
  String _formatError(dynamic error) {
    if (error is AppException) {
      return error.message;
    }
    if (error is String) {
      return error;
    }
    if (error is Exception) {
      return error.toString();
    }
    return 'Unknown error: ${error.toString()}';
  }

  /// Create common app exceptions
  static AppException networkError() => AppException(
        message: 'Connection error. Please check your internet connection.',
        code: 'NETWORK_ERROR',
        severity: ErrorSeverity.medium,
      );

  static AppException databaseError(String details) => AppException(
        message: 'Database error: $details',
        code: 'DATABASE_ERROR',
        severity: ErrorSeverity.high,
      );

  static AppException permissionDenied(String permission) => AppException(
        message: 'Permission denied: $permission required',
        code: 'PERMISSION_DENIED',
        severity: ErrorSeverity.medium,
      );

  static AppException validationError(String field, String message) =>
      AppException(
        message: 'Validation error in $field: $message',
        code: 'VALIDATION_ERROR',
        severity: ErrorSeverity.low,
      );

  static AppException fileNotFoundError(String path) => AppException(
        message: 'File not found: $path',
        code: 'FILE_NOT_FOUND',
        severity: ErrorSeverity.medium,
      );

  static AppException unknownError([String? details]) => AppException(
        message: 'An unknown error occurred${details != null ? ": $details" : ""}',
        code: 'UNKNOWN_ERROR',
        severity: ErrorSeverity.high,
      );
}

/// Extension for safe async operations
extension SafeAsync<T> on Future<T> {
  /// Execute with error handling
  Future<(T?, AppException?)> safeCall({
    ErrorContext? context,
    ErrorSeverity severity = ErrorSeverity.medium,
  }) async {
    try {
      final result = await this;
      return (result, null);
    } catch (e, st) {
      final exception = e is AppException
          ? e
          : AppException(
              message: e.toString(),
              severity: severity,
              originalError: e,
            );
      ErrorHandler.instance.handleError(exception, st, context: context);
      return (null, exception);
    }
  }
}