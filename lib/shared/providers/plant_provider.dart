import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/database/database.dart';
import '../../data/models/plant.dart';
import '../../data/repositories/plant_repository.dart';
import '../../core/constants/enums.dart';

/// Provider for PlantRepository
final plantRepositoryProvider = Provider<PlantRepository>((ref) {
  return PlantRepository(databaseService: DatabaseService.instance);
});

/// Provider for all plants
final plantsProvider = StateNotifierProvider<PlantsNotifier, AsyncValue<List<Plant>>>((ref) {
  return PlantsNotifier(ref.watch(plantRepositoryProvider));
});

/// Provider for a single plant
final plantProvider = StateNotifierProvider.family<PlantNotifier, AsyncValue<Plant?>, int>((ref, id) {
  return PlantNotifier(id, ref.watch(plantRepositoryProvider));
});

/// Provider for plants needing water
final plantsNeedingWaterProvider = FutureProvider<List<Plant>>((ref) async {
  final repository = ref.watch(plantRepositoryProvider);
  return repository.getPlantsNeedingWater(7); // Default 7 days
});

/// Provider for plant count
final plantCountProvider = FutureProvider<int>((ref) async {
  final repository = ref.watch(plantRepositoryProvider);
  return repository.getPlantCount();
});

/// Provider for plant rooms
final plantRoomsProvider = FutureProvider<List<String>>((ref) async {
  final repository = ref.watch(plantRepositoryProvider);
  return repository.getAllRooms();
});

/// Plants notifier
class PlantsNotifier extends StateNotifier<AsyncValue<List<Plant>>> {
  PlantsNotifier(this._repository) : super(const AsyncValue.loading()) {
    loadPlants();
  }

  final PlantRepository _repository;

  /// Load all plants
  Future<void> loadPlants() async {
    try {
      final plants = await _repository.getAllPlants();
      state = AsyncValue.data(plants);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  /// Add a plant
  Future<void> addPlant(Plant plant) async {
    try {
      await _repository.addPlant(plant);
      await loadPlants();
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  /// Delete a plant
  Future<void> deletePlant(int id) async {
    try {
      await _repository.deletePlant(id);
      await loadPlants();
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  /// Toggle favorite
  Future<void> toggleFavorite(int id) async {
    try {
      await _repository.toggleFavorite(id);
      await loadPlants();
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  /// Record watering
  Future<void> recordWatering(int id) async {
    try {
      await _repository.recordWatering(id);
      await loadPlants();
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  /// Search plants
  Future<void> searchPlants(String query) async {
    if (query.isEmpty) {
      await loadPlants();
      return;
    }
    try {
      final plants = await _repository.searchPlants(query);
      state = AsyncValue.data(plants);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  /// Get plants by room
  Future<void> filterByRoom(String? room) async {
    if (room == null || room.isEmpty) {
      await loadPlants();
      return;
    }
    try {
      final plants = await _repository.getPlantsByRoom(room);
      state = AsyncValue.data(plants);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

/// Plant notifier for a single plant
class PlantNotifier extends StateNotifier<AsyncValue<Plant?>> {
  PlantNotifier(this._plantId, this._repository) : super(const AsyncValue.loading()) {
    loadPlant();
  }

  final int _plantId;
  final PlantRepository _repository;

  /// Load plant
  Future<void> loadPlant() async {
    try {
      final plant = await _repository.getPlant(_plantId);
      state = AsyncValue.data(plant);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  /// Update plant
  Future<void> updatePlant(Plant plant) async {
    try {
      await _repository.updatePlant(plant);
      state = AsyncValue.data(plant);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
