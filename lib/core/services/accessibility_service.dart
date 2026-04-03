import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Accessibility service for enhanced accessibility features
class AccessibilityService {
  AccessibilityService._();

  static final AccessibilityService instance = AccessibilityService._();

  /// Check if screen reader is active
  bool isScreenReaderActive() {
    final accessibilityFeatures = WidgetsBinding.instance.platformDispatcher.accessibilityFeatures;
    return accessibilityFeatures.accessibleNavigation;
  }

  /// Check if bold text is enabled
  bool isBoldTextEnabled() {
    return WidgetsBinding.instance.platformDispatcher.accessibilityFeatures.boldText;
  }

  /// Check if reduce motion is enabled
  bool reduceMotionEnabled() {
    return WidgetsBinding.instance.platformDispatcher.accessibilityFeatures.disableAnimations;
  }

  /// Announce a message to screen reader
  void announce(String message) {
    // Note: SemanticsService.announce is not available in stable Flutter
    // This is a placeholder for future implementation
    debugPrint('Accessibility announcement: $message');
  }

  /// Set accessibility focus to a node
  void requestFocus(FocusNode focusNode) {
    focusNode.requestFocus();
  }

  /// Trigger haptic feedback based on action type
  void hapticFeedback(HapticFeedbackType type) {
    switch (type) {
      case HapticFeedbackType.light:
        HapticFeedback.lightImpact();
      case HapticFeedbackType.medium:
        HapticFeedback.mediumImpact();
      case HapticFeedbackType.heavy:
        HapticFeedback.heavyImpact();
      case HapticFeedbackType.selection:
        HapticFeedback.selectionClick();
      case HapticFeedbackType.vibration:
        HapticFeedback.vibrate();
    }
  }

  /// Create an accessible button with proper semantics
  static Widget accessibleButton({
    required BuildContext context,
    required VoidCallback onPressed,
    required Widget child,
    String? semanticsLabel,
    String? semanticsHint,
    bool isFocused = false,
  }) {
    return Semantics(
      label: semanticsLabel,
      hint: semanticsHint,
      button: true,
      focusable: true,
      focused: isFocused,
      child: InkWell(
        onTap: onPressed,
        child: child,
      ),
    );
  }

  /// Create an accessible image with description
  static Widget accessibleImage({
    required Widget child,
    required String description,
    bool excludeSemantics = false,
  }) {
    return Semantics(
      image: true,
      label: description,
      excludeSemantics: excludeSemantics,
      child: child,
    );
  }

  /// Create a semantic heading
  static Widget semanticHeading({
    required Widget child,
    String? label,
  }) {
    return Semantics(
      label: label,
      header: true,
      explicitChildNodes: true,
      child: child,
    );
  }

  /// Create accessible list item
  static Widget accessibleListItem({
    required Widget child,
    required String label,
    VoidCallback? onTap,
  }) {
    return Semantics(
      label: label,
      container: true,
      button: onTap != null,
      onTap: onTap,
      child: child,
    );
  }

  /// Get appropriate animation duration based on accessibility settings
  Duration getAnimationDuration({
    Duration normal = const Duration(milliseconds: 300),
    Duration reduced = const Duration(milliseconds: 100),
  }) {
    return reduceMotionEnabled() ? reduced : normal;
  }

  /// Announce page change for screen readers
  void announcePageChange(String pageTitle) {
    Future.delayed(const Duration(milliseconds: 500), () {
      announce('Navigated to $pageTitle');
    });
  }

  /// Create accessible form field
  static Widget accessibleFormField({
    required Widget child,
    required String label,
    String? hint,
    String? errorText,
    bool isRequired = false,
  }) {
    return Semantics(
      label: label,
      hint: hint,
      child: child,
    );
  }
}

/// Haptic feedback types
enum HapticFeedbackType {
  light,
  medium,
  heavy,
  selection,
  vibration,
}

/// Extension to darken/lighten colors
extension ColorExtension on Color {
  Color darken(double amount) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(this);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
    return hslDark.toColor();
  }

  Color lighten(double amount) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(this);
    final hslLight = hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));
    return hslLight.toColor();
  }
}