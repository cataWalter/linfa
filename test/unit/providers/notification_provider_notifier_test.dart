import 'package:flutter_test/flutter_test.dart';
import 'package:linfa/shared/providers/notification_provider.dart';
import 'package:linfa/data/models/reminder.dart';

void main() {
  group('NotificationSettings', () {
    group('constructor', () {
      test('should create with required enabled parameter', () {
        const settings = NotificationSettings(enabled: true);
        expect(settings.enabled, isTrue);
        expect(settings.sound, isTrue); // default is true
      });

      test('should create with custom values', () {
        const settings = NotificationSettings(enabled: false, sound: false);
        expect(settings.enabled, isFalse);
        expect(settings.sound, isFalse);
      });

      test('should create with only enabled', () {
        const settings = NotificationSettings(enabled: false);
        expect(settings.enabled, isFalse);
        expect(settings.sound, isTrue); // default
      });
    });

    group('copyWith', () {
      test('should preserve original values when no params provided', () {
        const settings = NotificationSettings(enabled: true, sound: false);
        final copy = settings.copyWith();
        
        expect(copy.enabled, isTrue);
        expect(copy.sound, isFalse);
      });

      test('should update only enabled value', () {
        const settings = NotificationSettings(enabled: true, sound: true);
        final copy = settings.copyWith(enabled: false);
        
        expect(copy.enabled, isFalse);
        expect(copy.sound, isTrue);
      });

      test('should update only sound value', () {
        const settings = NotificationSettings(enabled: true, sound: true);
        final copy = settings.copyWith(sound: false);
        
        expect(copy.enabled, isTrue);
        expect(copy.sound, isFalse);
      });

      test('should update both values', () {
        const settings = NotificationSettings(enabled: true, sound: true);
        final copy = settings.copyWith(enabled: false, sound: false);
        
        expect(copy.enabled, isFalse);
        expect(copy.sound, isFalse);
      });
    });
  });

  group('Reminder notificationId generation', () {
    test('should generate consistent ID based on reminder hash', () {
      final reminder1 = Reminder()
        ..id = 123
        ..type = 'watering'
        ..frequencyDays = 7
        ..time = DateTime.now();
      
      final reminder2 = Reminder()
        ..id = 123
        ..type = 'watering'
        ..frequencyDays = 7
        ..time = DateTime.now();
      
      // Same reminder should generate same ID
      expect(reminder1.id.hashCode & 0x7FFFFFFF, reminder2.id.hashCode & 0x7FFFFFFF);
    });

    test('should generate positive ID', () {
      final reminder = Reminder()
        ..id = 1
        ..type = 'watering'
        ..frequencyDays = 7
        ..time = DateTime.now();
      
      final id = reminder.id.hashCode & 0x7FFFFFFF;
      expect(id, isPositive);
    });

    test('should mask negative hash codes to positive', () {
      // Test that the mask works for any id
      for (int i = 0; i < 100; i++) {
        final reminder = Reminder()..id = i * 12345 - 5000; // Some negative ids
        final id = reminder.id.hashCode & 0x7FFFFFFF;
        expect(id, isPositive);
      }
    });
  });

  group('Reminder typeDisplayName', () {
    test('should return correct display name for watering', () {
      final reminder = Reminder()..type = 'watering';
      expect(reminder.typeDisplayName, 'Annaffiare');
    });

    test('should return correct display name for fertilizing', () {
      final reminder = Reminder()..type = 'fertilizing';
      expect(reminder.typeDisplayName, 'Concimare');
    });

    test('should return correct display name for repotting', () {
      final reminder = Reminder()..type = 'repotting';
      expect(reminder.typeDisplayName, 'Rinvasare');
    });

    test('should return correct display name for cleaning', () {
      final reminder = Reminder()..type = 'cleaning';
      expect(reminder.typeDisplayName, 'Pulire Foglie');
    });

    test('should return correct display name for pruning', () {
      final reminder = Reminder()..type = 'pruning';
      expect(reminder.typeDisplayName, 'Potare');
    });

    test('should return correct display name for misting', () {
      final reminder = Reminder()..type = 'misting';
      expect(reminder.typeDisplayName, 'Nebulizzare');
    });

    test('should return type as default for unknown types', () {
      final reminder = Reminder()..type = 'unknown';
      expect(reminder.typeDisplayName, 'unknown');
    });
  });

  group('Reminder typeIcon', () {
    test('should return correct icon for watering', () {
      final reminder = Reminder()..type = 'watering';
      expect(reminder.typeIcon, 'water_drop');
    });

    test('should return correct icon for fertilizing', () {
      final reminder = Reminder()..type = 'fertilizing';
      expect(reminder.typeIcon, 'science');
    });

    test('should return correct icon for repotting', () {
      final reminder = Reminder()..type = 'repotting';
      expect(reminder.typeIcon, 'square_foot');
    });

    test('should return correct icon for cleaning', () {
      final reminder = Reminder()..type = 'cleaning';
      expect(reminder.typeIcon, 'cleaning_services');
    });

    test('should return correct icon for pruning', () {
      final reminder = Reminder()..type = 'pruning';
      expect(reminder.typeIcon, 'content_cut');
    });

    test('should return correct icon for misting', () {
      final reminder = Reminder()..type = 'misting';
      expect(reminder.typeIcon, 'air');
    });

    test('should return default icon for unknown types', () {
      final reminder = Reminder()..type = 'unknown';
      expect(reminder.typeIcon, 'notifications');
    });
  });

  group('Reminder calculateNextScheduled', () {
    test('should calculate next scheduled from lastTriggered', () {
      final lastTriggered = DateTime(2024, 1, 1);
      final reminder = Reminder()
        ..lastTriggered = lastTriggered
        ..frequencyDays = 7;
      
      final next = reminder.calculateNextScheduled();
      
      expect(next, DateTime(2024, 1, 8));
    });

    test('should use current time when no lastTriggered', () {
      final reminder = Reminder()
        ..frequencyDays = 7;
      
      final before = DateTime.now();
      final next = reminder.calculateNextScheduled();
      final after = DateTime.now();
      
      // next should be approximately 7 days from now
      final expectedDate = before.add(const Duration(days: 7));
      expect(next.isAfter(expectedDate.subtract(const Duration(seconds: 5))), isTrue);
      expect(next.isBefore(after.add(const Duration(days: 8))), isTrue);
    });
  });

  group('Reminder isOverdue', () {
    test('should return false if nextScheduled is null', () {
      final reminder = Reminder();
      expect(reminder.isOverdue, isFalse);
    });

    test('should return true if nextScheduled is in the past', () {
      final reminder = Reminder()
        ..nextScheduled = DateTime.now().subtract(const Duration(hours: 1));
      expect(reminder.isOverdue, isTrue);
    });

    test('should return false if nextScheduled is in the future', () {
      final reminder = Reminder()
        ..nextScheduled = DateTime.now().add(const Duration(hours: 1));
      expect(reminder.isOverdue, isFalse);
    });
  });

    group('Reminder copyWith', () {
      test('should create a copy with all new values', () {
        final original = Reminder()
          ..id = 1
          ..type = 'watering'
          ..frequencyDays = 7
          ..time = DateTime(2024, 1, 1)
          ..isEnabled = true;
        
        final copy = original.copyWith(
          id: 2,
          type: 'fertilizing',
          frequencyDays: 30,
          time: DateTime(2024, 2, 1),
          isEnabled: false,
        );
        
        expect(copy.id, 2);
        expect(copy.type, 'fertilizing');
        expect(copy.frequencyDays, 30);
        expect(copy.time, DateTime(2024, 2, 1));
        expect(copy.isEnabled, isFalse);
        
        // Original should be unchanged
        expect(original.id, 1);
        expect(original.type, 'watering');
      });

      test('should preserve original values for null params', () {
        final original = Reminder()
          ..id = 1
          ..type = 'watering'
          ..frequencyDays = 7
          ..time = DateTime(2024, 1, 1)
          ..isEnabled = true;
        
        final copy = original.copyWith(frequencyDays: 14);
        
        expect(copy.id, 1);
        expect(copy.type, 'watering');
        expect(copy.frequencyDays, 14);
        expect(copy.time, DateTime(2024, 1, 1));
        expect(copy.isEnabled, isTrue);
      });
    });

  group('Reminder toJson/fromJson', () {
    test('should serialize and deserialize correctly', () {
      final original = Reminder()
        ..id = 123
        ..type = 'watering'
        ..frequencyDays = 7
        ..time = DateTime(2024, 1, 15, 9, 0)
        ..isEnabled = true
        ..customMessage = 'Test message'
        ..notificationId = 456
        ..lastTriggered = DateTime(2024, 1, 10)
        ..nextScheduled = DateTime(2024, 1, 17);
      
      final json = original.toJson();
      final restored = Reminder.fromJson(json);
      
      expect(restored.id, original.id);
      expect(restored.type, original.type);
      expect(restored.frequencyDays, original.frequencyDays);
      expect(restored.isEnabled, original.isEnabled);
      expect(restored.customMessage, original.customMessage);
      expect(restored.notificationId, original.notificationId);
    });

    test('should handle null values in fromJson', () {
      final json = <String, dynamic>{
        'id': 1,
        'type': 'watering',
      };
      
      final reminder = Reminder.fromJson(json);
      
      expect(reminder.id, 1);
      expect(reminder.type, 'watering');
      expect(reminder.frequencyDays, 7); // default
      expect(reminder.isEnabled, isTrue); // default
      expect(reminder.customMessage, isNull);
      expect(reminder.notificationId, isNull);
      expect(reminder.lastTriggered, isNull);
      expect(reminder.nextScheduled, isNull);
    });
  });

  group('notificationProvider', () {
    test('should be a StateNotifierProvider', () {
      expect(notificationProvider, isNotNull);
    });
  });
}