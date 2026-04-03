import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:linfa/shared/providers/theme_provider.dart';
import 'package:linfa/core/constants/enums.dart';

void main() {
  group('AppThemeMode', () {
    test('should have correct display names', () {
      expect(AppThemeMode.system.displayName, 'Sistema');
      expect(AppThemeMode.light.displayName, 'Chiaro');
      expect(AppThemeMode.dark.displayName, 'Scuro');
    });

    test('should have 3 values', () {
      expect(AppThemeMode.values.length, 3);
    });
  });

  group('ThemeNotifier', () {
    late ThemeNotifier notifier;

    setUpAll(() async {
      TestWidgetsFlutterBinding.ensureInitialized();
      Hive.init('test_hive_theme');
    });

    tearDownAll(() async {
      try {
        await Hive.close();
      } catch (_) {}
    });

    setUp(() {
      notifier = ThemeNotifier();
    });

    test('initial state should be system', () {
      expect(notifier.state, AppThemeMode.system);
    });

    test('setTheme should update state to light', () async {
      await notifier.setTheme(AppThemeMode.light);
      expect(notifier.state, AppThemeMode.light);
    });

    test('setTheme should update state to dark', () async {
      await notifier.setTheme(AppThemeMode.dark);
      expect(notifier.state, AppThemeMode.dark);
    });

    test('setTheme should update state to system', () async {
      await notifier.setTheme(AppThemeMode.system);
      expect(notifier.state, AppThemeMode.system);
    });

    test('getThemeData should return ThemeData', () {
      final themeData = notifier.getThemeData(Brightness.light);
      expect(themeData, isA<ThemeData>());
    });

    test('getThemeData for dark should return ThemeData', () {
      final themeData = notifier.getThemeData(Brightness.dark);
      expect(themeData, isA<ThemeData>());
    });
  });

  group('themeProvider', () {
    test('should be defined', () {
      expect(themeProvider, isNotNull);
    });
  });
}
