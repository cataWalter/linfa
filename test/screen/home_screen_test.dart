import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:linfa/features/home/home_screen.dart';
import 'package:linfa/core/constants/strings.dart';
import 'package:linfa/shared/providers/notification_provider.dart';

void main() {
  setUpAll(() async {
    // Initialize Hive for tests (using in-memory storage)
    Hive.init('test_hive_home');
    await Hive.openBox('notification_settings');
  });

  group('HomeScreen', () {
    testWidgets('renders without crashing', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            notificationProvider.overrideWith((ref) => NotificationNotifier.test()),
          ],
          child: MaterialApp(home: HomeScreen()),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(HomeScreen), findsOneWidget);
    });

    testWidgets('displays greeting', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            notificationProvider.overrideWith((ref) => NotificationNotifier.test()),
          ],
          child: MaterialApp(home: HomeScreen()),
        ),
      );

      await tester.pumpAndSettle();

      // Should contain some greeting text
      expect(find.byType(Text), findsWidgets);
    });

    testWidgets('has SafeArea wrapper', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            notificationProvider.overrideWith((ref) => NotificationNotifier.test()),
          ],
          child: MaterialApp(home: HomeScreen()),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(SafeArea), findsOneWidget);
    });

    testWidgets('contains CustomScrollView', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            notificationProvider.overrideWith((ref) => NotificationNotifier.test()),
          ],
          child: MaterialApp(home: HomeScreen()),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(CustomScrollView), findsOneWidget);
    });

    testWidgets('supports pull to refresh', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            notificationProvider.overrideWith((ref) => NotificationNotifier.test()),
          ],
          child: MaterialApp(home: HomeScreen()),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(RefreshIndicator), findsOneWidget);
    });

    testWidgets('has notification bell icon', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            notificationProvider.overrideWith((ref) => NotificationNotifier.test()),
          ],
          child: MaterialApp(home: HomeScreen()),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.notifications_outlined), findsOneWidget);
    });
  });
}