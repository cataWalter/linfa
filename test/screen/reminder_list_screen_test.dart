import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:linfa/features/reminders/reminder_list_screen.dart';
import 'package:linfa/shared/providers/notification_provider.dart';

void main() {
  setUpAll(() async {
    Hive.init('test_hive_reminders');
    await Hive.openBox('notification_settings');
  });

  group('RemindersScreen', () {
    testWidgets('renders without crashing', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            notificationProvider.overrideWith((ref) => NotificationNotifier.test()),
          ],
          child: const MaterialApp(
            home: RemindersScreen(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(RemindersScreen), findsOneWidget);
    });
  });
}