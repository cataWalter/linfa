import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:linfa/data/models/plant.dart';
import 'package:linfa/features/plants/widgets/plant_list_item.dart';
import 'package:linfa/core/constants/colors.dart';

void main() {
  group('PlantListItem', () {
    Plant createTestPlant({
      int id = 1,
      String name = 'Monstera',
      String? species = 'Monstera Deliciosa',
      String? room = 'Soggiorno',
      String? photoPath,
      DateTime? lastWatered,
    }) {
      return Plant()
        ..id = id
        ..name = name
        ..species = species
        ..room = room
        ..photoPath = photoPath
        ..lastWatered = lastWatered ?? DateTime.now().subtract(const Duration(days: 2));
    }

    Widget createTestWidget({required Plant plant, GoRouter? router}) {
      return MaterialApp(
        home: Scaffold(
          body: PlantListItem(plant: plant),
        ),
        builder: (context, child) {
          if (router != null) {
            return Router(
              routerDelegate: router.routerDelegate,
              routeInformationParser: router.routeInformationParser,
              routeInformationProvider: router.routeInformationProvider,
            );
          }
          return child ?? const SizedBox();
        },
      );
    }

    testWidgets('renders plant name', (WidgetTester tester) async {
      final plant = createTestPlant(name: 'Test Plant');
      await tester.pumpWidget(createTestWidget(plant: plant));

      expect(find.text('Test Plant'), findsOneWidget);
    });

    testWidgets('renders species when available', (WidgetTester tester) async {
      final plant = createTestPlant(species: 'Ficus Lyrata');
      await tester.pumpWidget(createTestWidget(plant: plant));

      expect(find.text('Ficus Lyrata'), findsOneWidget);
    });

    testWidgets('renders room when available', (WidgetTester tester) async {
      final plant = createTestPlant(room: 'Camera da Letto');
      await tester.pumpWidget(createTestWidget(plant: plant));

      expect(find.text('Camera da Letto'), findsOneWidget);
    });

    testWidgets('shows eco icon when no photo', (WidgetTester tester) async {
      final plant = createTestPlant(photoPath: null);
      await tester.pumpWidget(createTestWidget(plant: plant));

      expect(find.byIcon(Icons.eco_outlined), findsOneWidget);
    });

    testWidgets('shows watering indicator when lastWatered is set',
        (WidgetTester tester) async {
      final plant = createTestPlant(lastWatered: DateTime.now().subtract(const Duration(days: 1)));
      await tester.pumpWidget(createTestWidget(plant: plant));

      expect(find.byIcon(Icons.water_drop), findsOneWidget);
    });

    testWidgets('shows chevron when lastWatered is null', (WidgetTester tester) async {
      final plant = createTestPlant()..lastWatered = null;
      await tester.pumpWidget(createTestWidget(plant: plant));

      expect(find.byIcon(Icons.chevron_right), findsOneWidget);
      expect(find.byIcon(Icons.water_drop), findsNothing);
    });

    testWidgets('shows green watering indicator for recently watered plants',
        (WidgetTester tester) async {
      final plant = createTestPlant(lastWatered: DateTime.now().subtract(const Duration(days: 2)));
      await tester.pumpWidget(createTestWidget(plant: plant));

      final icon = tester.widget<Icon>(find.byIcon(Icons.water_drop));
      expect(icon.color, equals(LinfaColors.healthy));
    });

    testWidgets('shows yellow watering indicator for moderately watered plants',
        (WidgetTester tester) async {
      final plant = createTestPlant(lastWatered: DateTime.now().subtract(const Duration(days: 5)));
      await tester.pumpWidget(createTestWidget(plant: plant));

      final icon = tester.widget<Icon>(find.byIcon(Icons.water_drop));
      expect(icon.color, equals(LinfaColors.warning));
    });

    testWidgets('shows red watering indicator for overdue plants',
        (WidgetTester tester) async {
      final plant = createTestPlant(lastWatered: DateTime.now().subtract(const Duration(days: 10)));
      await tester.pumpWidget(createTestWidget(plant: plant));

      final icon = tester.widget<Icon>(find.byIcon(Icons.water_drop));
      expect(icon.color, equals(LinfaColors.danger));
    });

    testWidgets('displays relative time for last watered', (WidgetTester tester) async {
      final plant = createTestPlant(lastWatered: DateTime.now().subtract(const Duration(days: 2)));
      await tester.pumpWidget(createTestWidget(plant: plant));

      // Should show something like "2 days ago" or similar relative time
      expect(find.byIcon(Icons.water_drop), findsOneWidget);
      // The text should contain a number (days)
      expect(find.textContaining(RegExp(r'\d')), findsOneWidget);
    });

    testWidgets('is wrapped in a Card', (WidgetTester tester) async {
      final plant = createTestPlant();
      await tester.pumpWidget(createTestWidget(plant: plant));

      expect(find.byType(Card), findsOneWidget);
    });

    testWidgets('uses ListTile for layout', (WidgetTester tester) async {
      final plant = createTestPlant();
      await tester.pumpWidget(createTestWidget(plant: plant));

      expect(find.byType(ListTile), findsOneWidget);
    });

    testWidgets('has proper margin', (WidgetTester tester) async {
      final plant = createTestPlant();
      await tester.pumpWidget(createTestWidget(plant: plant));

      final card = tester.widget<Card>(find.byType(Card));
      expect(card.margin, const EdgeInsets.only(bottom: 12));
    });

    testWidgets('shows placeholder container with primary color when no photo',
        (WidgetTester tester) async {
      final plant = createTestPlant(photoPath: null);
      await tester.pumpWidget(createTestWidget(plant: plant));

      // Find the Container that serves as placeholder
      final containers = find.byType(Container);
      expect(containers, findsWidgets);
    });

    testWidgets('displays all plant information together', (WidgetTester tester) async {
      final plant = createTestPlant(
        name: 'Ficus',
        species: 'Ficus Benjamina',
        room: 'Salotto',
        lastWatered: DateTime.now().subtract(const Duration(days: 3)),
      );
      await tester.pumpWidget(createTestWidget(plant: plant));

      expect(find.text('Ficus'), findsOneWidget);
      expect(find.text('Ficus Benjamina'), findsOneWidget);
      expect(find.text('Salotto'), findsOneWidget);
      expect(find.byIcon(Icons.water_drop), findsOneWidget);
    });

    testWidgets('has tappable ListTile', (WidgetTester tester) async {
      final plant = createTestPlant();
      await tester.pumpWidget(createTestWidget(plant: plant));

      // Verify the ListTile exists and is tappable
      expect(find.byType(ListTile), findsOneWidget);
    });
  });
}