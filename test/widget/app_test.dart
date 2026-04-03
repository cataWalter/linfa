import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:linfa/app.dart';
import 'package:linfa/shared/providers/notification_provider.dart';

void main() {
  setUpAll(() async {
    // Initialize Hive for tests (using in-memory storage)
    Hive.init('test_hive_app');
    await Hive.openBox('notification_settings');
  });

  testWidgets('LinfaApp widget renders MaterialApp',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          notificationProvider.overrideWith((ref) => NotificationNotifier.test()),
        ],
        child: LinfaApp(),
      ),
    );

    await tester.pumpAndSettle();

    // Verify that MaterialApp is rendered
    expect(find.byType(MaterialApp), findsOneWidget);
  });

  testWidgets('LinfaApp widget has correct title', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          notificationProvider.overrideWith((ref) => NotificationNotifier.test()),
        ],
        child: LinfaApp(),
      ),
    );

    await tester.pumpAndSettle();

    final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
    expect(materialApp.title, 'Linfa');
  });

  testWidgets('LinfaApp widget has theme', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          notificationProvider.overrideWith((ref) => NotificationNotifier.test()),
        ],
        child: LinfaApp(),
      ),
    );

    await tester.pumpAndSettle();

    final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
    expect(materialApp.theme, isNotNull);
  });

  testWidgets('LinfaApp widget has dark theme', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          notificationProvider.overrideWith((ref) => NotificationNotifier.test()),
        ],
        child: LinfaApp(),
      ),
    );

    await tester.pumpAndSettle();

    final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
    expect(materialApp.darkTheme, isNotNull);
  });

  testWidgets('LinfaApp widget supports locale', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          notificationProvider.overrideWith((ref) => NotificationNotifier.test()),
        ],
        child: LinfaApp(),
      ),
    );

    await tester.pumpAndSettle();

    final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
    expect(materialApp.locale, isNotNull);
  });

  testWidgets('LinfaApp widget has supported locales',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          notificationProvider.overrideWith((ref) => NotificationNotifier.test()),
        ],
        child: LinfaApp(),
      ),
    );

    await tester.pumpAndSettle();

    final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
    expect(materialApp.supportedLocales, isNotEmpty);
  });

  testWidgets('LinfaApp widget has localizations delegates',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          notificationProvider.overrideWith((ref) => NotificationNotifier.test()),
        ],
        child: LinfaApp(),
      ),
    );

    await tester.pumpAndSettle();

    final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
    expect(materialApp.localizationsDelegates, isNotEmpty);
  });
}