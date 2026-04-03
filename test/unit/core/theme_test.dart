import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:linfa/core/theme/light.dart';
import 'package:linfa/core/theme/dark.dart';
import 'package:linfa/core/theme/typography.dart';

void main() {
  group('LinfaTypography', () {
    group('Display styles', () {
      test('getDisplayLarge should return correct style', () {
        final style = LinfaTypography.getDisplayLarge();
        expect(style.fontSize, 57);
        expect(style.fontWeight, FontWeight.w700);
        expect(style.fontFamily, 'Roboto');
      });

      test('getDisplayMedium should return correct style', () {
        final style = LinfaTypography.getDisplayMedium();
        expect(style.fontSize, 45);
        expect(style.fontWeight, FontWeight.w700);
      });

      test('getDisplaySmall should return correct style', () {
        final style = LinfaTypography.getDisplaySmall();
        expect(style.fontSize, 36);
        expect(style.fontWeight, FontWeight.w600);
      });
    });

    group('Headline styles', () {
      test('getHeadlineLarge should return correct style', () {
        final style = LinfaTypography.getHeadlineLarge();
        expect(style.fontSize, 32);
        expect(style.fontWeight, FontWeight.w600);
      });

      test('getHeadlineMedium should return correct style', () {
        final style = LinfaTypography.getHeadlineMedium();
        expect(style.fontSize, 28);
        expect(style.fontWeight, FontWeight.w600);
      });

      test('getHeadlineSmall should return correct style', () {
        final style = LinfaTypography.getHeadlineSmall();
        expect(style.fontSize, 24);
        expect(style.fontWeight, FontWeight.w600);
      });
    });

    group('Title styles', () {
      test('getTitleLarge should return correct style', () {
        final style = LinfaTypography.getTitleLarge();
        expect(style.fontSize, 22);
        expect(style.fontWeight, FontWeight.w600);
      });

      test('getTitleMedium should return correct style', () {
        final style = LinfaTypography.getTitleMedium();
        expect(style.fontSize, 16);
        expect(style.fontWeight, FontWeight.w600);
      });

      test('getTitleSmall should return correct style', () {
        final style = LinfaTypography.getTitleSmall();
        expect(style.fontSize, 14);
        expect(style.fontWeight, FontWeight.w600);
      });
    });

    group('Body styles', () {
      test('getBodyLarge should return correct style', () {
        final style = LinfaTypography.getBodyLarge();
        expect(style.fontSize, 16);
        expect(style.fontWeight, FontWeight.w400);
      });

      test('getBodyMedium should return correct style', () {
        final style = LinfaTypography.getBodyMedium();
        expect(style.fontSize, 14);
        expect(style.fontWeight, FontWeight.w400);
      });

      test('getBodySmall should return correct style', () {
        final style = LinfaTypography.getBodySmall();
        expect(style.fontSize, 12);
        expect(style.fontWeight, FontWeight.w400);
      });
    });

    group('Label styles', () {
      test('getLabelLarge should return correct style', () {
        final style = LinfaTypography.getLabelLarge();
        expect(style.fontSize, 14);
        expect(style.fontWeight, FontWeight.w500);
      });

      test('getLabelMedium should return correct style', () {
        final style = LinfaTypography.getLabelMedium();
        expect(style.fontSize, 12);
        expect(style.fontWeight, FontWeight.w500);
      });

      test('getLabelSmall should return correct style', () {
        final style = LinfaTypography.getLabelSmall();
        expect(style.fontSize, 11);
        expect(style.fontWeight, FontWeight.w500);
      });
    });
  });

  group('Light Theme', () {
    testWidgets('getLightTheme should return ThemeData', (tester) async {
      final theme = getLightTheme();
      expect(theme, isA<ThemeData>());
      expect(theme.brightness, Brightness.light);
      expect(theme.useMaterial3, true);
    });

    testWidgets('getLightTheme should have correct scaffold background',
        (tester) async {
      final theme = getLightTheme();
      expect(theme.scaffoldBackgroundColor, const Color(0xFFFAFAFA));
    });
  });

  group('Dark Theme', () {
    testWidgets('getDarkTheme should return ThemeData', (tester) async {
      final theme = getDarkTheme();
      expect(theme, isA<ThemeData>());
      expect(theme.brightness, Brightness.dark);
      expect(theme.useMaterial3, true);
    });

    testWidgets('getDarkTheme should have correct scaffold background',
        (tester) async {
      final theme = getDarkTheme();
      expect(theme.scaffoldBackgroundColor, const Color(0xFF121212));
    });
  });
}
