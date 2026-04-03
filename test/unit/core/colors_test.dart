import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:linfa/core/constants/colors.dart';

void main() {
  group('LinfaColors', () {
    group('Primary colors', () {
      test('primary should be correct color', () {
        expect(LinfaColors.primary, const Color(0xFF4CAF50));
      });

      test('primaryLight should be correct color', () {
        expect(LinfaColors.primaryLight, const Color(0xFF81C784));
      });

      test('primaryDark should be correct color', () {
        expect(LinfaColors.primaryDark, const Color(0xFF388E3C));
      });
    });

    group('Secondary colors', () {
      test('secondary should be correct color', () {
        expect(LinfaColors.secondary, const Color(0xFF8D6E63));
      });

      test('secondaryLight should be correct color', () {
        expect(LinfaColors.secondaryLight, const Color(0xFFBCAAA4));
      });

      test('secondaryDark should be correct color', () {
        expect(LinfaColors.secondaryDark, const Color(0xFF5D4037));
      });
    });

    group('Accent colors', () {
      test('accent should be correct color', () {
        expect(LinfaColors.accent, const Color(0xFF4FC3F7));
      });

      test('accentLight should be correct color', () {
        expect(LinfaColors.accentLight, const Color(0xFF81D4FA));
      });

      test('accentDark should be correct color', () {
        expect(LinfaColors.accentDark, const Color(0xFF0288D1));
      });
    });

    group('Status colors', () {
      test('healthy should be correct color', () {
        expect(LinfaColors.healthy, const Color(0xFF66BB6A));
      });

      test('warning should be correct color', () {
        expect(LinfaColors.warning, const Color(0xFFFFA726));
      });

      test('danger should be correct color', () {
        expect(LinfaColors.danger, const Color(0xFFEF5350));
      });

      test('dormant should be correct color', () {
        expect(LinfaColors.dormant, const Color(0xFFBDBDBD));
      });
    });

    group('Background colors', () {
      test('backgroundLight should be correct color', () {
        expect(LinfaColors.backgroundLight, const Color(0xFFFAFAFA));
      });

      test('surfaceLight should be correct color', () {
        expect(LinfaColors.surfaceLight, const Color(0xFFFFFFFF));
      });

      test('backgroundDark should be correct color', () {
        expect(LinfaColors.backgroundDark, const Color(0xFF121212));
      });

      test('surfaceDark should be correct color', () {
        expect(LinfaColors.surfaceDark, const Color(0xFF1E1E1E));
      });
    });

    group('Text colors', () {
      test('textPrimaryLight should be correct color', () {
        expect(LinfaColors.textPrimaryLight, const Color(0xFF212121));
      });

      test('textSecondaryLight should be correct color', () {
        expect(LinfaColors.textSecondaryLight, const Color(0xFF757575));
      });

      test('textPrimaryDark should be correct color', () {
        expect(LinfaColors.textPrimaryDark, const Color(0xFFFAFAFA));
      });

      test('textSecondaryDark should be correct color', () {
        expect(LinfaColors.textSecondaryDark, const Color(0xFFBDBDBD));
      });
    });

    group('Reminder type colors', () {
      test('watering should be correct color', () {
        expect(LinfaColors.watering, const Color(0xFF42A5F5));
      });

      test('fertilizing should be correct color', () {
        expect(LinfaColors.fertilizing, const Color(0xFFAB47BC));
      });

      test('repotting should be correct color', () {
        expect(LinfaColors.repotting, const Color(0xFF66BB6A));
      });

      test('cleaning should be correct color', () {
        expect(LinfaColors.cleaning, const Color(0xFF26C6DA));
      });

      test('pruning should be correct color', () {
        expect(LinfaColors.pruning, const Color(0xFFEF5350));
      });

      test('misting should be correct color', () {
        expect(LinfaColors.misting, const Color(0xFF29B6F6));
      });
    });

    group('Gradients', () {
      test('primaryGradient should have correct colors', () {
        expect(LinfaColors.primaryGradient.colors, [
          LinfaColors.primaryLight,
          LinfaColors.primary,
          LinfaColors.primaryDark,
        ]);
      });

      test('heroGradient should have correct colors', () {
        expect(LinfaColors.heroGradient.colors, [
          const Color(0xFFA8E063),
          const Color(0xFF56AB2F),
        ]);
      });
    });
  });
}
