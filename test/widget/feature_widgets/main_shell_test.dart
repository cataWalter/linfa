import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:linfa/features/main_shell.dart';
import 'package:linfa/shared/providers/notification_provider.dart';

void main() {
  setUpAll(() async {
    // Initialize Hive for tests (using in-memory storage)
    Hive.init('test_hive');
    await Hive.openBox('notification_settings');
  });

  group('MainShell', () {
    testWidgets('renders MainShell widget', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            notificationProvider.overrideWith((ref) => NotificationNotifier.test()),
          ],
          child: const MaterialApp(
            home: MainShell(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(MainShell), findsOneWidget);
    });

    testWidgets('has NavigationBar', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            notificationProvider.overrideWith((ref) => NotificationNotifier.test()),
          ],
          child: const MaterialApp(
            home: MainShell(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(NavigationBar), findsOneWidget);
    });

    testWidgets('has 4 navigation destinations', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            notificationProvider.overrideWith((ref) => NotificationNotifier.test()),
          ],
          child: const MaterialApp(
            home: MainShell(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(NavigationDestination), findsNWidgets(4));
    });

    testWidgets('has IndexedStack for screen management', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            notificationProvider.overrideWith((ref) => NotificationNotifier.test()),
          ],
          child: const MaterialApp(
            home: MainShell(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(IndexedStack), findsOneWidget);
    });

    testWidgets('can tap navigation items without crashing', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            notificationProvider.overrideWith((ref) => NotificationNotifier.test()),
          ],
          child: const MaterialApp(
            home: MainShell(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Find the NavigationBar and tap on each destination
      final navBar = find.byType(NavigationBar);
      expect(navBar, findsOneWidget);

      // Tap on each navigation item (indices 0-3)
      for (int i = 0; i < 4; i++) {
        await tester.tap(find.descendant(
          of: navBar,
          matching: find.byType(NavigationDestination).at(i),
        ));
        await tester.pumpAndSettle();
      }

      // Verify the widget is still rendered
      expect(find.byType(MainShell), findsOneWidget);
    });
  });
}