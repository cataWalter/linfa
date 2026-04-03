import 'package:isar/isar.dart';
import '../database/database.dart';
import '../models/plant.dart';
import '../models/growth_entry.dart';

/// Repository for plant CRUD operations
class PlantRepository {
  PlantRepository({required this.databaseService});

  final DatabaseService databaseService;

  Isar get _db => databaseService.isar;

  /// Get all active plants
  Future<List<Plant>> getAllPlants({bool includeArchived = false}) async {
    final query = _db.plants.where().sortByCreatedAtDesc();
    final plants = await query.findAll();
    if (!includeArchived) {
      return plants.where((p) => !p.isArchived).toList();
    }
    return plants;
  }

  /// Get plants by room
  Future<List<Plant>> getPlantsByRoom(String room) async {
    final plants = await _db.plants.where().sortByCreatedAtDesc().findAll();
    return plants.where((p) => !p.isArchived && p.room == room).toList();
  }

  /// Get all unique rooms
  Future<List<String>> getAllRooms() async {
    final plants = await _db.plants.where().findAll();
    final rooms = plants
        .where((p) => !p.isArchived)
        .map((p) => p.room)
        .where((r) => r != null && r.isNotEmpty)
        .cast<String>()
        .toSet()
        .toList();
    rooms.sort();
    return rooms;
  }

  /// Get a single plant by ID
  Future<Plant?> getPlant(int id) async {
    return _db.plants.get(id);
  }

  /// Search plants by name
  Future<List<Plant>> searchPlants(String query) async {
    final plants = await _db.plants.where().findAll();
    return plants
        .where((p) =>
            !p.isArchived && p.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  /// Add a new plant
  Future<int> addPlant(Plant plant) async {
    return _db.writeTxn(() async {
      plant.createdAt = DateTime.now();
      await _db.plants.put(plant);
      return plant.id;
    });
  }

  /// Update a plant
  Future<void> updatePlant(Plant plant) async {
    await _db.writeTxn(() async {
      await _db.plants.put(plant);
    });
  }

  /// Delete a plant
  Future<void> deletePlant(int id) async {
    await _db.writeTxn(() async {
      await _db.plants.delete(id);
    });
  }

  /// Archive a plant
  Future<void> archivePlant(int id) async {
    final plant = await _db.plants.get(id);
    if (plant != null) {
      plant.isArchived = true;
      await _db.writeTxn(() async {
        await _db.plants.put(plant);
      });
    }
  }

  /// Toggle favorite
  Future<void> toggleFavorite(int id) async {
    final plant = await _db.plants.get(id);
    if (plant != null) {
      plant.isFavorite = !plant.isFavorite;
      await _db.writeTxn(() async {
        await _db.plants.put(plant);
      });
    }
  }

  /// Record watering
  Future<void> recordWatering(int id) async {
    final plant = await _db.plants.get(id);
    if (plant != null) {
      plant.lastWatered = DateTime.now();
      await _db.writeTxn(() async {
        await _db.plants.put(plant);
      });
    }
  }

  /// Record fertilizing
  Future<void> recordFertilizing(int id) async {
    final plant = await _db.plants.get(id);
    if (plant != null) {
      plant.lastFertilized = DateTime.now();
      await _db.writeTxn(() async {
        await _db.plants.put(plant);
      });
    }
  }

  /// Record misting
  Future<void> recordMisting(int id) async {
    final plant = await _db.plants.get(id);
    if (plant != null) {
      plant.lastMisted = DateTime.now();
      await _db.writeTxn(() async {
        await _db.plants.put(plant);
      });
    }
  }

  /// Record repotting
  Future<void> recordRepotting(int id) async {
    final plant = await _db.plants.get(id);
    if (plant != null) {
      plant.lastRepotted = DateTime.now();
      await _db.writeTxn(() async {
        await _db.plants.put(plant);
      });
    }
  }

  /// Record pruning
  Future<void> recordPruning(int id) async {
    final plant = await _db.plants.get(id);
    if (plant != null) {
      plant.lastPruned = DateTime.now();
      await _db.writeTxn(() async {
        await _db.plants.put(plant);
      });
    }
  }

  /// Record cleaning
  Future<void> recordCleaning(int id) async {
    final plant = await _db.plants.get(id);
    if (plant != null) {
      plant.lastCleaned = DateTime.now();
      await _db.writeTxn(() async {
        await _db.plants.put(plant);
      });
    }
  }

  /// Get plants needing water (overdue)
  Future<List<Plant>> getPlantsNeedingWater(int defaultDays) async {
    final plants = await _db.plants.where().findAll();

    return plants.where((plant) {
      if (plant.isArchived) return false;
      if (plant.lastWatered == null) return true;
      final daysSince = DateTime.now().difference(plant.lastWatered!).inDays;
      return daysSince >= defaultDays;
    }).toList();
  }

  /// Get plant count
  Future<int> getPlantCount() async {
    final plants = await _db.plants.where().findAll();
    return plants.where((p) => !p.isArchived).length;
  }

  /// Get all plants for export
  Future<List<Map<String, dynamic>>> exportAllPlants() async {
    final plants = await _db.plants.where().findAll();
    return plants.map((p) => p.toJson()).toList();
  }

  /// Import plants from JSON
  Future<void> importPlants(List<Map<String, dynamic>> plantsJson) async {
    await _db.writeTxn(() async {
      for (final json in plantsJson) {
        final plant = Plant.fromJson(json);
        await _db.plants.put(plant);
      }
    });
  }

  /// Add growth entry to a plant
  Future<void> addGrowthEntry(int plantId, GrowthEntry entry) async {
    final plant = await _db.plants.get(plantId);
    if (plant != null) {
      await _db.writeTxn(() async {
        entry.date = DateTime.now();
        await _db.growthEntrys.put(entry);
      });
    }
  }

  /// Get growth entries for a plant
  Future<List<GrowthEntry>> getGrowthEntries(int plantId) async {
    return _db.growthEntrys.where().sortByDateDesc().findAll();
  }
}
