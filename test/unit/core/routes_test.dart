import 'package:flutter_test/flutter_test.dart';
import 'package:linfa/core/constants/routes.dart';

void main() {
  group('AppRoutes', () {
    test('home should be /', () {
      expect(AppRoutes.home, '/');
    });

    test('plants should be /plants', () {
      expect(AppRoutes.plants, '/plants');
    });

    test('plantDetail should be /plant-detail', () {
      expect(AppRoutes.plantDetail, '/plant-detail');
    });

    test('addPlant should be /add-plant', () {
      expect(AppRoutes.addPlant, '/add-plant');
    });

    test('editPlant should be /edit-plant', () {
      expect(AppRoutes.editPlant, '/edit-plant');
    });

    test('reminders should be /reminders', () {
      expect(AppRoutes.reminders, '/reminders');
    });

    test('addReminder should be /add-reminder', () {
      expect(AppRoutes.addReminder, '/add-reminder');
    });

    test('editReminder should be /edit-reminder', () {
      expect(AppRoutes.editReminder, '/edit-reminder');
    });

    test('growth should be /growth', () {
      expect(AppRoutes.growth, '/growth');
    });

    test('settings should be /settings', () {
      expect(AppRoutes.settings, '/settings');
    });

    test('exportData should be /export-data', () {
      expect(AppRoutes.exportData, '/export-data');
    });
  });
}
