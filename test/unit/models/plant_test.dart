import 'package:flutter_test/flutter_test.dart';
import 'package:isar/isar.dart';
import 'package:linfa/data/models/plant.dart';
import 'package:linfa/data/models/reminder.dart';
import 'package:linfa/data/models/growth_entry.dart';

void main() {
  group('Plant', () {
    group('default values', () {
      test('should have auto-increment id', () {
        final plant = Plant();
        expect(plant.id, Isar.autoIncrement);
      });

      test('should have isArchived false by default', () {
        final plant = Plant();
        expect(plant.isArchived, false);
      });

      test('should have isFavorite false by default', () {
        final plant = Plant();
        expect(plant.isFavorite, false);
      });

      test('should have empty reminders link', () {
        final plant = Plant();
        expect(plant.reminders, isNotNull);
      });

      test('should have empty growthEntries link', () {
        final plant = Plant();
        expect(plant.growthEntries, isNotNull);
      });
    });

    group('lastCareDate', () {
      test('should return null when no care dates are set', () {
        final plant = Plant()..createdAt = DateTime(2024);
        expect(plant.lastCareDate, isNull);
      });

      test('should return most recent care date', () {
        final plant = Plant()
          ..lastWatered = DateTime(2024, 1, 1)
          ..lastFertilized = DateTime(2024, 3, 1)
          ..lastRepotted = DateTime(2024, 2, 1);
        expect(plant.lastCareDate, DateTime(2024, 3, 1));
      });

      test('should consider all care date fields', () {
        final plant = Plant()
          ..lastWatered = DateTime(2024, 1, 1)
          ..lastCleaned = DateTime(2024, 5, 1)
          ..lastPruned = DateTime(2024, 4, 1)
          ..lastMisted = DateTime(2024, 3, 1);
        expect(plant.lastCareDate, DateTime(2024, 5, 1));
      });
    });

    group('daysSinceLastWatering', () {
      test('should return null when lastWatered is null', () {
        final plant = Plant();
        expect(plant.daysSinceLastWatering, isNull);
      });

      test('should return days since last watering', () {
        final now = DateTime.now();
        final plant = Plant()
          ..lastWatered = now.subtract(const Duration(days: 3));
        expect(plant.daysSinceLastWatering, 3);
      });

      test('should return 0 when watered today', () {
        final plant = Plant()..lastWatered = DateTime.now();
        expect(plant.daysSinceLastWatering, 0);
      });
    });

    group('copyWith', () {
      test('should return same values when no arguments provided', () {
        final now = DateTime.now();
        final plant = Plant()
          ..id = 1
          ..name = 'Monstera'
          ..species = 'Deliciosa'
          ..room = 'Soggiorno'
          ..isFavorite = true
          ..createdAt = now;

        final copy = plant.copyWith();

        expect(copy.id, plant.id);
        expect(copy.name, plant.name);
        expect(copy.species, plant.species);
        expect(copy.room, plant.room);
        expect(copy.isFavorite, plant.isFavorite);
      });

      test('should update name when provided', () {
        final now = DateTime.now();
        final plant = Plant()
          ..name = 'Old Name'
          ..createdAt = now;
        final copy = plant.copyWith(name: 'New Name');
        expect(copy.name, 'New Name');
      });

      test('should update name when provided', () {
        final now = DateTime.now();
        final plant = Plant()
          ..name = 'Old Name'
          ..createdAt = now;
        final copy = plant.copyWith(name: 'New Name');
        expect(copy.name, 'New Name');
      });

      test('should update all fields when provided', () {
        final now = DateTime.now();
        final plant = Plant()
          ..id = 1
          ..name = 'Monstera'
          ..createdAt = now;

        final copy = plant.copyWith(
          id: 2,
          name: 'Ficus',
          species: 'Elastica',
          room: 'Camera',
          lightCondition: 'indirect',
          status: 'healthy',
          photoPath: '/path/photo.jpg',
          notes: 'New notes',
          createdAt: now.add(const Duration(days: 1)),
          lastWatered: now,
          isArchived: true,
          isFavorite: true,
        );

        expect(copy.id, 2);
        expect(copy.name, 'Ficus');
        expect(copy.species, 'Elastica');
        expect(copy.room, 'Camera');
        expect(copy.lightCondition, 'indirect');
        expect(copy.status, 'healthy');
        expect(copy.photoPath, '/path/photo.jpg');
        expect(copy.notes, 'New notes');
        expect(copy.isArchived, true);
        expect(copy.isFavorite, true);
      });

      test('should not modify original plant', () {
        final now = DateTime.now();
        final plant = Plant()
          ..name = 'Original'
          ..createdAt = now;
        plant.copyWith(name: 'Modified');
        expect(plant.name, 'Original');
      });
    });

    group('toJson', () {
      test('should serialize all fields', () {
        final now = DateTime(2024, 3, 15, 10, 30);
        final plant = Plant()
          ..id = 1
          ..name = 'Monstera'
          ..species = 'Deliciosa'
          ..room = 'Soggiorno'
          ..lightCondition = 'indirect'
          ..status = 'healthy'
          ..photoPath = '/photos/1.jpg'
          ..notes = 'Beautiful plant'
          ..createdAt = now
          ..lastWatered = now
          ..isArchived = false
          ..isFavorite = true;

        final json = plant.toJson();

        expect(json['id'], 1);
        expect(json['name'], 'Monstera');
        expect(json['species'], 'Deliciosa');
        expect(json['room'], 'Soggiorno');
        expect(json['lightCondition'], 'indirect');
        expect(json['status'], 'healthy');
        expect(json['photoPath'], '/photos/1.jpg');
        expect(json['notes'], 'Beautiful plant');
        expect(json['createdAt'], now.toIso8601String());
        expect(json['lastWatered'], now.toIso8601String());
        expect(json['isArchived'], false);
        expect(json['isFavorite'], true);
      });

      test('should handle null fields', () {
        final plant = Plant()
          ..id = 1
          ..name = 'Test'
          ..createdAt = DateTime.now();

        final json = plant.toJson();

        expect(json['species'], isNull);
        expect(json['room'], isNull);
        expect(json['lastWatered'], isNull);
        expect(json['lastFertilized'], isNull);
      });

      test('should serialize all care dates', () {
        final now = DateTime.now();
        final plant = Plant()
          ..id = 1
          ..name = 'Test'
          ..createdAt = now
          ..lastWatered = now
          ..lastFertilized = now
          ..lastRepotted = now
          ..lastCleaned = now
          ..lastPruned = now
          ..lastMisted = now;

        final json = plant.toJson();

        expect(json['lastWatered'], isNotNull);
        expect(json['lastFertilized'], isNotNull);
        expect(json['lastRepotted'], isNotNull);
        expect(json['lastCleaned'], isNotNull);
        expect(json['lastPruned'], isNotNull);
        expect(json['lastMisted'], isNotNull);
      });
    });

    group('fromJson', () {
      test('should deserialize all fields', () {
        final now = DateTime(2024, 3, 15, 10, 30);
        final json = {
          'id': 1,
          'name': 'Monstera',
          'species': 'Deliciosa',
          'room': 'Soggiorno',
          'lightCondition': 'indirect',
          'status': 'healthy',
          'photoPath': '/photos/1.jpg',
          'notes': 'Beautiful plant',
          'createdAt': now.toIso8601String(),
          'lastWatered': now.toIso8601String(),
          'isArchived': false,
          'isFavorite': true,
        };

        final plant = Plant.fromJson(json);

        expect(plant.id, 1);
        expect(plant.name, 'Monstera');
        expect(plant.species, 'Deliciosa');
        expect(plant.room, 'Soggiorno');
        expect(plant.lightCondition, 'indirect');
        expect(plant.status, 'healthy');
        expect(plant.photoPath, '/photos/1.jpg');
        expect(plant.notes, 'Beautiful plant');
        expect(plant.isArchived, false);
        expect(plant.isFavorite, true);
      });

      test('should use default name when name is null', () {
        final json = <String, dynamic>{
          'createdAt': DateTime.now().toIso8601String(),
        };

        final plant = Plant.fromJson(json);

        expect(plant.name, 'Senza nome');
      });

      test('should use default createdAt when null', () {
        final json = <String, dynamic>{};
        final before = DateTime.now();

        final plant = Plant.fromJson(json);

        expect(
            plant.createdAt.isAfter(before) ||
                plant.createdAt.isAtSameMomentAs(before),
            true);
      });

      test('should handle null optional fields', () {
        final json = {
          'id': 1,
          'name': 'Test',
          'createdAt': DateTime.now().toIso8601String(),
          'species': null,
          'room': null,
          'lastWatered': null,
        };

        final plant = Plant.fromJson(json);

        expect(plant.species, isNull);
        expect(plant.room, isNull);
        expect(plant.lastWatered, isNull);
      });

      test('should parse all care dates', () {
        final now = DateTime.now().toIso8601String();
        final json = {
          'id': 1,
          'name': 'Test',
          'createdAt': now,
          'lastWatered': now,
          'lastFertilized': now,
          'lastRepotted': now,
          'lastCleaned': now,
          'lastPruned': now,
          'lastMisted': now,
        };

        final plant = Plant.fromJson(json);

        expect(plant.lastWatered, isNotNull);
        expect(plant.lastFertilized, isNotNull);
        expect(plant.lastRepotted, isNotNull);
        expect(plant.lastCleaned, isNotNull);
        expect(plant.lastPruned, isNotNull);
        expect(plant.lastMisted, isNotNull);
      });

      test('should default isArchived to false when null', () {
        final json = {
          'id': 1,
          'name': 'Test',
          'createdAt': DateTime.now().toIso8601String(),
          'isArchived': null,
        };

        final plant = Plant.fromJson(json);
        expect(plant.isArchived, false);
      });

      test('should default isFavorite to false when null', () {
        final json = {
          'id': 1,
          'name': 'Test',
          'createdAt': DateTime.now().toIso8601String(),
          'isFavorite': null,
        };

        final plant = Plant.fromJson(json);
        expect(plant.isFavorite, false);
      });
    });

    group('round-trip serialization', () {
      test('should preserve all fields through toJson and fromJson', () {
        final now = DateTime(2024, 3, 15, 10, 30);
        final original = Plant()
          ..id = 42
          ..name = 'Ficus'
          ..species = 'Elastica'
          ..room = 'Camera da letto'
          ..lightCondition = 'direct'
          ..status = 'healthy'
          ..photoPath = '/path/to/photo.jpg'
          ..notes = 'Some notes'
          ..createdAt = now
          ..lastWatered = now.subtract(const Duration(days: 2))
          ..lastFertilized = now.subtract(const Duration(days: 30))
          ..isArchived = false
          ..isFavorite = true;

        final json = original.toJson();
        final restored = Plant.fromJson(json);

        expect(restored.id, original.id);
        expect(restored.name, original.name);
        expect(restored.species, original.species);
        expect(restored.room, original.room);
        expect(restored.lightCondition, original.lightCondition);
        expect(restored.status, original.status);
        expect(restored.photoPath, original.photoPath);
        expect(restored.notes, original.notes);
        expect(restored.createdAt.isAtSameMomentAs(original.createdAt), true);
        expect(restored.isArchived, original.isArchived);
        expect(restored.isFavorite, original.isFavorite);
      });
    });
  });
}
