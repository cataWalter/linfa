import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';
import 'typography.dart';

/// Dark theme for Linfa
ThemeData getDarkTheme() {
  final base = ThemeData.dark(useMaterial3: true);

  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: LinfaColors.primary,
      brightness: Brightness.dark,
    ),
    scaffoldBackgroundColor: LinfaColors.backgroundDark,
    appBarTheme: AppBarTheme(
      backgroundColor: LinfaColors.surfaceDark,
      foregroundColor: LinfaColors.textPrimaryDark,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: LinfaTypography.getHeadlineSmall().copyWith(
        color: LinfaColors.textPrimaryDark,
        fontWeight: FontWeight.w600,
      ),
      iconTheme: const IconThemeData(color: LinfaColors.textPrimaryDark),
    ),
    cardTheme: CardThemeData(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.shade800),
      ),
      color: LinfaColors.surfaceDark,
      clipBehavior: Clip.antiAlias,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: LinfaColors.primary,
      foregroundColor: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: LinfaColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: LinfaTypography.getLabelLarge().copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: LinfaColors.primaryLight,
        textStyle: LinfaTypography.getLabelLarge(),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey.shade900,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade700),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade700),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: LinfaColors.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: LinfaColors.danger),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: LinfaColors.surfaceDark,
      selectedItemColor: LinfaColors.primaryLight,
      unselectedItemColor: LinfaColors.textSecondaryDark,
      type: BottomNavigationBarType.fixed,
      elevation: 8,
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: LinfaColors.surfaceDark,
      indicatorColor: LinfaColors.primaryLight.withOpacity(0.2),
      labelTextStyle: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return LinfaTypography.getLabelMedium().copyWith(
            color: LinfaColors.primaryLight,
            fontWeight: FontWeight.w600,
          );
        }
        return LinfaTypography.getLabelMedium().copyWith(
          color: LinfaColors.textSecondaryDark,
        );
      }),
      iconTheme: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const IconThemeData(color: LinfaColors.primaryLight);
        }
        return const IconThemeData(color: LinfaColors.textSecondaryDark);
      }),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: Colors.grey.shade800,
      selectedColor: LinfaColors.primaryLight.withOpacity(0.3),
      labelStyle: LinfaTypography.getLabelMedium(),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    dividerTheme: DividerThemeData(
      color: Colors.grey.shade800,
      thickness: 1,
      space: 1,
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return LinfaColors.primary;
        }
        return Colors.grey.shade600;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return LinfaColors.primaryDark;
        }
        return Colors.grey.shade700;
      }),
    ),
    textTheme: base.textTheme,
  );
}
