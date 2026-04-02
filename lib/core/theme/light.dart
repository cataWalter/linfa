import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';
import 'typography.dart';

/// Light theme for Linfa
ThemeData getLightTheme() {
  final base = ThemeData.light(useMaterial3: true);

  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      seedColor: LinfaColors.primary,
      brightness: Brightness.light,
    ),
    scaffoldBackgroundColor: LinfaColors.backgroundLight,
    appBarTheme: AppBarTheme(
      backgroundColor: LinfaColors.surfaceLight,
      foregroundColor: LinfaColors.textPrimaryLight,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: LinfaTypography.getHeadlineSmall().copyWith(
        color: LinfaColors.textPrimaryLight,
        fontWeight: FontWeight.w600,
      ),
      iconTheme: const IconThemeData(color: LinfaColors.textPrimaryLight),
    ),
    cardTheme: CardThemeData(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      color: LinfaColors.surfaceLight,
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
        foregroundColor: LinfaColors.primary,
        textStyle: LinfaTypography.getLabelLarge(),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey.shade50,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade300),
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
      backgroundColor: LinfaColors.surfaceLight,
      selectedItemColor: LinfaColors.primary,
      unselectedItemColor: LinfaColors.textSecondaryLight,
      type: BottomNavigationBarType.fixed,
      elevation: 8,
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: LinfaColors.surfaceLight,
      indicatorColor: LinfaColors.primaryLight.withOpacity(0.2),
      labelTextStyle: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return LinfaTypography.getLabelMedium().copyWith(
            color: LinfaColors.primary,
            fontWeight: FontWeight.w600,
          );
        }
        return LinfaTypography.getLabelMedium().copyWith(
          color: LinfaColors.textSecondaryLight,
        );
      }),
      iconTheme: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const IconThemeData(color: LinfaColors.primary);
        }
        return const IconThemeData(color: LinfaColors.textSecondaryLight);
      }),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: Colors.grey.shade100,
      selectedColor: LinfaColors.primaryLight.withOpacity(0.3),
      labelStyle: LinfaTypography.getLabelMedium(),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    dividerTheme: DividerThemeData(
      color: Colors.grey.shade200,
      thickness: 1,
      space: 1,
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return LinfaColors.primary;
        }
        return Colors.grey.shade400;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return LinfaColors.primaryLight;
        }
        return Colors.grey.shade300;
      }),
    ),
    textTheme: base.textTheme,
  );
}
