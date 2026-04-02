import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../core/constants/enums.dart';

/// Theme provider for managing app theme
class ThemeNotifier extends StateNotifier<AppThemeMode> {
  ThemeNotifier() : super(AppThemeMode.system);

  static const String _themeBoxName = 'theme_settings';
  static const String _themeKey = 'app_theme';

  Box? _box;

  /// Initialize Hive box
  Future<void> init() async {
    try {
      _box = await Hive.openBox(_themeBoxName);
      _loadTheme();
    } catch (e) {
      // If Hive box fails to open, use default theme
      _box = null;
    }
  }

  /// Load saved theme
  void _loadTheme() {
    if (_box == null) return;
    try {
      final savedTheme = _box!.get(_themeKey, defaultValue: 'system');
      state = AppThemeMode.values.firstWhere(
        (e) => e.name == savedTheme,
        orElse: () => AppThemeMode.system,
      );
    } catch (e) {
      // If loading fails, use default theme
      state = AppThemeMode.system;
    }
  }

  /// Save theme to Hive
  Future<void> _saveTheme(AppThemeMode theme) async {
    if (_box == null) return;
    try {
      await _box!.put(_themeKey, theme.name);
    } catch (e) {
      // Ignore save errors
    }
  }

  /// Set theme
  Future<void> setTheme(AppThemeMode theme) async {
    state = theme;
    await _saveTheme(theme);
  }

  /// Get ThemeData based on current theme mode
  ThemeData getThemeData(Brightness brightness) {
    // This will be handled by the app widget
    return ThemeData.light();
  }

  /// Get current brightness
  Brightness getBrightness() {
    switch (state) {
      case AppThemeMode.light:
        return Brightness.light;
      case AppThemeMode.dark:
        return Brightness.dark;
      case AppThemeMode.system:
        return WidgetsBinding.instance.platformDispatcher.platformBrightness;
    }
  }
}

final themeProvider = StateNotifierProvider<ThemeNotifier, AppThemeMode>((ref) {
  final notifier = ThemeNotifier();
  // Initialize asynchronously
  notifier.init();
  return notifier;
});
