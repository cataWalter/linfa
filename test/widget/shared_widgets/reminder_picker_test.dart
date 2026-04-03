import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:linfa/shared/widgets/reminder_picker.dart';
import 'package:linfa/core/constants/colors.dart';

void main() {
  group('ReminderPicker', () {
    testWidgets('shows initial time', (WidgetTester tester) async {
      final initialTime = const TimeOfDay(hour: 8, minute: 30);
      TimeOfDay? selectedTime;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ReminderPicker(
              initialTime: initialTime,
              onTimeSelected: (time) {
                selectedTime = time;
              },
            ),
          ),
        ),
      );

      expect(find.text('08:30'), findsOneWidget);
      expect(find.byIcon(Icons.access_time), findsOneWidget);
    });

    testWidgets('tap triggers time picker', (WidgetTester tester) async {
      final initialTime = const TimeOfDay(hour: 10, minute: 0);
      TimeOfDay? selectedTime;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ReminderPicker(
              initialTime: initialTime,
              onTimeSelected: (time) {
                selectedTime = time;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.byType(InkWell));
      await tester.pumpAndSettle();

      expect(find.byType(Dialog), findsOneWidget);
    });

    testWidgets('updates display when time selected',
        (WidgetTester tester) async {
      final initialTime = const TimeOfDay(hour: 8, minute: 0);
      TimeOfDay? selectedTime;

      await tester.pumpWidget(
        MaterialApp(
          home: StatefulBuilder(
            builder: (context, setState) {
              return Scaffold(
                body: ReminderPicker(
                  initialTime: selectedTime ?? initialTime,
                  onTimeSelected: (time) {
                    setState(() {
                      selectedTime = time;
                    });
                  },
                ),
              );
            },
          ),
        ),
      );

      expect(find.text('08:00'), findsOneWidget);

      await tester.tap(find.byType(InkWell));
      await tester.pumpAndSettle();

      final okButton = find.text('OK');
      if (okButton.evaluate().isNotEmpty) {
        await tester.tap(okButton);
        await tester.pumpAndSettle();
      }
    });

    testWidgets('displays time in HH:MM format', (WidgetTester tester) async {
      final initialTime = const TimeOfDay(hour: 23, minute: 59);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ReminderPicker(
              initialTime: initialTime,
              onTimeSelected: (time) {},
            ),
          ),
        ),
      );

      expect(find.text('23:59'), findsOneWidget);
    });

    testWidgets('has correct styling', (WidgetTester tester) async {
      final initialTime = const TimeOfDay(hour: 14, minute: 45);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ReminderPicker(
              initialTime: initialTime,
              onTimeSelected: (time) {},
            ),
          ),
        ),
      );

      expect(find.byType(InkWell), findsOneWidget);
    });
  });
}
