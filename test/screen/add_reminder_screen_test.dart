import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:linfa/features/reminders/add_reminder_screen.dart';
import 'package:linfa/core/constants/strings.dart';

void main() {
  group('AddReminderScreen', () {
    testWidgets('renders without crashing', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: AddReminderScreen(),
          ),
        ),
      );

      expect(find.byType(AddReminderScreen), findsOneWidget);
    });

    testWidgets('displays app bar with add reminder title', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: AddReminderScreen(),
          ),
        ),
      );

      expect(find.text(AppStrings.addReminder), findsOneWidget);
    });

    testWidgets('has form widget', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: AddReminderScreen(),
          ),
        ),
      );

      expect(find.byType(Form), findsOneWidget);
    });

    testWidgets('has reminder type selection', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: AddReminderScreen(),
          ),
        ),
      );

      expect(find.text(AppStrings.reminderType), findsOneWidget);
    });

    testWidgets('has frequency selection', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: AddReminderScreen(),
          ),
        ),
      );

      expect(find.text(AppStrings.reminderFrequency), findsOneWidget);
    });

    testWidgets('has time picker', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: AddReminderScreen(),
          ),
        ),
      );

      expect(find.text(AppStrings.reminderTime), findsOneWidget);
    });

    testWidgets('has enabled switch', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: AddReminderScreen(),
          ),
        ),
      );

      expect(find.text(AppStrings.reminderEnabled), findsOneWidget);
      expect(find.byType(Switch), findsOneWidget);
    });

    testWidgets('has save button', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: AddReminderScreen(),
          ),
        ),
      );

      expect(find.text(AppStrings.save), findsOneWidget);
    });
  });
}
