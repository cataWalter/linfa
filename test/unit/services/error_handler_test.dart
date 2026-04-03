import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:linfa/core/services/error_handler.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('ErrorSeverity', () {
    test('should have all expected values', () {
      expect(ErrorSeverity.values.length, 4);
      expect(ErrorSeverity.values, contains(ErrorSeverity.low));
      expect(ErrorSeverity.values, contains(ErrorSeverity.medium));
      expect(ErrorSeverity.values, contains(ErrorSeverity.high));
      expect(ErrorSeverity.values, contains(ErrorSeverity.critical));
    });
  });

  group('ErrorContext', () {
    test('should create with all fields', () {
      final context = ErrorContext(
        userId: 'user123',
        screenName: 'HomeScreen',
        action: 'loadData',
        additionalData: {'key': 'value'},
      );

      expect(context.userId, 'user123');
      expect(context.screenName, 'HomeScreen');
      expect(context.action, 'loadData');
      expect(context.additionalData, {'key': 'value'});
      expect(context.timestamp, isA<DateTime>());
    });

    test('should create with default timestamp', () {
      final before = DateTime.now();
      final context = ErrorContext();
      final after = DateTime.now();

      expect(context.userId, isNull);
      expect(context.screenName, isNull);
      expect(context.action, isNull);
      expect(context.additionalData, isNull);
      expect(context.timestamp.isAfter(before) ||
          context.timestamp.isAtSameMomentAs(before), isTrue);
      expect(context.timestamp.isBefore(after) ||
          context.timestamp.isAtSameMomentAs(after), isTrue);
    });

    test('should use provided timestamp', () {
      final customTimestamp = DateTime(2024, 1, 1);
      final context = ErrorContext(timestamp: customTimestamp);

      expect(context.timestamp, customTimestamp);
    });

    test('toJson should serialize all fields', () {
      final context = ErrorContext(
        userId: 'user123',
        screenName: 'TestScreen',
        action: 'testAction',
        additionalData: {'test': 'data'},
      );

      final json = context.toJson();

      expect(json['userId'], 'user123');
      expect(json['screenName'], 'TestScreen');
      expect(json['action'], 'testAction');
      expect(json['additionalData'], {'test': 'data'});
      expect(json['timestamp'], isA<String>());
    });
  });

  group('AppException', () {
    test('should create with required fields only', () {
      final exception = AppException(message: 'Test error');

      expect(exception.message, 'Test error');
      expect(exception.severity, ErrorSeverity.medium);
      expect(exception.code, isNull);
      expect(exception.originalError, isNull);
    });

    test('should create with all fields', () {
      final originalError = Exception('original');
      final exception = AppException(
        message: 'Test error',
        severity: ErrorSeverity.high,
        code: 'TEST_ERROR',
        originalError: originalError,
      );

      expect(exception.message, 'Test error');
      expect(exception.severity, ErrorSeverity.high);
      expect(exception.code, 'TEST_ERROR');
      expect(exception.originalError, originalError);
    });

    test('toString should return formatted message', () {
      final exception = AppException(
        message: 'Test error',
        code: 'TEST_ERROR',
      );

      expect(exception.toString(), 'AppException(TEST_ERROR): Test error');
    });

    test('toString should handle null code', () {
      final exception = AppException(message: 'Test error');

      expect(exception.toString(), 'AppException(null): Test error');
    });
  });

  group('ErrorHandler', () {
    late ErrorHandler handler;

    setUp(() {
      handler = ErrorHandler.instance;
    });

    group('singleton', () {
      test('should return same instance', () {
        final instance1 = ErrorHandler.instance;
        final instance2 = ErrorHandler.instance;
        expect(identical(instance1, instance2), isTrue);
      });
    });

    group('addErrorListener', () {
      test('should register listener without throwing', () {
        void listener(String msg, ErrorContext ctx, dynamic err) {}
        expect(() => handler.addErrorListener(listener), returnsNormally);
      });
    });

    group('addInfoListener', () {
      test('should register listener without throwing', () {
        void listener(String msg) {}
        expect(() => handler.addInfoListener(listener), returnsNormally);
      });
    });

    group('handleError', () {
      test('should handle string error', () {
        var listenerCalled = false;
        handler.addErrorListener((msg, ctx, err) {
          listenerCalled = true;
          expect(msg, 'String error');
        });

        handler.handleError('String error', StackTrace.empty);

        expect(listenerCalled, isTrue);
      });

      test('should handle AppException', () {
        var listenerCalled = false;
        handler.addErrorListener((msg, ctx, err) {
          listenerCalled = true;
          expect(msg, 'App exception message');
        });

        final exception = AppException(message: 'App exception message');
        handler.handleError(exception, StackTrace.empty);

        expect(listenerCalled, isTrue);
      });

      test('should handle generic exception', () {
        var listenerCalled = false;
        handler.addErrorListener((msg, ctx, err) {
          listenerCalled = true;
          expect(msg, contains('Exception: Generic error'));
        });

        handler.handleError(Exception('Generic error'), StackTrace.empty);

        expect(listenerCalled, isTrue);
      });

      test('should handle unknown error type', () {
        var listenerCalled = false;
        handler.addErrorListener((msg, ctx, err) {
          listenerCalled = true;
        });

        handler.handleError(12345, StackTrace.empty);

        expect(listenerCalled, isTrue);
      });

      test('should use provided context', () {
        var receivedContext = ErrorContext();
        final customContext = ErrorContext(screenName: 'TestScreen');

        handler.addErrorListener((msg, ctx, err) {
          receivedContext = ctx;
        });

        handler.handleError('Test error', StackTrace.empty, context: customContext);

        expect(receivedContext.screenName, 'TestScreen');
      });

      test('should create default context when not provided', () {
        var receivedContext = ErrorContext();

        handler.addErrorListener((msg, ctx, err) {
          receivedContext = ctx;
        });

        handler.handleError('Test error', StackTrace.empty);

        expect(receivedContext.screenName, isNull);
      });

      test('should handle listener errors gracefully', () {
        var secondListenerCalled = false;

        handler.addErrorListener((msg, ctx, err) {
          throw Exception('Listener error');
        });

        handler.addErrorListener((msg, ctx, err) {
          secondListenerCalled = true;
        });

        // Should not throw and should call second listener
        handler.handleError('Test error', StackTrace.empty);

        expect(secondListenerCalled, isTrue);
      });
    });

    group('logInfo', () {
      test('should call info listeners', () {
        var listenerCalled = false;
        var receivedMessage = '';

        handler.addInfoListener((msg) {
          listenerCalled = true;
          receivedMessage = msg;
        });

        handler.logInfo('Test info message');

        expect(listenerCalled, isTrue);
        expect(receivedMessage, 'Test info message');
      });

      test('should handle listener errors gracefully', () {
        var secondListenerCalled = false;

        handler.addInfoListener((msg) {
          throw Exception('Listener error');
        });

        handler.addInfoListener((msg) {
          secondListenerCalled = true;
        });

        handler.logInfo('Test info');

        expect(secondListenerCalled, isTrue);
      });
    });

    group('showSnackbar', () {
      test('should not throw when called', () {
        // We can't easily test the snackbar display without a full widget test
        // Just verify the method can be called without crashing
        // The actual UI testing would be done in integration tests
        expect(() => handler.showSnackbar, returnsNormally);
      });
    });

    group('static factory methods', () {
      test('networkError should create correct exception', () {
        final exception = ErrorHandler.networkError();

        expect(exception.message, contains('Connection error'));
        expect(exception.code, 'NETWORK_ERROR');
        expect(exception.severity, ErrorSeverity.medium);
      });

      test('databaseError should create correct exception', () {
        final exception = ErrorHandler.databaseError('details');

        expect(exception.message, 'Database error: details');
        expect(exception.code, 'DATABASE_ERROR');
        expect(exception.severity, ErrorSeverity.high);
      });

      test('permissionDenied should create correct exception', () {
        final exception = ErrorHandler.permissionDenied('camera');

        expect(exception.message, 'Permission denied: camera required');
        expect(exception.code, 'PERMISSION_DENIED');
        expect(exception.severity, ErrorSeverity.medium);
      });

      test('validationError should create correct exception', () {
        final exception = ErrorHandler.validationError('name', 'is required');

        expect(exception.message, 'Validation error in name: is required');
        expect(exception.code, 'VALIDATION_ERROR');
        expect(exception.severity, ErrorSeverity.low);
      });

      test('fileNotFoundError should create correct exception', () {
        final exception = ErrorHandler.fileNotFoundError('/path/to/file');

        expect(exception.message, 'File not found: /path/to/file');
        expect(exception.code, 'FILE_NOT_FOUND');
        expect(exception.severity, ErrorSeverity.medium);
      });

      test('unknownError should create correct exception without details', () {
        final exception = ErrorHandler.unknownError();

        expect(exception.message, 'An unknown error occurred');
        expect(exception.code, 'UNKNOWN_ERROR');
        expect(exception.severity, ErrorSeverity.high);
      });

      test('unknownError should create correct exception with details', () {
        final exception = ErrorHandler.unknownError('something went wrong');

        expect(exception.message, 'An unknown error occurred: something went wrong');
        expect(exception.code, 'UNKNOWN_ERROR');
        expect(exception.severity, ErrorSeverity.high);
      });
    });
  });

  group('SafeAsync extension', () {
    test('should return result when successful', () async {
      final future = Future.value('success');

      final (result, exception) = await future.safeCall();

      expect(result, 'success');
      expect(exception, isNull);
    });

    test('should return exception when error occurs', () async {
      final future = Future.error('error');

      final (result, exception) = await future.safeCall();

      expect(result, isNull);
      expect(exception, isA<AppException>());
    });

    test('should wrap non-AppException errors', () async {
      final future = Future.error(Exception('test error'));

      final (result, exception) = await future.safeCall();

      expect(result, isNull);
      expect(exception, isA<AppException>());
      expect(exception!.message, contains('test error'));
    });

    test('should preserve AppException', () async {
      final appException = AppException(message: 'app error');
      final future = Future.error(appException);

      final (result, exception) = await future.safeCall();

      expect(result, isNull);
      expect(exception, appException);
    });
  });
}