import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:linfa/features/home/widgets/plant_card.dart';
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
  group('PlantCard', () {
    testWidgets('displays plant name', (WidgetTester tester) async {
      final plant = createTestPlant(name: 'Ficus');

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 200,
              height: 300,
              child: PlantCard(plant: plant),
            ),
          ),
        ),
      );

      expect(find.text('Ficus'), findsOneWidget);
    });

    testWidgets('shows species when available', (WidgetTester tester) async {
      final plant = createTestPlant(species: 'Ficus Elastica');

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 200,
              height: 300,
              child: PlantCard(plant: plant),
            ),
          ),
        ),
      );

      expect(find.text('Ficus Elastica'), findsOneWidget);
    });

    testWidgets('shows room when available', (WidgetTester tester) async {
      final plant = createTestPlant(room: 'Cucina');

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 200,
              height: 300,
              child: PlantCard(plant: plant),
            ),
          ),
        ),
      );

      expect(find.text('Cucina'), findsOneWidget);
    });

    testWidgets('shows gradient placeholder when no photo',
        (WidgetTester tester) async {
      final plant = createTestPlant(photoPath: null);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 200,
              height: 300,
              child: PlantCard(plant: plant),
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.eco_outlined), findsOneWidget);
    });

    testWidgets('shows health status badge', (WidgetTester tester) async {
      final plant = createTestPlant(status: 'healthy');

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 200,
              height: 300,
              child: PlantCard(plant: plant),
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.eco), findsOneWidget);
    });

    testWidgets('shows favorite badge when isFavorite',
        (WidgetTester tester) async {
      final plant = createTestPlant(isFavorite: true);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 200,
              height: 300,
              child: PlantCard(plant: plant),
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.favorite), findsWidgets);
    });

    testWidgets('shows watering status indicator', (WidgetTester tester) async {
      final plant = createTestPlant(
        lastWatered: DateTime.now().subtract(const Duration(days: 2)),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 200,
              height: 300,
              child: PlantCard(plant: plant),
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.water_drop), findsOneWidget);
    });

    testWidgets('shows warning watering indicator for overdue plants',
        (WidgetTester tester) async {
      final plant = createTestPlant(
        lastWatered: DateTime.now().subtract(const Duration(days: 4)),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 200,
              height: 300,
              child: PlantCard(plant: plant),
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.water_drop_outlined), findsOneWidget);
    });

    testWidgets('shows "Mai annaffiata" when never watered',
        (WidgetTester tester) async {
      final plant = createTestPlant(lastWatered: null);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 200,
              height: 300,
              child: PlantCard(plant: plant),
            ),
          ),
        ),
      );

      expect(find.text('Mai annaffiata'), findsOneWidget);
    });

    testWidgets('renders as Card widget', (WidgetTester tester) async {
      final plant = createTestPlant();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 200,
              height: 300,
              child: PlantCard(plant: plant),
            ),
          ),
        ),
      );

      expect(find.byType(Card), findsOneWidget);
    });

    testWidgets('is tappable', (WidgetTester tester) async {
      final plant = createTestPlant();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 200,
              height: 300,
              child: PlantCard(plant: plant),
            ),
          ),
        ),
      );

      expect(find.byType(InkWell), findsOneWidget);
    });
  });
}
