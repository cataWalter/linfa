import 'package:flutter_test/flutter_test.dart';
import 'package:linfa/shared/providers/notification_provider.dart';

void main() {
  group('NotificationSettings', () {
    test('should create with required enabled parameter', () {
      const settings = NotificationSettings(enabled: true);
      expect(settings.enabled, true);
      expect(settings.sound, true);
    });

    test('should create with custom values', () {
      const settings = NotificationSettings(enabled: false, sound: false);
      expect(settings.enabled, false);
      expect(settings.sound, false);
    });

    test('should copy with new enabled value', () {
      const settings = NotificationSettings(enabled: true, sound: true);
      final copy = settings.copyWith(enabled: false);
      expect(copy.enabled, false);
      expect(copy.sound, true);
    });

    test('should copy with new sound value', () {
      const settings = NotificationSettings(enabled: true, sound: true);
      final copy = settings.copyWith(sound: false);
      expect(copy.enabled, true);
      expect(copy.sound, false);
    });

    test('should copy with all new values', () {
      const settings = NotificationSettings(enabled: true, sound: true);
      final copy = settings.copyWith(enabled: false, sound: false);
      expect(copy.enabled, false);
      expect(copy.sound, false);
    });

    test('should copy with no changes return same values', () {
      const settings = NotificationSettings(enabled: true, sound: false);
      final copy = settings.copyWith();
      expect(copy.enabled, true);
      expect(copy.sound, false);
    });
  });

  group('notificationProvider', () {
    test('should be defined', () {
      expect(notificationProvider, isNotNull);
    });
  });
}
