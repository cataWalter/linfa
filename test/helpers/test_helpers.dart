import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:linfa/app.dart';
import 'package:linfa/core/constants/enums.dart';
import 'package:linfa/core/theme/light.dart';
import 'package:linfa/core/theme/dark.dart';
import 'package:go_router/go_router';

/// Initialize Hive for tests (using in-memory storage)
Future<void> initHiveForTests() async {
  Hive.init('test_hive');
  await Hive.openBox('notification_settings');
}

Widget createTestApp({
  List<Override> overrides = const [],
  GoRouter? routerConfig,
}) {
  return ProviderScope(
    overrides: overrides,
    child: MaterialApp(
      home: const Scaffold(body: Text('Test')),
    ),
  );
}

Widget createTestScaffold({
  required Widget body,
  List<Override> overrides = const [],
}) {
  return ProviderScope(
    overrides: overrides,
    child: MaterialApp(
      home: Scaffold(body: body),
    ),
  );
}

Future<void> pumpTestWidget(
  WidgetTester tester,
  Widget widget, {
  List<Override> overrides = const [],
}) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: overrides,
      child: MaterialApp(
        home: Scaffold(body: widget),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

Future<void> pumpApp(WidgetTester tester) async {
  await tester.pumpWidget(
    const ProviderScope(
      child: LinfaApp(),
    ),
  );
  await tester.pumpAndSettle();
}
