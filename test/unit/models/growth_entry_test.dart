import 'package:flutter_test/flutter_test.dart';
import 'package:isar/isar.dart';
import 'package:linfa/data/models/growth_entry.dart';
import 'package:linfa/data/models/plant.dart';

void main() {
  group('GrowthEntry', () {
    group('default values', () {
      test('should have auto-increment id', () {
        final entry = GrowthEntry();
        expect(entry.id, Isar.autoIncrement);
      });

      test('should have entryType photo by default', () {
        final entry = GrowthEntry();
        expect(entry.entryType, 'photo');
      });

      test('should have null photoPath by default', () {
        final entry = GrowthEntry();
        expect(entry.photoPath, isNull);
      });

      test('should have null heightCm by default', () {
        final entry = GrowthEntry();
        expect(entry.heightCm, isNull);
      });

      test('should have null newLeaves by default', () {
        final entry = GrowthEntry();
        expect(entry.newLeaves, isNull);
      });

      test('should have null healthRating by default', () {
        final entry = GrowthEntry();
        expect(entry.healthRating, isNull);
      });

      test('should have null notes by default', () {
        final entry = GrowthEntry();
        expect(entry.notes, isNull);
      });

      test('should have empty plant link', () {
        final entry = GrowthEntry();
        expect(entry.plant, isNotNull);
      });
    });

    group('copyWith', () {
      test('should return same values when no arguments provided', () {
        final now = DateTime.now();
        final entry = GrowthEntry()
          ..id = 1
          ..date = now
          ..entryType = 'photo';

        final copy = entry.copyWith();

        expect(copy.id, entry.id);
        expect(copy.date, entry.date);
        expect(copy.entryType, entry.entryType);
      });

      test('should update all fields when provided', () {
        final now = DateTime.now();
        final entry = GrowthEntry()
          ..id = 1
          ..date = now;

        final copy = entry.copyWith(
          id: 2,
          date: now.add(const Duration(days: 1)),
          photoPath: '/path/photo.jpg',
          heightCm: 50.5,
          newLeaves: 5,
          healthRating: 4,
          notes: 'Growing well',
          entryType: 'measurement',
        );

        expect(copy.id, 2);
        expect(copy.photoPath, '/path/photo.jpg');
        expect(copy.heightCm, 50.5);
        expect(copy.newLeaves, 5);
        expect(copy.healthRating, 4);
        expect(copy.notes, 'Growing well');
        expect(copy.entryType, 'measurement');
      });

      test('should not modify original entry', () {
        final now = DateTime.now();
        final entry = GrowthEntry()
          ..entryType = 'original'
          ..date = now;
        entry.copyWith(entryType: 'modified');
        expect(entry.entryType, 'original');
      });
    });

    group('toJson', () {
      test('should serialize all fields', () {
        final now = DateTime(2024, 3, 15);
        final plant = Plant()
          ..id = 1
          ..name = 'Monstera'
          ..createdAt = now;
        final entry = GrowthEntry()
          ..id = 1
          ..date = now
          ..photoPath = '/photos/entry1.jpg'
          ..heightCm = 45.5
          ..newLeaves = 3
          ..healthRating = 4
          ..notes = 'Growing nicely'
          ..entryType = 'measurement';
        entry.plant.value = plant;

        final json = entry.toJson();

        expect(json['id'], 1);
        expect(json['date'], now.toIso8601String());
        expect(json['photoPath'], '/photos/entry1.jpg');
        expect(json['heightCm'], 45.5);
        expect(json['newLeaves'], 3);
        expect(json['healthRating'], 4);
        expect(json['notes'], 'Growing nicely');
        expect(json['entryType'], 'measurement');
        expect(json['plantId'], 1);
      });

      test('should handle null optional fields', () {
        final now = DateTime.now();
        final entry = GrowthEntry()
          ..id = 1
          ..date = now;

        final json = entry.toJson();

        expect(json['photoPath'], isNull);
        expect(json['heightCm'], isNull);
        expect(json['newLeaves'], isNull);
        expect(json['healthRating'], isNull);
        expect(json['notes'], isNull);
        expect(json['plantId'], isNull);
      });
    });

    group('fromJson', () {
      test('should deserialize all fields', () {
        final now = DateTime(2024, 3, 15);
        final json = {
          'id': 1,
          'date': now.toIso8601String(),
          'photoPath': '/photos/entry1.jpg',
          'heightCm': 45.5,
          'newLeaves': 3,
          'healthRating': 4,
          'notes': 'Growing nicely',
          'entryType': 'measurement',
        };

        final entry = GrowthEntry.fromJson(json);

        expect(entry.id, 1);
        expect(entry.date, now);
        expect(entry.photoPath, '/photos/entry1.jpg');
        expect(entry.heightCm, 45.5);
        expect(entry.newLeaves, 3);
        expect(entry.healthRating, 4);
        expect(entry.notes, 'Growing nicely');
        expect(entry.entryType, 'measurement');
      });

      test('should use default date when null', () {
        final before = DateTime.now();
        final json = <String, dynamic>{};

        final entry = GrowthEntry.fromJson(json);

        expect(
            entry.date.isAfter(before) || entry.date.isAtSameMomentAs(before),
            true);
      });

      test('should use default entryType when null', () {
        final json = <String, dynamic>{
          'date': DateTime.now().toIso8601String(),
        };

        final entry = GrowthEntry.fromJson(json);

        expect(entry.entryType, 'photo');
      });

      test('should handle null optional fields', () {
        final json = {
          'id': 1,
          'date': DateTime.now().toIso8601String(),
          'photoPath': null,
          'heightCm': null,
          'newLeaves': null,
          'healthRating': null,
          'notes': null,
        };

        final entry = GrowthEntry.fromJson(json);

        expect(entry.photoPath, isNull);
        expect(entry.heightCm, isNull);
        expect(entry.newLeaves, isNull);
        expect(entry.healthRating, isNull);
        expect(entry.notes, isNull);
      });

      test('should handle heightCm as int', () {
        final json = {
          'id': 1,
          'date': DateTime.now().toIso8601String(),
          'heightCm': 45,
        };

        final entry = GrowthEntry.fromJson(json);

        expect(entry.heightCm, 45.0);
      });
    });

    group('round-trip serialization', () {
      test('should preserve all fields through toJson and fromJson', () {
        final now = DateTime(2024, 3, 15);
        final original = GrowthEntry()
          ..id = 42
          ..date = now
          ..photoPath = '/photos/test.jpg'
          ..heightCm = 60.0
          ..newLeaves = 7
          ..healthRating = 5
          ..notes = 'Excellent growth'
          ..entryType = 'note';

        final json = original.toJson();
        final restored = GrowthEntry.fromJson(json);

        expect(restored.id, original.id);
        expect(restored.date, original.date);
        expect(restored.photoPath, original.photoPath);
        expect(restored.heightCm, original.heightCm);
        expect(restored.newLeaves, original.newLeaves);
        expect(restored.healthRating, original.healthRating);
        expect(restored.notes, original.notes);
        expect(restored.entryType, original.entryType);
      });
    });
  });
}
