import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:linfa/features/plants/add_plant_screen.dart';
import 'package:linfa/core/constants/strings.dart';
import 'package:linfa/core/constants/enums.dart';
import 'package:linfa/shared/providers/plant_provider.dart';

void main() {
  group('AddPlantScreen', () {
    testWidgets('renders without crashing', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: AddPlantScreen(),
          ),
        ),
      );

      expect(find.byType(AddPlantScreen), findsOneWidget);
    });

    testWidgets('displays app bar with add plant title', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: AddPlantScreen(),
          ),
        ),
      );

      expect(find.text(AppStrings.addPlant), findsOneWidget);
    });

    testWidgets('has save button in app bar', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: AddPlantScreen(),
          ),
        ),
      );

      expect(find.text(AppStrings.save), findsOneWidget);
    });

    testWidgets('has plant name field', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: AddPlantScreen(),
          ),
        ),
      );

      expect(find.text(AppStrings.plantName), findsOneWidget);
    });

    testWidgets('has species field', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: AddPlantScreen(),
          ),
        ),
      );

      expect(find.text(AppStrings.species), findsOneWidget);
    });

    testWidgets('has room field', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: AddPlantScreen(),
          ),
        ),
      );

      expect(find.text(AppStrings.room), findsOneWidget);
    });

    testWidgets('has light condition chips', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: AddPlantScreen(),
          ),
        ),
      );

      expect(find.text(AppStrings.lightCondition), findsOneWidget);
      expect(find.byType(ChoiceChip), findsWidgets);
    });

    testWidgets('has plant status chips', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: AddPlantScreen(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Check that ChoiceChip widgets exist (for plant status)
      expect(find.byType(ChoiceChip), findsWidgets);
    });

    testWidgets('has notes field', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: AddPlantScreen(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Check that TextFormField widgets exist (notes field is one of them)
      expect(find.byType(TextFormField), findsWidgets);
    });

    testWidgets('has form widget', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: AddPlantScreen(),
          ),
        ),
      );

      expect(find.byType(Form), findsOneWidget);
    });

    testWidgets('has ListView for scrolling', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: AddPlantScreen(),
          ),
        ),
      );

      expect(find.byType(ListView), findsOneWidget);
    });

    testWidgets('validates plant name is required', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: AddPlantScreen(),
          ),
        ),
      );

      await tester.tap(find.text(AppStrings.save));
      await tester.pump();

      expect(find.text('Inserisci un nome'), findsOneWidget);
    });
  });
}
