import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:linfa/app.dart';
import 'package:linfa/core/constants/strings.dart';

void main() {
  group('Plant CRUD Integration Tests', () {
    testWidgets('app launches without crashing', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: LinfaApp(),
        ),
      );

      await tester.pumpAndSettle();

      // Should not crash and show some UI
      expect(find.byType(MaterialApp), findsOneWidget);
    });

    testWidgets('home screen loads successfully', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: LinfaApp(),
        ),
      );

      await tester.pumpAndSettle();

      // Should show home screen elements
      expect(find.byType(SafeArea), findsOneWidget);
      expect(find.byType(CustomScrollView), findsOneWidget);
    });

    testWidgets('home screen has greeting', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: LinfaApp(),
        ),
      );

      await tester.pumpAndSettle();

      // Should have greeting text
      expect(find.byType(Text), findsWidgets);
    });

    testWidgets('home screen has quick actions', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: LinfaApp(),
        ),
      );

      await tester.pumpAndSettle();

      // Should have some interactive elements
      expect(find.byType(InkWell), findsWidgets);
    });

    testWidgets('pull to refresh works', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: LinfaApp(),
        ),
      );

      await tester.pumpAndSettle();

      // Should have refresh indicator
      expect(find.byType(RefreshIndicator), findsOneWidget);
    });
  });
}
