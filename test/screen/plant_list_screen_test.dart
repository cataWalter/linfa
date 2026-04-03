import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:linfa/features/plants/plant_list_screen.dart';
import 'package:linfa/core/constants/strings.dart';

void main() {
  group('PlantListScreen', () {
    testWidgets('renders without crashing', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(home: PlantListScreen()),
        ),
      );

      expect(find.byType(PlantListScreen), findsOneWidget);
    });

    testWidgets('has app bar with correct title', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(home: PlantListScreen()),
        ),
      );

      expect(find.widgetWithText(AppBar, AppStrings.myPlants), findsOneWidget);
    });

    testWidgets('has filter button in app bar', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(home: PlantListScreen()),
        ),
      );

      expect(find.byIcon(Icons.filter_list), findsOneWidget);
    });

    testWidgets('has search text field', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(home: PlantListScreen()),
        ),
      );

      expect(find.byType(TextField), findsOneWidget);
    });

    testWidgets('has floating action button', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(home: PlantListScreen()),
        ),
      );

      expect(find.byType(FloatingActionButton), findsOneWidget);
    });

    testWidgets('FAB has add icon', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(home: PlantListScreen()),
        ),
      );

      expect(find.byIcon(Icons.add), findsOneWidget);
    });

    testWidgets('contains column layout', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(home: PlantListScreen()),
        ),
      );

      expect(find.byType(Column), findsWidgets);
    });

    testWidgets('contains expanded widget for list',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(home: PlantListScreen()),
        ),
      );

      expect(find.byType(Expanded), findsOneWidget);
    });
  });
}
