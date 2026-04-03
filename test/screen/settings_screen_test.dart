import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:linfa/features/settings/settings_screen.dart';
import 'package:linfa/shared/providers/notification_provider.dart';

void main() {
  setUpAll(() async {
    // Initialize Hive for tests (using in-memory storage)
    Hive.init('test_hive_settings');
    await Hive.openBox('notification_settings');
  });

  group('SettingsScreen', () {
    testWidgets('renders without crashing', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            notificationProvider.overrideWith((ref) => NotificationNotifier.test()),
          ],
          child: const MaterialApp(home: SettingsScreen()),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(SettingsScreen), findsOneWidget);
    });

    testWidgets('has scaffold', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            notificationProvider.overrideWith((ref) => NotificationNotifier.test()),
          ],
          child: const MaterialApp(home: SettingsScreen()),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(Scaffold), findsOneWidget);
    });

    testWidgets('contains scrollable content', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            notificationProvider.overrideWith((ref) => NotificationNotifier.test()),
          ],
          child: const MaterialApp(home: SettingsScreen()),
        ),
      );

      await tester.pumpAndSettle();

      // Check for any scrollable widget
      expect(find.byType(Scrollable), findsOneWidget);
    });
  });
}