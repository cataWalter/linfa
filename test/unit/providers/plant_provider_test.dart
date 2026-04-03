import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:linfa/shared/providers/plant_provider.dart';
import 'package:linfa/data/models/plant.dart';
import 'package:linfa/data/models/growth_entry.dart';
import 'package:linfa/data/repositories/plant_repository.dart';
import 'package:linfa/data/database/database.dart';

void main() {
  group('PlantsNotifier', () {
    late _MockPlantRepository mockRepository;
    late ProviderContainer container;

    setUp(() {
      mockRepository = _MockPlantRepository();
      container = ProviderContainer(
        overrides: [
          plantRepositoryProvider.overrideWithValue(mockRepository),
        ],
      );
      addTearDown(container.dispose);
    });

    test('initial state should be loading', () {
      final notifier = PlantsNotifier(mockRepository);
      expect(notifier.state.isLoading, true);
    });

    test('loadPlants should update state with plants', () async {
      final plants = [
        Plant()..id = 1..name = 'Monstera'..createdAt = DateTime.now(),
        Plant()..id = 2..name = 'Ficus'..createdAt = DateTime.now(),
      ];
      mockRepository.plants = plants;

      final notifier = PlantsNotifier(mockRepository);
      await notifier.loadPlants();

      expect(notifier.state.hasValue, true);
      expect(notifier.state.value, plants);
    });

    test('loadPlants should handle errors', () async {
      mockRepository.shouldThrow = true;

      final notifier = PlantsNotifier(mockRepository);
      await notifier.loadPlants();

      expect(notifier.state.hasError, true);
    });

    test('addPlant should call repository and reload', () async {
      final plant = Plant()..name = 'Test'..createdAt = DateTime.now();
      mockRepository.plants = [plant];

      final notifier = PlantsNotifier(mockRepository);
      await notifier.addPlant(plant);

      expect(mockRepository.addPlantCalled, true);
      expect(notifier.state.value, [plant]);
    });

    test('deletePlant should call repository and reload', () async {
      mockRepository.plants = [];

      final notifier = PlantsNotifier(mockRepository);
      await notifier.deletePlant(1);

      expect(mockRepository.deletePlantCalled, true);
    });

    test('toggleFavorite should call repository and reload', () async {
      mockRepository.plants = [];

      final notifier = PlantsNotifier(mockRepository);
      await notifier.toggleFavorite(1);

      expect(mockRepository.toggleFavoriteCalled, true);
    });

    test('recordWatering should call repository and reload', () async {
      mockRepository.plants = [];

      final notifier = PlantsNotifier(mockRepository);
      await notifier.recordWatering(1);

      expect(mockRepository.recordWateringCalled, true);
    });

    test('searchPlants with empty query should reload all', () async {
      final plants = [Plant()..id = 1..name = 'Monstera'..createdAt = DateTime.now()];
      mockRepository.plants = plants;

      final notifier = PlantsNotifier(mockRepository);
      await notifier.searchPlants('');

      expect(mockRepository.getAllPlantsCalled, true);
    });

    test('searchPlants with query should search', () async {
      final plants = [Plant()..id = 1..name = 'Monstera'..createdAt = DateTime.now()];
      mockRepository.searchResults = plants;

      final notifier = PlantsNotifier(mockRepository);
      await notifier.searchPlants('Mon');

      expect(mockRepository.searchPlantsCalled, true);
      expect(notifier.state.value, plants);
    });

    test('filterByRoom with null should reload all', () async {
      final plants = [Plant()..id = 1..name = 'Monstera'..createdAt = DateTime.now()];
      mockRepository.plants = plants;

      final notifier = PlantsNotifier(mockRepository);
      await notifier.filterByRoom(null);

      expect(mockRepository.getAllPlantsCalled, true);
    });

    test('filterByRoom with empty string should reload all', () async {
      final plants = [Plant()..id = 1..name = 'Monstera'..createdAt = DateTime.now()];
      mockRepository.plants = plants;

      final notifier = PlantsNotifier(mockRepository);
      await notifier.filterByRoom('');

      expect(mockRepository.getAllPlantsCalled, true);
    });

    test('filterByRoom with room should filter', () async {
      final plants = [Plant()..id = 1..name = 'Monstera'..createdAt = DateTime.now()];
      mockRepository.roomResults = plants;

      final notifier = PlantsNotifier(mockRepository);
      await notifier.filterByRoom('Soggiorno');

      expect(mockRepository.getPlantsByRoomCalled, true);
      expect(notifier.state.value, plants);
    });
  });

  group('PlantNotifier', () {
    late _MockPlantRepository mockRepository;

    setUp(() {
      mockRepository = _MockPlantRepository();
    });

    test('initial state should be loading', () {
      final notifier = PlantNotifier(1, mockRepository);
      expect(notifier.state.isLoading, true);
    });

    test('loadPlant should update state', () async {
      final plant = Plant()..id = 1..name = 'Monstera'..createdAt = DateTime.now();
      mockRepository.plant = plant;

      final notifier = PlantNotifier(1, mockRepository);
      await notifier.loadPlant();

      expect(notifier.state.value, plant);
    });

    test('loadPlant should handle errors', () async {
      mockRepository.shouldThrow = true;

      final notifier = PlantNotifier(1, mockRepository);
      await notifier.loadPlant();

      expect(notifier.state.hasError, true);
    });

    test('updatePlant should call repository and update state', () async {
      final plant = Plant()..id = 1..name = 'Updated'..createdAt = DateTime.now();

      final notifier = PlantNotifier(1, mockRepository);
      await notifier.updatePlant(plant);

      expect(mockRepository.updatePlantCalled, true);
      expect(notifier.state.value, plant);
    });

    test('updatePlant should handle errors', () async {
      final plant = Plant()..id = 1..name = 'Updated'..createdAt = DateTime.now();
      mockRepository.shouldThrow = true;

      final notifier = PlantNotifier(1, mockRepository);
      await notifier.updatePlant(plant);

      expect(notifier.state.hasError, true);
    });
  });

  group('Provider definitions', () {
    test('plantRepositoryProvider should be defined', () {
      expect(plantRepositoryProvider, isNotNull);
    });

    test('plantsProvider should be defined', () {
      expect(plantsProvider, isNotNull);
    });

    test('plantProvider should be defined', () {
      expect(plantProvider, isNotNull);
    });

    test('plantsNeedingWaterProvider should be defined', () {
      expect(plantsNeedingWaterProvider, isNotNull);
    });

    test('plantCountProvider should be defined', () {
      expect(plantCountProvider, isNotNull);
    });

    test('plantRoomsProvider should be defined', () {
      expect(plantRoomsProvider, isNotNull);
    });
  });
}

class _MockPlantRepository implements PlantRepository {
  _MockPlantRepository({DatabaseService? databaseService}) : databaseService = databaseService ?? DatabaseService.instance;

  @override
  final DatabaseService databaseService;

  List<Plant> plants = [];
  Plant? plant;
  List<Plant> searchResults = [];
  List<Plant> roomResults = [];
  bool shouldThrow = false;

  bool addPlantCalled = false;
  bool deletePlantCalled = false;
  bool toggleFavoriteCalled = false;
  bool recordWateringCalled = false;
  bool getAllPlantsCalled = false;
  bool searchPlantsCalled = false;
  bool getPlantsByRoomCalled = false;
  bool updatePlantCalled = false;

  @override
  Future<List<Plant>> getAllPlants({bool includeArchived = false}) async {
    if (shouldThrow) throw Exception('DB error');
    getAllPlantsCalled = true;
    return plants;
  }

  @override
  Future<Plant?> getPlant(int id) async {
    if (shouldThrow) throw Exception('Not found');
    return plant;
  }

  @override
  Future<int> addPlant(Plant plant) async {
    addPlantCalled = true;
    return plant.id;
  }

  @override
  Future<void> updatePlant(Plant plant) async {
    if (shouldThrow) throw Exception('Update failed');
    updatePlantCalled = true;
  }

  @override
  Future<void> deletePlant(int id) async {
    deletePlantCalled = true;
  }

  @override
  Future<void> toggleFavorite(int id) async {
    toggleFavoriteCalled = true;
  }

  @override
  Future<void> recordWatering(int id) async {
    recordWateringCalled = true;
  }

  @override
  Future<List<Plant>> searchPlants(String query) async {
    searchPlantsCalled = true;
    return searchResults;
  }

  @override
  Future<List<Plant>> getPlantsByRoom(String room) async {
    getPlantsByRoomCalled = true;
    return roomResults;
  }

  @override
  Future<List<String>> getAllRooms() async => [];

  @override
  Future<List<Plant>> getPlantsNeedingWater(int days) async => [];

  @override
  Future<int> getPlantCount() async => 0;

  @override
  Future<void> archivePlant(int id) async {}

  @override
  Future<void> restorePlant(int id) async {}

  @override
  Future<void> recordFertilizing(int id) async {}

  @override
  Future<void> recordRepotting(int id) async {}

  @override
  Future<void> recordCleaning(int id) async {}

  @override
  Future<void> recordPruning(int id) async {}

  @override
  Future<void> recordMisting(int id) async {}

  @override
  Future<void> addGrowthEntry(int plantId, GrowthEntry entry) async {}

  @override
  Future<List<GrowthEntry>> getGrowthEntries(int plantId) async => [];

  @override
  Future<List<Map<String, dynamic>>> exportAllPlants() async => [];

  @override
  Future<void> importPlants(List<Map<String, dynamic>> plantsJson) async {}
}
