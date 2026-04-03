import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:linfa/features/plants/edit_plant_screen.dart';
import 'package:linfa/core/constants/strings.dart';
import 'package:linfa/shared/providers/plant_provider.dart';
import 'package:linfa/shared/providers/notification_provider.dart';
import 'package:linfa/data/repositories/plant_repository.dart';
import 'package:linfa/data/database/database.dart';
import 'package:linfa/data/models/plant.dart';
import 'package:linfa/data/models/growth_entry.dart';
import 'package:isar/isar.dart';

void main() {
  setUpAll(() async {
    // Initialize Hive for tests (using in-memory storage)
    Hive.init('test_hive_edit');
    await Hive.openBox('notification_settings');
  });

  group('EditPlantScreen', () {
    testWidgets('renders without crashing', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            plantRepositoryProvider.overrideWith((ref) => _MockPlantRepository()),
            notificationProvider.overrideWith((ref) => NotificationNotifier.test()),
          ],
          child: const MaterialApp(
            home: EditPlantScreen(plantId: 1),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(EditPlantScreen), findsOneWidget);
    });

    testWidgets('displays app bar with edit plant title', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            plantRepositoryProvider.overrideWith((ref) => _MockPlantRepository()),
            notificationProvider.overrideWith((ref) => NotificationNotifier.test()),
          ],
          child: const MaterialApp(
            home: EditPlantScreen(plantId: 1),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text(AppStrings.editPlant), findsOneWidget);
    });

    testWidgets('has save button in app bar', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            plantRepositoryProvider.overrideWith((ref) => _MockPlantRepository()),
            notificationProvider.overrideWith((ref) => NotificationNotifier.test()),
          ],
          child: const MaterialApp(
            home: EditPlantScreen(plantId: 1),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text(AppStrings.save), findsOneWidget);
    });

    testWidgets('shows loading indicator initially', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            plantRepositoryProvider.overrideWith((ref) => _MockPlantRepository()),
            notificationProvider.overrideWith((ref) => NotificationNotifier.test()),
          ],
          child: const MaterialApp(
            home: EditPlantScreen(plantId: 1),
          ),
        ),
      );

      // Initial frame should show loading
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}

/// Mock PlantRepository for testing
class _MockPlantRepository implements PlantRepository {
  @override
  late final DatabaseService databaseService;

  _MockPlantRepository() : databaseService = DatabaseService.test(_MockIsar());

  @override
  Future<Plant?> getPlant(int id) async {
    return Plant()
      ..id = id
      ..name = 'Test Plant'
      ..species = 'Test Species'
      ..room = 'Test Room'
      ..lightCondition = 'indirect'
      ..status = 'healthy'
      ..createdAt = DateTime.now();
  }

  @override
  Future<List<Plant>> getAllPlants({bool includeArchived = false}) async => [];

  @override
  Future<int> addPlant(Plant plant) async {
    plant.id = 1;
    plant.createdAt = DateTime.now();
    return plant.id;
  }

  @override
  Future<void> updatePlant(Plant plant) async {}

  @override
  Future<void> deletePlant(int id) async {}

  @override
  Future<void> toggleFavorite(int id) async {}

  @override
  Future<void> recordWatering(int id) async {}

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
  Future<List<Plant>> searchPlants(String query) async => [];

  @override
  Future<List<Plant>> getPlantsByRoom(String room) async => [];

  @override
  Future<List<String>> getAllRooms() async => [];

  @override
  Future<List<Plant>> getPlantsNeedingWater(int days) async => [];

  @override
  Future<int> getPlantCount() async => 0;

  @override
  Future<void> archivePlant(int id) async {}

  @override
  Future<List<Map<String, dynamic>>> exportAllPlants() async => [];

  @override
  Future<void> importPlants(List<Map<String, dynamic>> plantsJson) async {}

  @override
  Future<void> addGrowthEntry(int plantId, GrowthEntry entry) async {}

  @override
  Future<List<GrowthEntry>> getGrowthEntries(int plantId) async => [];
}

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