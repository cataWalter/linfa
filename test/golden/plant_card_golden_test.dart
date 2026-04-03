import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:linfa/features/home/widgets/plant_card.dart';
import 'package:linfa/data/models/plant.dart';
import '../helpers/test_constants.dart';

void main() {
  group('PlantCard Golden Tests', () {
    testWidgets('plant card with photo matches golden',
        (WidgetTester tester) async {
      final plant =
          createTestPlant(name: 'Monstera', photoPath: '/test/photo.jpg');

      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.light(),
          home: Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: PlantCard(plant: plant),
            ),
          ),
        ),
      );

      await expectLater(
        find.byType(PlantCard),
        matchesGoldenFile('plant_card_with_photo.png'),
      );
    });

    testWidgets('plant card without photo matches golden',
        (WidgetTester tester) async {
      final plant = createTestPlant(name: 'Ficus', species: 'Elastica');

      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.light(),
          home: Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: PlantCard(plant: plant),
            ),
          ),
        ),
      );

      await expectLater(
        find.byType(PlantCard),
        matchesGoldenFile('plant_card_no_photo.png'),
      );
    });

    testWidgets('plant card favorite matches golden',
        (WidgetTester tester) async {
      final plant = createTestPlant(name: 'Snake Plant', isFavorite: true);

      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.light(),
          home: Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: PlantCard(plant: plant),
            ),
          ),
        ),
      );

      await expectLater(
        find.byType(PlantCard),
        matchesGoldenFile('plant_card_favorite.png'),
      );
    });

    testWidgets('plant card different health status matches golden',
        (WidgetTester tester) async {
      final plant = createTestPlant(name: 'Peace Lily', status: 'stressed');

      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.light(),
          home: Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: PlantCard(plant: plant),
            ),
          ),
        ),
      );

      await expectLater(
        find.byType(PlantCard),
        matchesGoldenFile('plant_card_stressed.png'),
      );
    });

    testWidgets('plant card recently watered matches golden',
        (WidgetTester tester) async {
      final plant = createTestPlant(
        name: 'Spider Plant',
        lastWatered: DateTime.now().subtract(const Duration(days: 1)),
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.light(),
          home: Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: PlantCard(plant: plant),
            ),
          ),
        ),
      );

      await expectLater(
        find.byType(PlantCard),
        matchesGoldenFile('plant_card_watered.png'),
      );
    });
  });
}
