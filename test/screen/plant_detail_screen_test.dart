import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:linfa/features/plants/plant_detail_screen.dart';
import 'package:linfa/data/models/plant.dart';
import 'package:linfa/data/models/reminder.dart';
import 'package:linfa/shared/providers/plant_provider.dart';
import 'package:linfa/shared/providers/reminder_provider.dart';
import 'package:linfa/data/repositories/plant_repository.dart';
import 'package:linfa/data/repositories/reminder_repository.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([PlantRepository, ReminderRepository])
import 'plant_detail_screen_test.mocks.dart';

void main() {
  group('PlantDetailScreen', () {
    Plant createTestPlant({int id = 1, String name = 'Monstera'}) {
      return Plant()
        ..id = id
        ..name = name
        ..species = 'Monstera Deliciosa'
        ..room = 'Soggiorno'
        ..lightCondition = 'indirect_bright'
        ..status = 'healthy'
        ..createdAt = DateTime.now()
        ..lastWatered = DateTime.now().subtract(const Duration(days: 2));
    }

    Reminder createTestReminder({
      int id = 1,
      String type = 'watering',
      int frequencyDays = 7,
    }) {
      return Reminder()
        ..id = id
        ..type = type
        ..frequencyDays = frequencyDays
        ..time = DateTime.now()
        ..lastTriggered = DateTime.now().subtract(Duration(days: frequencyDays + 1));
    }

    testWidgets('renders without crashing', (tester) async {
      final plant = createTestPlant();
      final mockPlantRepo = MockPlantRepository();
      final mockReminderRepo = MockReminderRepository();
      when(mockPlantRepo.getPlant(any)).thenAnswer((_) async => plant);
      when(mockReminderRepo.getRemindersForPlant(any)).thenAnswer((_) async => []);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            plantRepositoryProvider.overrideWithValue(mockPlantRepo),
            reminderRepositoryProvider.overrideWithValue(mockReminderRepo),
          ],
          child: MaterialApp(
            home: PlantDetailScreen(plantId: plant.id),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(PlantDetailScreen), findsOneWidget);
    });

    testWidgets('displays plant name', (tester) async {
      final plant = createTestPlant(name: 'Test Plant');
      final mockPlantRepo = MockPlantRepository();
      final mockReminderRepo = MockReminderRepository();
      when(mockPlantRepo.getPlant(any)).thenAnswer((_) async => plant);
      when(mockReminderRepo.getRemindersForPlant(any)).thenAnswer((_) async => []);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            plantRepositoryProvider.overrideWithValue(mockPlantRepo),
            reminderRepositoryProvider.overrideWithValue(mockReminderRepo),
          ],
          child: MaterialApp(
            home: PlantDetailScreen(plantId: plant.id),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Test Plant'), findsOneWidget);
    });

    testWidgets('displays species when available', (tester) async {
      final plant = createTestPlant();
      final mockPlantRepo = MockPlantRepository();
      final mockReminderRepo = MockReminderRepository();
      when(mockPlantRepo.getPlant(any)).thenAnswer((_) async => plant);
      when(mockReminderRepo.getRemindersForPlant(any)).thenAnswer((_) async => []);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            plantRepositoryProvider.overrideWithValue(mockPlantRepo),
            reminderRepositoryProvider.overrideWithValue(mockReminderRepo),
          ],
          child: MaterialApp(
            home: PlantDetailScreen(plantId: plant.id),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Monstera Deliciosa'), findsOneWidget);
    });

    testWidgets('displays room when available', (tester) async {
      final plant = createTestPlant();
      final mockPlantRepo = MockPlantRepository();
      final mockReminderRepo = MockReminderRepository();
      when(mockPlantRepo.getPlant(any)).thenAnswer((_) async => plant);
      when(mockReminderRepo.getRemindersForPlant(any)).thenAnswer((_) async => []);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            plantRepositoryProvider.overrideWithValue(mockPlantRepo),
            reminderRepositoryProvider.overrideWithValue(mockReminderRepo),
          ],
          child: MaterialApp(
            home: PlantDetailScreen(plantId: plant.id),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Soggiorno'), findsOneWidget);
    });

    testWidgets('shows error when plant is null', (tester) async {
      final mockPlantRepo = MockPlantRepository();
      final mockReminderRepo = MockReminderRepository();
      when(mockPlantRepo.getPlant(any)).thenAnswer((_) async => null);
      when(mockReminderRepo.getRemindersForPlant(any)).thenAnswer((_) async => []);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            plantRepositoryProvider.overrideWithValue(mockPlantRepo),
            reminderRepositoryProvider.overrideWithValue(mockReminderRepo),
          ],
          child: MaterialApp(
            home: PlantDetailScreen(plantId: 1),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Pianta non trovata'), findsOneWidget);
    });

    testWidgets('shows loading state', (tester) async {
      final mockPlantRepo = MockPlantRepository();
      final mockReminderRepo = MockReminderRepository();
      when(mockPlantRepo.getPlant(any)).thenAnswer((_) async => null);
      when(mockReminderRepo.getRemindersForPlant(any)).thenAnswer((_) async => []);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            plantRepositoryProvider.overrideWithValue(mockPlantRepo),
            reminderRepositoryProvider.overrideWithValue(mockReminderRepo),
          ],
          child: MaterialApp(
            home: PlantDetailScreen(plantId: 1),
          ),
        ),
      );

      // Before pumpAndSettle, it should show loading
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('shows error state', (tester) async {
      final mockPlantRepo = MockPlantRepository();
      final mockReminderRepo = MockReminderRepository();
      when(mockPlantRepo.getPlant(any)).thenThrow(Exception('Error'));
      when(mockReminderRepo.getRemindersForPlant(any)).thenAnswer((_) async => []);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            plantRepositoryProvider.overrideWithValue(mockPlantRepo),
            reminderRepositoryProvider.overrideWithValue(mockReminderRepo),
          ],
          child: MaterialApp(
            home: PlantDetailScreen(plantId: 1),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.textContaining('Errore'), findsOneWidget);
    });

    testWidgets('has back button', (tester) async {
      final plant = createTestPlant();
      final mockPlantRepo = MockPlantRepository();
      final mockReminderRepo = MockReminderRepository();
      when(mockPlantRepo.getPlant(any)).thenAnswer((_) async => plant);
      when(mockReminderRepo.getRemindersForPlant(any)).thenAnswer((_) async => []);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            plantRepositoryProvider.overrideWithValue(mockPlantRepo),
            reminderRepositoryProvider.overrideWithValue(mockReminderRepo),
          ],
          child: MaterialApp(
            home: PlantDetailScreen(plantId: plant.id),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.arrow_back), findsOneWidget);
    });

    testWidgets('has favorite button', (tester) async {
      final plant = createTestPlant();
      final mockPlantRepo = MockPlantRepository();
      final mockReminderRepo = MockReminderRepository();
      when(mockPlantRepo.getPlant(any)).thenAnswer((_) async => plant);
      when(mockReminderRepo.getRemindersForPlant(any)).thenAnswer((_) async => []);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            plantRepositoryProvider.overrideWithValue(mockPlantRepo),
            reminderRepositoryProvider.overrideWithValue(mockReminderRepo),
          ],
          child: MaterialApp(
            home: PlantDetailScreen(plantId: plant.id),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.favorite_border), findsOneWidget);
    });

    testWidgets('has more menu button', (tester) async {
      final plant = createTestPlant();
      final mockPlantRepo = MockPlantRepository();
      final mockReminderRepo = MockReminderRepository();
      when(mockPlantRepo.getPlant(any)).thenAnswer((_) async => plant);
      when(mockReminderRepo.getRemindersForPlant(any)).thenAnswer((_) async => []);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            plantRepositoryProvider.overrideWithValue(mockPlantRepo),
            reminderRepositoryProvider.overrideWithValue(mockReminderRepo),
          ],
          child: MaterialApp(
            home: PlantDetailScreen(plantId: plant.id),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.more_vert), findsOneWidget);
    });

    testWidgets('has growth timeline button', (tester) async {
      final plant = createTestPlant();
      final mockPlantRepo = MockPlantRepository();
      final mockReminderRepo = MockReminderRepository();
      when(mockPlantRepo.getPlant(any)).thenAnswer((_) async => plant);
      when(mockReminderRepo.getRemindersForPlant(any)).thenAnswer((_) async => []);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            plantRepositoryProvider.overrideWithValue(mockPlantRepo),
            reminderRepositoryProvider.overrideWithValue(mockReminderRepo),
          ],
          child: MaterialApp(
            home: PlantDetailScreen(plantId: plant.id),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.timeline), findsOneWidget);
    });

    testWidgets('shows empty reminders when none exist', (tester) async {
      final plant = createTestPlant();
      final mockPlantRepo = MockPlantRepository();
      final mockReminderRepo = MockReminderRepository();
      when(mockPlantRepo.getPlant(any)).thenAnswer((_) async => plant);
      when(mockReminderRepo.getRemindersForPlant(any)).thenAnswer((_) async => []);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            plantRepositoryProvider.overrideWithValue(mockPlantRepo),
            reminderRepositoryProvider.overrideWithValue(mockReminderRepo),
          ],
          child: MaterialApp(
            home: PlantDetailScreen(plantId: plant.id),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Nessun promemoria impostato'), findsOneWidget);
    });

    testWidgets('shows reminders when they exist', (tester) async {
      final plant = createTestPlant();
      final reminder = createTestReminder();
      final mockPlantRepo = MockPlantRepository();
      final mockReminderRepo = MockReminderRepository();
      when(mockPlantRepo.getPlant(any)).thenAnswer((_) async => plant);
      when(mockReminderRepo.getRemindersForPlant(any)).thenAnswer((_) async => [reminder]);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            plantRepositoryProvider.overrideWithValue(mockPlantRepo),
            reminderRepositoryProvider.overrideWithValue(mockReminderRepo),
          ],
          child: MaterialApp(
            home: PlantDetailScreen(plantId: plant.id),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Annaffiare'), findsOneWidget);
    });

    testWidgets('shows care stats grid', (tester) async {
      final plant = createTestPlant();
      final mockPlantRepo = MockPlantRepository();
      final mockReminderRepo = MockReminderRepository();
      when(mockPlantRepo.getPlant(any)).thenAnswer((_) async => plant);
      when(mockReminderRepo.getRemindersForPlant(any)).thenAnswer((_) async => []);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            plantRepositoryProvider.overrideWithValue(mockPlantRepo),
            reminderRepositoryProvider.overrideWithValue(mockReminderRepo),
          ],
          child: MaterialApp(
            home: PlantDetailScreen(plantId: plant.id),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Statistiche Cura'), findsOneWidget);
    });

    testWidgets('shows quick actions', (tester) async {
      final plant = createTestPlant();
      final mockPlantRepo = MockPlantRepository();
      final mockReminderRepo = MockReminderRepository();
      when(mockPlantRepo.getPlant(any)).thenAnswer((_) async => plant);
      when(mockReminderRepo.getRemindersForPlant(any)).thenAnswer((_) async => []);
      when(mockPlantRepo.recordWatering(any)).thenAnswer((_) async {});
      when(mockPlantRepo.recordFertilizing(any)).thenAnswer((_) async {});
      when(mockPlantRepo.recordMisting(any)).thenAnswer((_) async {});
      when(mockPlantRepo.getAllPlants()).thenAnswer((_) async => [plant]);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            plantRepositoryProvider.overrideWithValue(mockPlantRepo),
            reminderRepositoryProvider.overrideWithValue(mockReminderRepo),
          ],
          child: MaterialApp(
            home: PlantDetailScreen(plantId: plant.id),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Azioni Rapide'), findsOneWidget);
      expect(find.byIcon(Icons.water_drop), findsWidgets);
    });

    testWidgets('shows light condition card', (tester) async {
      final plant = createTestPlant();
      final mockPlantRepo = MockPlantRepository();
      final mockReminderRepo = MockReminderRepository();
      when(mockPlantRepo.getPlant(any)).thenAnswer((_) async => plant);
      when(mockReminderRepo.getRemindersForPlant(any)).thenAnswer((_) async => []);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            plantRepositoryProvider.overrideWithValue(mockPlantRepo),
            reminderRepositoryProvider.overrideWithValue(mockReminderRepo),
          ],
          child: MaterialApp(
            home: PlantDetailScreen(plantId: plant.id),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Condizione Luce'), findsOneWidget);
    });

    testWidgets('shows notes when available', (tester) async {
      final plant = createTestPlant();
      plant.notes = 'Some notes about the plant';
      final mockPlantRepo = MockPlantRepository();
      final mockReminderRepo = MockReminderRepository();
      when(mockPlantRepo.getPlant(any)).thenAnswer((_) async => plant);
      when(mockReminderRepo.getRemindersForPlant(any)).thenAnswer((_) async => []);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            plantRepositoryProvider.overrideWithValue(mockPlantRepo),
            reminderRepositoryProvider.overrideWithValue(mockReminderRepo),
          ],
          child: MaterialApp(
            home: PlantDetailScreen(plantId: plant.id),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Note'), findsOneWidget);
    });

    testWidgets('shows add reminder button', (tester) async {
      final plant = createTestPlant();
      final mockPlantRepo = MockPlantRepository();
      final mockReminderRepo = MockReminderRepository();
      when(mockPlantRepo.getPlant(any)).thenAnswer((_) async => plant);
      when(mockReminderRepo.getRemindersForPlant(any)).thenAnswer((_) async => []);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            plantRepositoryProvider.overrideWithValue(mockPlantRepo),
            reminderRepositoryProvider.overrideWithValue(mockReminderRepo),
          ],
          child: MaterialApp(
            home: PlantDetailScreen(plantId: plant.id),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.add), findsOneWidget);
    });
  });
}