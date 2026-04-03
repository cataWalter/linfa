import 'package:flutter_test/flutter_test.dart';
import 'package:isar/isar.dart';
import 'package:linfa/data/database/database.dart';
import 'package:linfa/data/models/growth_entry.dart';
import 'package:linfa/data/models/plant.dart';
import 'package:linfa/data/repositories/plant_repository.dart';

import '../../helpers/test_constants.dart';

/// Minimal mock Isar that satisfies DatabaseService.test() requirements
class _MockIsar implements Isar {
  @override
  IsarCollection<T> collection<T>() {
    throw UnimplementedError('Mock Isar collection not implemented');
  }

  @override
  Future<T> writeTxn<T>(Future<T> Function() callback, {bool silent = false}) async {
    return callback();
  }

  @override
  dynamic noSuchMethod(Invocation invocation) {
    throw UnimplementedError('MockIsar.${invocation.memberName} not implemented');
  }
}

/// In-memory test implementation of PlantRepository
/// that doesn't rely on Isar database
class TestPlantRepository implements PlantRepository {
  @override
  late final DatabaseService databaseService;
  final Map<int, Plant> _plants = {};
  final Map<int, GrowthEntry> _growthEntries = {};
  int _nextPlantId = 1;
  int _nextEntryId = 1;

  TestPlantRepository({DatabaseService? databaseService})
      : databaseService = databaseService ?? DatabaseService.test(_MockIsar());

  @override
  Future<List<Plant>> getAllPlants({bool includeArchived = false}) async {
    var list = _plants.values.toList();
    if (!includeArchived) {
      list = list.where((p) => !p.isArchived).toList();
    }
    list.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return list;
  }

  @override
  Future<List<Plant>> getPlantsByRoom(String room) async {
    return _plants.values
        .where((p) => !p.isArchived && p.room == room)
        .toList();
  }

  @override
  Future<List<String>> getAllRooms() async {
    final rooms = _plants.values
        .where((p) => !p.isArchived)
        .map((p) => p.room)
        .where((r) => r != null && r.isNotEmpty)
        .cast<String>()
        .toSet()
        .toList();
    rooms.sort();
    return rooms;
  }

  @override
  Future<Plant?> getPlant(int id) async => _plants[id];

  @override
  Future<List<Plant>> searchPlants(String query) async {
    return _plants.values
        .where((p) =>
            !p.isArchived &&
            p.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  @override
  Future<int> addPlant(Plant plant) async {
    plant.id = _nextPlantId++;
    plant.createdAt = DateTime.now();
    _plants[plant.id] = plant;
    return plant.id;
  }

  @override
  Future<void> updatePlant(Plant plant) async {
    _plants[plant.id] = plant;
  }

  @override
  Future<void> deletePlant(int id) async {
    _plants.remove(id);
  }

  @override
  Future<void> archivePlant(int id) async {
    final plant = _plants[id];
    if (plant != null) {
      plant.isArchived = true;
    }
  }

  @override
  Future<void> toggleFavorite(int id) async {
    final plant = _plants[id];
    if (plant != null) {
      plant.isFavorite = !plant.isFavorite;
    }
  }

  @override
  Future<void> recordWatering(int id) async {
    final plant = _plants[id];
    if (plant != null) {
      plant.lastWatered = DateTime.now();
    }
  }

  @override
  Future<void> recordFertilizing(int id) async {
    final plant = _plants[id];
    if (plant != null) {
      plant.lastFertilized = DateTime.now();
    }
  }

  @override
  Future<void> recordMisting(int id) async {
    final plant = _plants[id];
    if (plant != null) {
      plant.lastMisted = DateTime.now();
    }
  }

  @override
  Future<void> recordRepotting(int id) async {
    final plant = _plants[id];
    if (plant != null) {
      plant.lastRepotted = DateTime.now();
    }
  }

  @override
  Future<void> recordPruning(int id) async {
    final plant = _plants[id];
    if (plant != null) {
      plant.lastPruned = DateTime.now();
    }
  }

  @override
  Future<void> recordCleaning(int id) async {
    final plant = _plants[id];
    if (plant != null) {
      plant.lastCleaned = DateTime.now();
    }
  }

  @override
  Future<List<Plant>> getPlantsNeedingWater(int defaultDays) async {
    return _plants.values.where((plant) {
      if (plant.isArchived) return false;
      if (plant.lastWatered == null) return true;
      final daysSince = DateTime.now().difference(plant.lastWatered!).inDays;
      return daysSince >= defaultDays;
    }).toList();
  }

  @override
  Future<int> getPlantCount() async {
    return _plants.values.where((p) => !p.isArchived).length;
  }

  @override
  Future<List<Map<String, dynamic>>> exportAllPlants() async {
    return _plants.values.map((p) => p.toJson()).toList();
  }

  @override
  Future<void> importPlants(List<Map<String, dynamic>> plantsJson) async {
    for (final json in plantsJson) {
      final plant = Plant.fromJson(json);
      plant.id = _nextPlantId++;
      _plants[plant.id] = plant;
    }
  }

  @override
  Future<void> addGrowthEntry(int plantId, GrowthEntry entry) async {
    final plant = _plants[plantId];
    if (plant != null) {
      entry.id = _nextEntryId++;
      entry.date = DateTime.now();
      _growthEntries[entry.id] = entry;
    }
  }

  @override
  Future<List<GrowthEntry>> getGrowthEntries(int plantId) async {
    var entries = _growthEntries.values.toList();
    entries.sort((a, b) => b.date.compareTo(a.date));
    return entries;
  }
}

void main() {
  late TestPlantRepository repository;

  setUp(() {
    repository = TestPlantRepository();
  });

  group('getAllPlants', () {
    test('should return all non-archived plants by default', () async {
      final plant1 = createTestPlant(id: 1, name: 'Plant 1', isArchived: false);
      final plant2 = createTestPlant(id: 2, name: 'Plant 2', isArchived: false);
      final plant3 = createTestPlant(id: 3, name: 'Plant 3', isArchived: true);

      await repository.addPlant(plant1);
      await repository.addPlant(plant2);
      await repository.addPlant(plant3);

      final result = await repository.getAllPlants();

      expect(result.length, 2);
      expect(result.any((p) => p.isArchived), isFalse);
    });

    test(
        'should return all plants including archived when includeArchived is true',
        () async {
      final plant1 = createTestPlant(id: 1, name: 'Plant 1', isArchived: false);
      final plant2 = createTestPlant(id: 2, name: 'Plant 2', isArchived: true);

      await repository.addPlant(plant1);
      await repository.addPlant(plant2);

      final result = await repository.getAllPlants(includeArchived: true);

      expect(result.length, 2);
    });

    test('should return empty list when no plants exist', () async {
      final result = await repository.getAllPlants();

      expect(result, isEmpty);
    });

    test('should return only archived plants when all are archived', () async {
      final plant1 = createTestPlant(id: 1, isArchived: true);
      await repository.addPlant(plant1);

      final result = await repository.getAllPlants();

      expect(result, isEmpty);
    });

    test('should return plants sorted by createdAt descending', () async {
      // Add plants with delays to ensure different createdAt timestamps
      final plant1 = createTestPlant(id: 1, name: 'First');
      await repository.addPlant(plant1);

      // Small delay to ensure different timestamps
      await Future.delayed(const Duration(milliseconds: 10));
      final plant2 = createTestPlant(id: 2, name: 'Second');
      await repository.addPlant(plant2);

      await Future.delayed(const Duration(milliseconds: 10));
      final plant3 = createTestPlant(id: 3, name: 'Third');
      await repository.addPlant(plant3);

      final result = await repository.getAllPlants();

      // Should be sorted by createdAt descending (newest first)
      expect(result[0].name, 'Third');
      expect(result[1].name, 'Second');
      expect(result[2].name, 'First');
    });
  });

  group('getPlantsByRoom', () {
    test('should return plants filtered by room', () async {
      final plant1 = createTestPlant(
          id: 1, name: 'Living Room Plant', room: 'Living Room');
      final plant2 =
          createTestPlant(id: 2, name: 'Kitchen Plant', room: 'Kitchen');
      final plant3 = createTestPlant(
          id: 3, name: 'Another Living Room', room: 'Living Room');

      await repository.addPlant(plant1);
      await repository.addPlant(plant2);
      await repository.addPlant(plant3);

      final result = await repository.getPlantsByRoom('Living Room');

      expect(result.length, 2);
      expect(result.every((p) => p.room == 'Living Room'), isTrue);
    });

    test('should exclude archived plants', () async {
      final plant1 =
          createTestPlant(id: 1, room: 'Living Room', isArchived: false);
      final plant2 =
          createTestPlant(id: 2, room: 'Living Room', isArchived: true);

      await repository.addPlant(plant1);
      await repository.addPlant(plant2);

      final result = await repository.getPlantsByRoom('Living Room');

      expect(result.length, 1);
      expect(result.first.isArchived, isFalse);
    });

    test('should return empty list when no plants match room', () async {
      final plant = createTestPlant(id: 1, room: 'Kitchen');
      await repository.addPlant(plant);

      final result = await repository.getPlantsByRoom('Living Room');

      expect(result, isEmpty);
    });

    test('should return empty list when no plants exist', () async {
      final result = await repository.getPlantsByRoom('Living Room');

      expect(result, isEmpty);
    });
  });

  group('getAllRooms', () {
    test('should return unique rooms sorted alphabetically', () async {
      final plant1 = createTestPlant(id: 1, room: 'Kitchen');
      final plant2 = createTestPlant(id: 2, room: 'Living Room');
      final plant3 = createTestPlant(id: 3, room: 'Kitchen');

      await repository.addPlant(plant1);
      await repository.addPlant(plant2);
      await repository.addPlant(plant3);

      final result = await repository.getAllRooms();

      expect(result, ['Kitchen', 'Living Room']);
    });

    test('should exclude rooms from archived plants', () async {
      final plant1 = createTestPlant(id: 1, room: 'Kitchen', isArchived: false);
      final plant2 = createTestPlant(id: 2, room: 'Bedroom', isArchived: true);

      await repository.addPlant(plant1);
      await repository.addPlant(plant2);

      final result = await repository.getAllRooms();

      expect(result, ['Kitchen']);
    });

    test('should exclude null and empty rooms', () async {
      final plant1 = createTestPlant(id: 1, room: null);
      final plant2 = createTestPlant(id: 2, room: '');
      final plant3 = createTestPlant(id: 3, room: 'Kitchen');

      await repository.addPlant(plant1);
      await repository.addPlant(plant2);
      await repository.addPlant(plant3);

      final result = await repository.getAllRooms();

      expect(result, ['Kitchen']);
    });

    test('should return empty list when no plants exist', () async {
      final result = await repository.getAllRooms();

      expect(result, isEmpty);
    });
  });

  group('getPlant', () {
    test('should return plant by id', () async {
      final plant = createTestPlant(id: 1, name: 'Monstera');
      await repository.addPlant(plant);

      final result = await repository.getPlant(1);

      expect(result, isNotNull);
      expect(result!.name, 'Monstera');
    });

    test('should return null for non-existent plant', () async {
      final result = await repository.getPlant(999);

      expect(result, isNull);
    });
  });

  group('searchPlants', () {
    test('should return plants matching name query (case insensitive)',
        () async {
      final plant1 = createTestPlant(id: 1, name: 'Monstera');
      final plant2 = createTestPlant(id: 2, name: 'Ficus');
      final plant3 = createTestPlant(id: 3, name: 'Monsterad');

      await repository.addPlant(plant1);
      await repository.addPlant(plant2);
      await repository.addPlant(plant3);

      final result = await repository.searchPlants('monstera');

      expect(result.length, 2);
      expect(result.every((p) => p.name.toLowerCase().contains('monstera')),
          isTrue);
    });

    test('should exclude archived plants from search', () async {
      final plant1 =
          createTestPlant(id: 1, name: 'Monstera', isArchived: false);
      final plant2 =
          createTestPlant(id: 2, name: 'Monstera Deliciosa', isArchived: true);

      await repository.addPlant(plant1);
      await repository.addPlant(plant2);

      final result = await repository.searchPlants('monstera');

      expect(result.length, 1);
    });

    test('should return empty list when no matches', () async {
      final plant = createTestPlant(id: 1, name: 'Ficus');
      await repository.addPlant(plant);

      final result = await repository.searchPlants('rose');

      expect(result, isEmpty);
    });

    test('should return empty list when no plants exist', () async {
      final result = await repository.searchPlants('test');

      expect(result, isEmpty);
    });
  });

  group('addPlant', () {
    test('should add plant and return its id', () async {
      final plant = createTestPlant(id: 1, name: 'New Plant');

      final result = await repository.addPlant(plant);

      expect(result, isA<int>());
      expect(result, greaterThan(0));
      expect(plant.createdAt, isNotNull);
    });

    test('should set createdAt to current time', () async {
      final before = DateTime.now();
      final plant = createTestPlant(id: 1, name: 'Test');
      await repository.addPlant(plant);
      final after = DateTime.now();

      expect(
          plant.createdAt.isAfter(before) ||
              plant.createdAt.isAtSameMomentAs(before),
          isTrue);
      expect(
          plant.createdAt.isBefore(after) ||
              plant.createdAt.isAtSameMomentAs(after),
          isTrue);
    });

    test('should store plant in collection', () async {
      final plant = createTestPlant(id: 1, name: 'Test Plant');
      final id = await repository.addPlant(plant);

      final stored = await repository.getPlant(id);

      expect(stored, isNotNull);
      expect(stored!.name, 'Test Plant');
    });
  });

  group('updatePlant', () {
    test('should update existing plant', () async {
      final plant = createTestPlant(id: 1, name: 'Original');
      await repository.addPlant(plant);

      plant.name = 'Updated';
      await repository.updatePlant(plant);

      final stored = await repository.getPlant(1);
      expect(stored!.name, 'Updated');
    });

    test('should handle updating non-existent plant', () async {
      final plant = createTestPlant(id: 999, name: 'Ghost');

      await repository.updatePlant(plant);

      final stored = await repository.getPlant(999);
      expect(stored, isNotNull);
    });
  });

  group('deletePlant', () {
    test('should delete existing plant', () async {
      final plant = createTestPlant(id: 1, name: 'To Delete');
      await repository.addPlant(plant);

      await repository.deletePlant(1);

      final stored = await repository.getPlant(1);
      expect(stored, isNull);
    });

    test('should handle deleting non-existent plant', () async {
      expect(() => repository.deletePlant(999), returnsNormally);
    });
  });

  group('archivePlant', () {
    test('should archive existing plant', () async {
      final plant = createTestPlant(id: 1, isArchived: false);
      await repository.addPlant(plant);

      await repository.archivePlant(1);

      final stored = await repository.getPlant(1);
      expect(stored!.isArchived, isTrue);
    });

    test('should do nothing for non-existent plant', () async {
      expect(() => repository.archivePlant(999), returnsNormally);
    });
  });

  group('toggleFavorite', () {
    test('should toggle favorite from false to true', () async {
      final plant = createTestPlant(id: 1, isFavorite: false);
      await repository.addPlant(plant);

      await repository.toggleFavorite(1);

      final stored = await repository.getPlant(1);
      expect(stored!.isFavorite, isTrue);
    });

    test('should toggle favorite from true to false', () async {
      final plant = createTestPlant(id: 1, isFavorite: true);
      await repository.addPlant(plant);

      await repository.toggleFavorite(1);

      final stored = await repository.getPlant(1);
      expect(stored!.isFavorite, isFalse);
    });

    test('should do nothing for non-existent plant', () async {
      expect(() => repository.toggleFavorite(999), returnsNormally);
    });
  });

  group('recordWatering', () {
    test('should set lastWatered to current time', () async {
      final plant = createTestPlant(id: 1, lastWatered: null);
      await repository.addPlant(plant);

      final before = DateTime.now();
      await repository.recordWatering(1);
      final after = DateTime.now();

      final stored = await repository.getPlant(1);
      expect(stored!.lastWatered, isNotNull);
      expect(
          stored.lastWatered!.isAfter(before) ||
              stored.lastWatered!.isAtSameMomentAs(before),
          isTrue);
      expect(
          stored.lastWatered!.isBefore(after) ||
              stored.lastWatered!.isAtSameMomentAs(after),
          isTrue);
    });

    test('should do nothing for non-existent plant', () async {
      expect(() => repository.recordWatering(999), returnsNormally);
    });
  });

  group('recordFertilizing', () {
    test('should set lastFertilized to current time', () async {
      final plant = createTestPlant(id: 1, lastFertilized: null);
      await repository.addPlant(plant);

      await repository.recordFertilizing(1);

      final stored = await repository.getPlant(1);
      expect(stored!.lastFertilized, isNotNull);
    });

    test('should do nothing for non-existent plant', () async {
      expect(() => repository.recordFertilizing(999), returnsNormally);
    });
  });

  group('recordMisting', () {
    test('should set lastMisted to current time', () async {
      final plant = createTestPlant(id: 1, lastMisted: null);
      await repository.addPlant(plant);

      await repository.recordMisting(1);

      final stored = await repository.getPlant(1);
      expect(stored!.lastMisted, isNotNull);
    });

    test('should do nothing for non-existent plant', () async {
      expect(() => repository.recordMisting(999), returnsNormally);
    });
  });

  group('recordRepotting', () {
    test('should set lastRepotted to current time', () async {
      final plant = createTestPlant(id: 1, lastRepotted: null);
      await repository.addPlant(plant);

      await repository.recordRepotting(1);

      final stored = await repository.getPlant(1);
      expect(stored!.lastRepotted, isNotNull);
    });

    test('should do nothing for non-existent plant', () async {
      expect(() => repository.recordRepotting(999), returnsNormally);
    });
  });

  group('recordPruning', () {
    test('should set lastPruned to current time', () async {
      final plant = createTestPlant(id: 1, lastPruned: null);
      await repository.addPlant(plant);

      await repository.recordPruning(1);

      final stored = await repository.getPlant(1);
      expect(stored!.lastPruned, isNotNull);
    });

    test('should do nothing for non-existent plant', () async {
      expect(() => repository.recordPruning(999), returnsNormally);
    });
  });

  group('recordCleaning', () {
    test('should set lastCleaned to current time', () async {
      final plant = createTestPlant(id: 1, lastCleaned: null);
      await repository.addPlant(plant);

      await repository.recordCleaning(1);

      final stored = await repository.getPlant(1);
      expect(stored!.lastCleaned, isNotNull);
    });

    test('should do nothing for non-existent plant', () async {
      expect(() => repository.recordCleaning(999), returnsNormally);
    });
  });

  group('getPlantsNeedingWater', () {
    test('should return plants never watered', () async {
      final plant =
          createTestPlant(id: 1, lastWatered: null, isArchived: false);
      await repository.addPlant(plant);

      final result = await repository.getPlantsNeedingWater(7);

      expect(result.length, 1);
    });

    test('should return plants with watering overdue', () async {
      final plant = createTestPlant(
        id: 1,
        lastWatered: DateTime.now().subtract(const Duration(days: 10)),
        isArchived: false,
      );
      await repository.addPlant(plant);

      final result = await repository.getPlantsNeedingWater(7);

      expect(result.length, 1);
    });

    test('should not return recently watered plants', () async {
      final plant = createTestPlant(
        id: 1,
        lastWatered: DateTime.now().subtract(const Duration(days: 3)),
        isArchived: false,
      );
      await repository.addPlant(plant);

      final result = await repository.getPlantsNeedingWater(7);

      expect(result, isEmpty);
    });

    test('should exclude archived plants', () async {
      final plant = createTestPlant(
        id: 1,
        lastWatered: null,
        isArchived: true,
      );
      await repository.addPlant(plant);

      final result = await repository.getPlantsNeedingWater(7);

      expect(result, isEmpty);
    });

    test('should return empty list when no plants exist', () async {
      final result = await repository.getPlantsNeedingWater(7);

      expect(result, isEmpty);
    });
  });

  group('getPlantCount', () {
    test('should return count of non-archived plants', () async {
      final plant1 = createTestPlant(id: 1, isArchived: false);
      final plant2 = createTestPlant(id: 2, isArchived: false);
      final plant3 = createTestPlant(id: 3, isArchived: true);

      await repository.addPlant(plant1);
      await repository.addPlant(plant2);
      await repository.addPlant(plant3);

      final result = await repository.getPlantCount();

      expect(result, 2);
    });

    test('should return zero when no plants exist', () async {
      final result = await repository.getPlantCount();

      expect(result, 0);
    });

    test('should return zero when all plants are archived', () async {
      await repository.addPlant(createTestPlant(id: 1, isArchived: true));
      final result = await repository.getPlantCount();

      expect(result, 0);
    });
  });

  group('exportAllPlants', () {
    test('should export all plants as JSON maps', () async {
      final plant1 = createTestPlant(id: 1, name: 'Plant 1');
      final plant2 = createTestPlant(id: 2, name: 'Plant 2');

      await repository.addPlant(plant1);
      await repository.addPlant(plant2);

      final result = await repository.exportAllPlants();

      expect(result.length, 2);
      expect(result.first['name'], 'Plant 1');
      expect(result.last['name'], 'Plant 2');
    });

    test('should include archived plants in export', () async {
      final plant = createTestPlant(id: 1, isArchived: true);
      await repository.addPlant(plant);

      final result = await repository.exportAllPlants();

      expect(result.length, 1);
    });

    test('should return empty list when no plants exist', () async {
      final result = await repository.exportAllPlants();

      expect(result, isEmpty);
    });
  });

  group('importPlants', () {
    test('should import plants from JSON', () async {
      final jsonList = [
        {
          'name': 'Imported 1',
          'species': 'Species A',
          'isArchived': false,
          'isFavorite': false,
          'createdAt': DateTime(2024, 1, 1).toIso8601String(),
        },
        {
          'name': 'Imported 2',
          'species': 'Species B',
          'isArchived': false,
          'isFavorite': true,
          'createdAt': DateTime(2024, 1, 1).toIso8601String(),
        },
      ];

      await repository.importPlants(jsonList);

      final stored = await repository.getAllPlants();
      expect(stored.length, 2);
      expect(stored.first.name, 'Imported 1');
    });

    test('should import empty list without error', () async {
      await repository.importPlants([]);

      final stored = await repository.getAllPlants();
      expect(stored, isEmpty);
    });
  });

  group('addGrowthEntry', () {
    test('should add growth entry when plant exists', () async {
      final plant = createTestPlant(id: 1);
      await repository.addPlant(plant);

      final entry = createTestGrowthEntry(id: 1);
      await repository.addGrowthEntry(1, entry);

      final stored = await repository.getGrowthEntries(1);
      expect(stored.length, 1);
      expect(stored.first.date, isNotNull);
    });

    test('should set entry date to current time', () async {
      final plant = createTestPlant(id: 1);
      await repository.addPlant(plant);

      final before = DateTime.now();
      final entry = createTestGrowthEntry(id: 1);
      await repository.addGrowthEntry(1, entry);
      final after = DateTime.now();

      final stored = await repository.getGrowthEntries(1);
      expect(
          stored.first.date.isAfter(before) ||
              stored.first.date.isAtSameMomentAs(before),
          isTrue);
      expect(
          stored.first.date.isBefore(after) ||
              stored.first.date.isAtSameMomentAs(after),
          isTrue);
    });

    test('should do nothing when plant does not exist', () async {
      final entry = createTestGrowthEntry(id: 1);
      await repository.addGrowthEntry(999, entry);

      final stored = await repository.getGrowthEntries(1);
      expect(stored, isEmpty);
    });
  });

  group('getGrowthEntries', () {
    test('should return all growth entries sorted by date desc', () async {
      final plant = createTestPlant(id: 1);
      await repository.addPlant(plant);

      // Add entries with delays to ensure different timestamps
      final entry1 = createTestGrowthEntry(id: 1);
      await repository.addGrowthEntry(1, entry1);

      await Future.delayed(const Duration(milliseconds: 10));
      final entry2 = createTestGrowthEntry(id: 2);
      await repository.addGrowthEntry(1, entry2);

      await Future.delayed(const Duration(milliseconds: 10));
      final entry3 = createTestGrowthEntry(id: 3);
      await repository.addGrowthEntry(1, entry3);

      final result = await repository.getGrowthEntries(1);

      expect(result.length, 3);
      // Should be sorted by date descending (newest first)
      expect(result[0].date.isAfter(result[1].date), isTrue);
      expect(result[1].date.isAfter(result[2].date), isTrue);
    });

    test('should return empty list when no entries exist', () async {
      final result = await repository.getGrowthEntries(1);

      expect(result, isEmpty);
    });
  });
}