import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:linfa/features/home/widgets/upcoming_reminders.dart';
import 'package:linfa/data/models/reminder.dart';
import 'package:linfa/data/models/plant.dart';
import 'package:isar/isar.dart';

Reminder createTestReminder({
  int id = Isar.autoIncrement,
  String type = 'watering',
  int frequencyDays = 7,
  DateTime? time,
  bool isEnabled = true,
  String? customMessage,
  int? notificationId,
  DateTime? lastTriggered,
  DateTime? nextScheduled,
  Plant? plant,
}) {
  final reminder = Reminder()
    ..id = id
    ..type = type
    ..frequencyDays = frequencyDays
    ..time = time ?? DateTime(2024, 3, 15, 10, 30)
    ..isEnabled = isEnabled
    ..customMessage = customMessage
    ..notificationId = notificationId
    ..lastTriggered = lastTriggered
    ..nextScheduled = nextScheduled;

  if (plant != null) {
    reminder.plant.value = plant;
  }

  return reminder;
}

void main() {
  group('UpcomingRemindersWidget', () {
    testWidgets('shows empty state message when no reminders',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: UpcomingRemindersWidget(reminders: []),
          ),
        ),
      );

      expect(find.text('Nessun promemoria imminente'), findsOneWidget);
      expect(find.byIcon(Icons.check_circle), findsOneWidget);
    });

    testWidgets('shows reminder items when list not empty',
        (WidgetTester tester) async {
      final plant = Plant()
        ..id = 1
        ..name = 'Monstera';

      final reminder = createTestReminder(
        type: 'watering',
        nextScheduled: DateTime.now().add(const Duration(days: 2)),
        plant: plant,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: UpcomingRemindersWidget(reminders: [reminder]),
          ),
        ),
      );

      expect(find.text('Annaffiare'), findsOneWidget);
      expect(find.text('Monstera'), findsOneWidget);
    });

    testWidgets('shows type icon and color', (WidgetTester tester) async {
      final reminder = createTestReminder(
        type: 'watering',
        nextScheduled: DateTime.now().add(const Duration(days: 1)),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: UpcomingRemindersWidget(reminders: [reminder]),
          ),
        ),
      );

      expect(find.byIcon(Icons.water_drop), findsOneWidget);
    });

    testWidgets('shows plant name', (WidgetTester tester) async {
      final plant = Plant()
        ..id = 1
        ..name = 'Ficus';

      final reminder = createTestReminder(
        type: 'fertilizing',
        nextScheduled: DateTime.now().add(const Duration(days: 3)),
        plant: plant,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: UpcomingRemindersWidget(reminders: [reminder]),
          ),
        ),
      );

      expect(find.text('Ficus'), findsOneWidget);
    });

    testWidgets('shows due date status', (WidgetTester tester) async {
      final reminder = createTestReminder(
        type: 'watering',
        nextScheduled: DateTime.now().add(const Duration(days: 1)),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: UpcomingRemindersWidget(reminders: [reminder]),
          ),
        ),
      );

      expect(find.text('Domani'), findsOneWidget);
    });

    testWidgets('shows overdue indicator when overdue',
        (WidgetTester tester) async {
      final reminder = createTestReminder(
        type: 'watering',
        nextScheduled: DateTime.now().subtract(const Duration(days: 1)),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: UpcomingRemindersWidget(reminders: [reminder]),
          ),
        ),
      );

      expect(find.text('Scaduto'), findsOneWidget);
    });

    testWidgets('shows different type icons', (WidgetTester tester) async {
      final reminders = [
        createTestReminder(
          type: 'fertilizing',
          nextScheduled: DateTime.now().add(const Duration(days: 1)),
        ),
        createTestReminder(
          type: 'repotting',
          nextScheduled: DateTime.now().add(const Duration(days: 2)),
        ),
        createTestReminder(
          type: 'cleaning',
          nextScheduled: DateTime.now().add(const Duration(days: 3)),
        ),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: UpcomingRemindersWidget(reminders: reminders),
          ),
        ),
      );

      expect(find.byIcon(Icons.science), findsOneWidget);
      expect(find.byIcon(Icons.square_foot), findsOneWidget);
      expect(find.byIcon(Icons.cleaning_services), findsOneWidget);
    });

    testWidgets('limits display to 3 reminders', (WidgetTester tester) async {
      final reminders = List.generate(
        5,
        (index) => createTestReminder(
          type: 'watering',
          nextScheduled: DateTime.now().add(Duration(days: index + 1)),
        ),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: UpcomingRemindersWidget(reminders: reminders),
          ),
        ),
      );

      expect(find.byIcon(Icons.water_drop), findsNWidgets(3));
    });
  });
}
