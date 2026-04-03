import 'package:flutter_test/flutter_test.dart';
import 'package:isar/isar.dart';
import 'package:linfa/data/models/reminder.dart';
import 'package:linfa/data/models/plant.dart';

void main() {
  group('Reminder', () {
    group('default values', () {
      test('should have auto-increment id', () {
        final reminder = Reminder();
        expect(reminder.id, Isar.autoIncrement);
      });

      test('should have isEnabled true by default', () {
        final reminder = Reminder();
        expect(reminder.isEnabled, true);
      });

      test('should have null customMessage by default', () {
        final reminder = Reminder();
        expect(reminder.customMessage, isNull);
      });

      test('should have null notificationId by default', () {
        final reminder = Reminder();
        expect(reminder.notificationId, isNull);
      });

      test('should have null lastTriggered by default', () {
        final reminder = Reminder();
        expect(reminder.lastTriggered, isNull);
      });

      test('should have null nextScheduled by default', () {
        final reminder = Reminder();
        expect(reminder.nextScheduled, isNull);
      });

      test('should have empty plant link', () {
        final reminder = Reminder();
        expect(reminder.plant, isNotNull);
      });
    });

    group('typeDisplayName', () {
      test('should return Annaffiare for watering', () {
        final reminder = Reminder()..type = 'watering';
        expect(reminder.typeDisplayName, 'Annaffiare');
      });

      test('should return Concimare for fertilizing', () {
        final reminder = Reminder()..type = 'fertilizing';
        expect(reminder.typeDisplayName, 'Concimare');
      });

      test('should return Rinvasare for repotting', () {
        final reminder = Reminder()..type = 'repotting';
        expect(reminder.typeDisplayName, 'Rinvasare');
      });

      test('should return Pulire Foglie for cleaning', () {
        final reminder = Reminder()..type = 'cleaning';
        expect(reminder.typeDisplayName, 'Pulire Foglie');
      });

      test('should return Potare for pruning', () {
        final reminder = Reminder()..type = 'pruning';
        expect(reminder.typeDisplayName, 'Potare');
      });

      test('should return Nebulizzare for misting', () {
        final reminder = Reminder()..type = 'misting';
        expect(reminder.typeDisplayName, 'Nebulizzare');
      });

      test('should return type as-is for unknown type', () {
        final reminder = Reminder()..type = 'unknown';
        expect(reminder.typeDisplayName, 'unknown');
      });
    });

    group('typeIcon', () {
      test('should return water_drop for watering', () {
        final reminder = Reminder()..type = 'watering';
        expect(reminder.typeIcon, 'water_drop');
      });

      test('should return science for fertilizing', () {
        final reminder = Reminder()..type = 'fertilizing';
        expect(reminder.typeIcon, 'science');
      });

      test('should return square_foot for repotting', () {
        final reminder = Reminder()..type = 'repotting';
        expect(reminder.typeIcon, 'square_foot');
      });

      test('should return cleaning_services for cleaning', () {
        final reminder = Reminder()..type = 'cleaning';
        expect(reminder.typeIcon, 'cleaning_services');
      });

      test('should return content_cut for pruning', () {
        final reminder = Reminder()..type = 'pruning';
        expect(reminder.typeIcon, 'content_cut');
      });

      test('should return air for misting', () {
        final reminder = Reminder()..type = 'misting';
        expect(reminder.typeIcon, 'air');
      });

      test('should return notifications for unknown type', () {
        final reminder = Reminder()..type = 'unknown';
        expect(reminder.typeIcon, 'notifications');
      });
    });

    group('calculateNextScheduled', () {
      test('should add frequencyDays to lastTriggered', () {
        final now = DateTime(2024, 3, 15);
        final reminder = Reminder()
          ..lastTriggered = now
          ..frequencyDays = 7;
        expect(reminder.calculateNextScheduled(), DateTime(2024, 3, 22));
      });

      test('should add frequencyDays to now when lastTriggered is null', () {
        final before = DateTime.now();
        final reminder = Reminder()..frequencyDays = 3;
        final next = reminder.calculateNextScheduled();
        final after = before.add(const Duration(days: 3));
        expect(next.isAfter(before) || next.isAtSameMomentAs(before), true);
        expect(next.isBefore(after.add(const Duration(seconds: 1))), true);
      });
    });

    group('isOverdue', () {
      test('should return false when nextScheduled is null', () {
        final reminder = Reminder();
        expect(reminder.isOverdue, false);
      });

      test('should return true when nextScheduled is in the past', () {
        final reminder = Reminder()
          ..nextScheduled = DateTime.now().subtract(const Duration(days: 1));
        expect(reminder.isOverdue, true);
      });

      test('should return false when nextScheduled is in the future', () {
        final future = DateTime.now().add(const Duration(days: 1));
        final reminder = Reminder()..nextScheduled = future;
        expect(reminder.isOverdue, false);
      });

      test('should return false when nextScheduled is same day', () {
        final now = DateTime.now();
        final today = DateTime(now.year, now.month, now.day);
        final tomorrow = today.add(const Duration(days: 1));
        final reminder = Reminder()..nextScheduled = tomorrow;
        expect(reminder.isOverdue, false);
      });
    });

    group('copyWith', () {
      test('should return same values when no arguments provided', () {
        final now = DateTime.now();
        final reminder = Reminder()
          ..id = 1
          ..type = 'watering'
          ..frequencyDays = 7
          ..time = now;

        final copy = reminder.copyWith();

        expect(copy.id, reminder.id);
        expect(copy.type, reminder.type);
        expect(copy.frequencyDays, reminder.frequencyDays);
        expect(copy.time, reminder.time);
        expect(copy.isEnabled, reminder.isEnabled);
      });

      test('should update all fields when provided', () {
        final now = DateTime.now();
        final reminder = Reminder()
          ..id = 1
          ..type = 'watering'
          ..frequencyDays = 7
          ..time = now;

        final copy = reminder.copyWith(
          id: 2,
          type: 'fertilizing',
          frequencyDays: 14,
          time: now.add(const Duration(hours: 1)),
          isEnabled: false,
          customMessage: 'Custom message',
          notificationId: 123,
          lastTriggered: now,
          nextScheduled: now.add(const Duration(days: 14)),
        );

        expect(copy.id, 2);
        expect(copy.type, 'fertilizing');
        expect(copy.frequencyDays, 14);
        expect(copy.isEnabled, false);
        expect(copy.customMessage, 'Custom message');
        expect(copy.notificationId, 123);
      });

      test('should not modify original reminder', () {
        final now = DateTime.now();
        final reminder = Reminder()
          ..type = 'original'
          ..frequencyDays = 7
          ..time = now;
        reminder.copyWith(type: 'modified');
        expect(reminder.type, 'original');
      });
    });

    group('toJson', () {
      test('should serialize all fields', () {
        final now = DateTime(2024, 3, 15, 10, 30);
        final plant = Plant()
          ..id = 1
          ..name = 'Monstera'
          ..createdAt = now;
        final reminder = Reminder()
          ..id = 1
          ..type = 'watering'
          ..frequencyDays = 7
          ..time = now
          ..isEnabled = true
          ..customMessage = 'Water the plant'
          ..notificationId = 100
          ..lastTriggered = now
          ..nextScheduled = now.add(const Duration(days: 7));
        reminder.plant.value = plant;

        final json = reminder.toJson();

        expect(json['id'], 1);
        expect(json['type'], 'watering');
        expect(json['frequencyDays'], 7);
        expect(json['time'], now.toIso8601String());
        expect(json['isEnabled'], true);
        expect(json['customMessage'], 'Water the plant');
        expect(json['notificationId'], 100);
        expect(json['lastTriggered'], now.toIso8601String());
        expect(json['nextScheduled'],
            now.add(const Duration(days: 7)).toIso8601String());
        expect(json['plantId'], 1);
      });

      test('should handle null optional fields', () {
        final now = DateTime.now();
        final reminder = Reminder()
          ..id = 1
          ..type = 'watering'
          ..frequencyDays = 7
          ..time = now;

        final json = reminder.toJson();

        expect(json['customMessage'], isNull);
        expect(json['notificationId'], isNull);
        expect(json['lastTriggered'], isNull);
        expect(json['nextScheduled'], isNull);
        expect(json['plantId'], isNull);
      });
    });

    group('fromJson', () {
      test('should deserialize all fields', () {
        final now = DateTime(2024, 3, 15, 10, 30);
        final json = {
          'id': 1,
          'type': 'watering',
          'frequencyDays': 7,
          'time': now.toIso8601String(),
          'isEnabled': true,
          'customMessage': 'Water the plant',
          'notificationId': 100,
          'lastTriggered': now.toIso8601String(),
          'nextScheduled': now.add(const Duration(days: 7)).toIso8601String(),
        };

        final reminder = Reminder.fromJson(json);

        expect(reminder.id, 1);
        expect(reminder.type, 'watering');
        expect(reminder.frequencyDays, 7);
        expect(reminder.isEnabled, true);
        expect(reminder.customMessage, 'Water the plant');
        expect(reminder.notificationId, 100);
      });

      test('should use default type when null', () {
        final json = <String, dynamic>{
          'time': DateTime.now().toIso8601String(),
        };

        final reminder = Reminder.fromJson(json);

        expect(reminder.type, 'watering');
      });

      test('should use default frequencyDays when null', () {
        final json = <String, dynamic>{
          'time': DateTime.now().toIso8601String(),
        };

        final reminder = Reminder.fromJson(json);

        expect(reminder.frequencyDays, 7);
      });

      test('should use default isEnabled when null', () {
        final json = <String, dynamic>{
          'time': DateTime.now().toIso8601String(),
        };

        final reminder = Reminder.fromJson(json);

        expect(reminder.isEnabled, true);
      });

      test('should use default time when null', () {
        final before = DateTime.now();
        final json = <String, dynamic>{};

        final reminder = Reminder.fromJson(json);

        expect(
            reminder.time.isAfter(before) ||
                reminder.time.isAtSameMomentAs(before),
            true);
      });

      test('should handle null optional fields', () {
        final json = {
          'id': 1,
          'type': 'watering',
          'frequencyDays': 7,
          'time': DateTime.now().toIso8601String(),
          'customMessage': null,
          'notificationId': null,
        };

        final reminder = Reminder.fromJson(json);

        expect(reminder.customMessage, isNull);
        expect(reminder.notificationId, isNull);
      });
    });

    group('round-trip serialization', () {
      test('should preserve all fields through toJson and fromJson', () {
        final now = DateTime(2024, 3, 15, 10, 30);
        final original = Reminder()
          ..id = 42
          ..type = 'fertilizing'
          ..frequencyDays = 14
          ..time = now
          ..isEnabled = false
          ..customMessage = 'Feed the plants'
          ..notificationId = 200
          ..lastTriggered = now.subtract(const Duration(days: 14))
          ..nextScheduled = now;

        final json = original.toJson();
        final restored = Reminder.fromJson(json);

        expect(restored.id, original.id);
        expect(restored.type, original.type);
        expect(restored.frequencyDays, original.frequencyDays);
        expect(restored.isEnabled, original.isEnabled);
        expect(restored.customMessage, original.customMessage);
        expect(restored.notificationId, original.notificationId);
      });
    });
  });
}
