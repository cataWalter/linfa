import 'package:flutter_test/flutter_test.dart';
import 'package:linfa/core/constants/colors.dart';
import 'package:linfa/core/constants/routes.dart';
import 'package:linfa/core/constants/strings.dart';
import 'package:linfa/core/constants/enums.dart';

void main() {
  group('LinfaColors', () {
    test('should have correct primary colors', () {
      expect(LinfaColors.primary.value, 0xFF4CAF50);
      expect(LinfaColors.primaryLight.value, 0xFF81C784);
      expect(LinfaColors.primaryDark.value, 0xFF388E3C);
    });

    test('should have correct secondary colors', () {
      expect(LinfaColors.secondary.value, 0xFF8D6E63);
      expect(LinfaColors.secondaryLight.value, 0xFFBCAAA4);
      expect(LinfaColors.secondaryDark.value, 0xFF5D4037);
    });

    test('should have correct accent colors', () {
      expect(LinfaColors.accent.value, 0xFF4FC3F7);
      expect(LinfaColors.accentLight.value, 0xFF81D4FA);
      expect(LinfaColors.accentDark.value, 0xFF0288D1);
    });

    test('should have correct status colors', () {
      expect(LinfaColors.healthy.value, 0xFF66BB6A);
      expect(LinfaColors.warning.value, 0xFFFFA726);
      expect(LinfaColors.danger.value, 0xFFEF5350);
      expect(LinfaColors.dormant.value, 0xFFBDBDBD);
    });

    test('should have correct background colors', () {
      expect(LinfaColors.backgroundLight.value, 0xFFFAFAFA);
      expect(LinfaColors.surfaceLight.value, 0xFFFFFFFF);
      expect(LinfaColors.backgroundDark.value, 0xFF121212);
      expect(LinfaColors.surfaceDark.value, 0xFF1E1E1E);
    });

    test('should have correct text colors', () {
      expect(LinfaColors.textPrimaryLight.value, 0xFF212121);
      expect(LinfaColors.textSecondaryLight.value, 0xFF757575);
      expect(LinfaColors.textPrimaryDark.value, 0xFFFAFAFA);
      expect(LinfaColors.textSecondaryDark.value, 0xFFBDBDBD);
    });

    test('should have correct reminder type colors', () {
      expect(LinfaColors.watering.value, 0xFF42A5F5);
      expect(LinfaColors.fertilizing.value, 0xFFAB47BC);
      expect(LinfaColors.repotting.value, 0xFF66BB6A);
      expect(LinfaColors.cleaning.value, 0xFF26C6DA);
      expect(LinfaColors.pruning.value, 0xFFEF5350);
      expect(LinfaColors.misting.value, 0xFF29B6F6);
    });

    test('should have primary gradient', () {
      expect(LinfaColors.primaryGradient, isNotNull);
    });

    test('should have hero gradient', () {
      expect(LinfaColors.heroGradient, isNotNull);
    });
  });

  group('AppRoutes', () {
    test('should have correct route paths', () {
      expect(AppRoutes.home, '/');
      expect(AppRoutes.plants, '/plants');
      expect(AppRoutes.plantDetail, '/plant-detail');
      expect(AppRoutes.addPlant, '/add-plant');
      expect(AppRoutes.editPlant, '/edit-plant');
      expect(AppRoutes.reminders, '/reminders');
      expect(AppRoutes.addReminder, '/add-reminder');
      expect(AppRoutes.editReminder, '/edit-reminder');
      expect(AppRoutes.growth, '/growth');
      expect(AppRoutes.settings, '/settings');
      expect(AppRoutes.exportData, '/export-data');
    });
  });

  group('AppStrings', () {
    test('should have correct app name', () {
      expect(AppStrings.appName, 'Linfa');
      expect(
          AppStrings.appTagline, 'Il Tuo Assistente per le Piante Domestiche');
    });

    test('should have correct navigation strings', () {
      expect(AppStrings.home, 'Home');
      expect(AppStrings.myPlants, 'Le Mie Piante');
      expect(AppStrings.reminders, 'Promemoria');
      expect(AppStrings.settings, 'Impostazioni');
      expect(AppStrings.growth, 'Crescita');
    });

    test('should have correct common strings', () {
      expect(AppStrings.save, 'Salva');
      expect(AppStrings.cancel, 'Annulla');
      expect(AppStrings.delete, 'Elimina');
      expect(AppStrings.edit, 'Modifica');
      expect(AppStrings.add, 'Aggiungi');
      expect(AppStrings.done, 'Fatto');
      expect(AppStrings.ok, 'OK');
      expect(AppStrings.yes, 'Sì');
      expect(AppStrings.no, 'No');
    });
  });
}
