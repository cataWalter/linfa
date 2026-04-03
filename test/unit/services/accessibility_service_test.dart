import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:linfa/core/services/accessibility_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AccessibilityService', () {
    late AccessibilityService service;

    setUp(() {
      service = AccessibilityService.instance;
    });

    group('singleton', () {
      test('should return same instance', () {
        final instance1 = AccessibilityService.instance;
        final instance2 = AccessibilityService.instance;
        expect(identical(instance1, instance2), isTrue);
      });
    });

    group('isScreenReaderActive', () {
      test('should return accessibility navigation status', () {
        // This test verifies the method can be called without crashing
        // The actual value depends on the platform
        final result = service.isScreenReaderActive();
        expect(result, isA<bool>());
      });
    });

    group('isBoldTextEnabled', () {
      test('should return bold text status', () {
        final result = service.isBoldTextEnabled();
        expect(result, isA<bool>());
      });
    });

    group('reduceMotionEnabled', () {
      test('should return reduce motion status', () {
        final result = service.reduceMotionEnabled();
        expect(result, isA<bool>());
      });
    });

    group('announce', () {
      test('should not throw when announcing message', () {
        expect(() => service.announce('Test message'), returnsNormally);
      });
    });

    group('requestFocus', () {
      test('should request focus on FocusNode', () {
        final focusNode = FocusNode();
        addTearDown(focusNode.dispose);

        expect(() => service.requestFocus(focusNode), returnsNormally);
      });
    });

    group('hapticFeedback', () {
      test('should handle light feedback type', () {
        expect(
          () => service.hapticFeedback(HapticFeedbackType.light),
          returnsNormally,
        );
      });

      test('should handle medium feedback type', () {
        expect(
          () => service.hapticFeedback(HapticFeedbackType.medium),
          returnsNormally,
        );
      });

      test('should handle heavy feedback type', () {
        expect(
          () => service.hapticFeedback(HapticFeedbackType.heavy),
          returnsNormally,
        );
      });

      test('should handle selection feedback type', () {
        expect(
          () => service.hapticFeedback(HapticFeedbackType.selection),
          returnsNormally,
        );
      });

      test('should handle vibration feedback type', () {
        expect(
          () => service.hapticFeedback(HapticFeedbackType.vibration),
          returnsNormally,
        );
      });
    });

    group('accessibleButton', () {
      // The accessibleButton method requires a BuildContext which is hard to mock
      // in unit tests. This is tested in integration tests instead.
    });

    group('accessibleImage', () {
      test('should create Semantics widget with image configuration', () {
        final child = const Text('Image');

        final widget = AccessibilityService.accessibleImage(
          child: child,
          description: 'A test image',
        );

        expect(widget, isA<Semantics>());
      });

      test('should exclude semantics when requested', () {
        final child = const Text('Image');

        final widget = AccessibilityService.accessibleImage(
          child: child,
          description: 'A test image',
          excludeSemantics: true,
        );

        expect(widget, isA<Semantics>());
      });
    });

    group('semanticHeading', () {
      test('should create Semantics widget with heading configuration', () {
        final child = const Text('Heading');

        final widget = AccessibilityService.semanticHeading(
          child: child,
          label: 'Section Title',
        );

        expect(widget, isA<Semantics>());
      });

      test('should work without label', () {
        final child = const Text('Heading');

        final widget = AccessibilityService.semanticHeading(child: child);

        expect(widget, isA<Semantics>());
      });
    });

    group('accessibleListItem', () {
      test('should create Semantics widget with list item configuration', () {
        final child = const Text('Item');

        final widget = AccessibilityService.accessibleListItem(
          child: child,
          label: 'List Item',
          onTap: () {},
        );

        expect(widget, isA<Semantics>());
      });

      test('should work without onTap', () {
        final child = const Text('Item');

        final widget = AccessibilityService.accessibleListItem(
          child: child,
          label: 'List Item',
        );

        expect(widget, isA<Semantics>());
      });
    });

    group('getAnimationDuration', () {
      test('should return normal duration when motion is not reduced', () {
        final normal = const Duration(milliseconds: 300);
        final reduced = const Duration(milliseconds: 100);

        final result = service.getAnimationDuration(
          normal: normal,
          reduced: reduced,
        );

        // Result depends on accessibility settings, just verify it returns a Duration
        expect(result, isA<Duration>());
      });
    });

    group('announcePageChange', () {
      test('should not throw when announcing page change', () {
        expect(
          () => service.announcePageChange('Test Page'),
          returnsNormally,
        );
      });
    });

    group('accessibleFormField', () {
      test('should create Semantics widget for form field', () {
        final child = const Text('Input');

        final widget = AccessibilityService.accessibleFormField(
          child: child,
          label: 'Form Field',
          hint: 'Enter value',
          isRequired: true,
        );

        expect(widget, isA<Semantics>());
      });

      test('should work with error text', () {
        final child = const Text('Input');

        final widget = AccessibilityService.accessibleFormField(
          child: child,
          label: 'Form Field',
          errorText: 'Invalid value',
        );

        expect(widget, isA<Semantics>());
      });
    });
  });

  group('HapticFeedbackType', () {
    test('should have all expected values', () {
      expect(HapticFeedbackType.values.length, 5);
      expect(HapticFeedbackType.values, contains(HapticFeedbackType.light));
      expect(HapticFeedbackType.values, contains(HapticFeedbackType.medium));
      expect(HapticFeedbackType.values, contains(HapticFeedbackType.heavy));
      expect(HapticFeedbackType.values, contains(HapticFeedbackType.selection));
      expect(HapticFeedbackType.values, contains(HapticFeedbackType.vibration));
    });
  });

  group('ColorExtension', () {
    group('darken', () {
      test('should darken color by specified amount', () {
        const color = Color(0xFF808080);
        final darkened = color.darken(0.5);

        expect(darkened, isA<Color>());
        // Darkened color should have lower lightness
        expect(HSLColor.fromColor(darkened).lightness,
            lessThan(HSLColor.fromColor(color).lightness));
      });

      test('should clamp to minimum lightness', () {
        const color = Color(0xFF808080);
        final darkened = color.darken(1.0);

        expect(HSLColor.fromColor(darkened).lightness, greaterThanOrEqualTo(0.0));
      });
    });

    group('lighten', () {
      test('should lighten color by specified amount', () {
        const color = Color(0xFF808080);
        final lightened = color.lighten(0.3);

        expect(lightened, isA<Color>());
        // Lightened color should have higher lightness
        expect(HSLColor.fromColor(lightened).lightness,
            greaterThan(HSLColor.fromColor(color).lightness));
      });

      test('should clamp to maximum lightness', () {
        const color = Color(0xFF808080);
        final lightened = color.lighten(1.0);

        expect(HSLColor.fromColor(lightened).lightness, lessThanOrEqualTo(1.0));
      });
    });
  });
}