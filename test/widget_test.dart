// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:linfa/app.dart';
import 'package:linfa/shared/providers/notification_provider.dart';

void main() {
  setUpAll(() async {
    // Initialize Hive for tests using a unique directory to avoid lock conflicts
    final testDir = Directory.systemTemp.createTempSync('linfa_test_');
    Hive.init(testDir.path);
    await Hive.openBox('notification_settings');
  });

  testWidgets('App loads successfully', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          notificationProvider.overrideWith((ref) => NotificationNotifier.test()),
        ],
        child: const LinfaApp(),
      ),
    );

    // Pump to settle any animations
    await tester.pumpAndSettle();

    // Verify that the app loads without errors
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}