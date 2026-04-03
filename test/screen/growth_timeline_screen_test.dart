import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:linfa/features/growth/growth_timeline_screen.dart';
import 'package:linfa/core/constants/strings.dart';
import 'package:linfa/shared/providers/notification_provider.dart';

void main() {
  setUpAll(() async {
    // Initialize Hive for tests (using in-memory storage)
    Hive.init('test_hive_growth');
    await Hive.openBox('notification_settings');
  });

  group('GrowthTimelineScreen', () {
    testWidgets('renders without crashing', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            notificationProvider.overrideWith((ref) => NotificationNotifier.test()),
          ],
          child: const MaterialApp(
            home: GrowthTimelineScreen(plantId: 1, plantName: 'Monstera'),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(GrowthTimelineScreen), findsOneWidget);
    });

    testWidgets('displays plant name in app bar', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            notificationProvider.overrideWith((ref) => NotificationNotifier.test()),
          ],
          child: const MaterialApp(
            home: GrowthTimelineScreen(plantId: 1, plantName: 'Monstera'),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Plant name should be in the app bar title
      expect(find.textContaining('Monstera'), findsOneWidget);
    });

    testWidgets('displays growth timeline in app bar title', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            notificationProvider.overrideWith((ref) => NotificationNotifier.test()),
          ],
          child: const MaterialApp(
            home: GrowthTimelineScreen(plantId: 1, plantName: 'Monstera'),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Growth timeline text should be in the app bar title
      expect(find.textContaining(AppStrings.growthTimeline), findsOneWidget);
    });

    testWidgets('has add entry floating action button', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            notificationProvider.overrideWith((ref) => NotificationNotifier.test()),
          ],
          child: const MaterialApp(
            home: GrowthTimelineScreen(plantId: 1, plantName: 'Monstera'),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(FloatingActionButton), findsOneWidget);
      expect(find.byIcon(Icons.add_a_photo), findsOneWidget);
    });
  });
}