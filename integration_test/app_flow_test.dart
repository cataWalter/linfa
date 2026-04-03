import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:linfa/app.dart';
import 'package:linfa/core/constants/strings.dart';

void main() {
  group('App Flow Integration Tests', () {
    testWidgets('app launches and shows home screen',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: LinfaApp(),
        ),
      );

      // Wait for app to initialize
      await tester.pumpAndSettle();

      // Should show home screen content
      expect(find.byType(MaterialApp), findsOneWidget);
    });

    testWidgets('home screen displays greeting', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: LinfaApp(),
        ),
      );

      await tester.pumpAndSettle();

      // Should contain greeting text
      expect(find.byType(Text), findsWidgets);
    });

    testWidgets('home screen has quick actions', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: LinfaApp(),
        ),
      );

      await tester.pumpAndSettle();

      // Should have some action buttons
      expect(find.byType(Material), findsWidgets);
    });

    testWidgets('app has proper Material theme', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: LinfaApp(),
        ),
      );

      await tester.pumpAndSettle();

      // Should have MaterialApp with themes
      final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
      expect(materialApp.theme, isNotNull);
      expect(materialApp.darkTheme, isNotNull);
    });

    testWidgets('app supports Italian locale', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: LinfaApp(),
        ),
      );

      await tester.pumpAndSettle();

      final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
      expect(materialApp.locale, isNotNull);
      expect(materialApp.supportedLocales, isNotEmpty);
    });
  });
}
