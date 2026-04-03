import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:linfa/features/plants/widgets/plant_list_item.dart';
import 'package:linfa/core/constants/colors.dart';
import 'package:linfa/data/models/plant.dart';
import 'package:isar/isar.dart';

Plant createTestPlant({
  int id = Isar.autoIncrement,
  String name = 'Monstera',
  String? species = 'Monstera Deliciosa',
  String? room = 'Soggiorno',
  String? status = 'healthy',
  String? photoPath,
  bool isFavorite = false,
  DateTime? lastWatered,
}) {
  return Plant()
    ..id = id
    ..name = name
    ..species = species
    ..room = room
    ..status = status
    ..photoPath = photoPath
    ..isFavorite = isFavorite
    ..lastWatered = lastWatered;
}

void main() {
  group('PlantListItem', () {
    testWidgets('displays plant name', (WidgetTester tester) async {
      final plant = createTestPlant(name: 'Ficus');

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PlantListItem(plant: plant),
          ),
        ),
      );

      expect(find.text('Ficus'), findsOneWidget);
    });

    testWidgets('shows species', (WidgetTester tester) async {
      final plant = createTestPlant(species: 'Ficus Elastica');

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PlantListItem(plant: plant),
          ),
        ),
      );

      expect(find.text('Ficus Elastica'), findsOneWidget);
    });

    testWidgets('shows room', (WidgetTester tester) async {
      final plant = createTestPlant(room: 'Cucina');

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PlantListItem(plant: plant),
          ),
        ),
      );

      expect(find.text('Cucina'), findsOneWidget);
    });

    testWidgets('shows placeholder when no photo', (WidgetTester tester) async {
      final plant = createTestPlant(photoPath: null);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PlantListItem(plant: plant),
          ),
        ),
      );

      expect(find.byIcon(Icons.eco_outlined), findsOneWidget);
    });

    testWidgets('shows watering indicator when watered',
        (WidgetTester tester) async {
      final plant = createTestPlant(
        lastWatered: DateTime.now().subtract(const Duration(days: 2)),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PlantListItem(plant: plant),
          ),
        ),
      );

      expect(find.byIcon(Icons.water_drop), findsOneWidget);
      expect(find.byIcon(Icons.chevron_right), findsNothing);
    });

    testWidgets('shows chevron when not watered', (WidgetTester tester) async {
      final plant = createTestPlant(lastWatered: null);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PlantListItem(plant: plant),
          ),
        ),
      );

      expect(find.byIcon(Icons.chevron_right), findsOneWidget);
      expect(find.byIcon(Icons.water_drop), findsNothing);
    });

    testWidgets('renders as Card with ListTile', (WidgetTester tester) async {
      final plant = createTestPlant();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PlantListItem(plant: plant),
          ),
        ),
      );

      expect(find.byType(Card), findsOneWidget);
      expect(find.byType(ListTile), findsOneWidget);
    });

    testWidgets('shows both species and room when both available',
        (WidgetTester tester) async {
      final plant = createTestPlant(
        species: 'Monstera Deliciosa',
        room: 'Soggiorno',
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PlantListItem(plant: plant),
          ),
        ),
      );

      expect(find.text('Monstera Deliciosa'), findsOneWidget);
      expect(find.text('Soggiorno'), findsOneWidget);
    });

    testWidgets('does not show species when null', (WidgetTester tester) async {
      final plant = createTestPlant(species: null);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PlantListItem(plant: plant),
          ),
        ),
      );

      expect(find.text('Monstera Deliciosa'), findsNothing);
    });

    testWidgets('does not show room when null', (WidgetTester tester) async {
      final plant = createTestPlant(room: null);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PlantListItem(plant: plant),
          ),
        ),
      );

      expect(find.text('Soggiorno'), findsNothing);
    });
  });
}
