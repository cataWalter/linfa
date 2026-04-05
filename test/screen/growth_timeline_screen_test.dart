import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:linfa/features/growth/growth_timeline_screen.dart';
import 'package:linfa/core/constants/strings.dart';

void main() {
  group('GrowthTimelineScreen', () {
    testWidgets('renders without crashing', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: GrowthTimelineScreen(plantId: 1),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(GrowthTimelineScreen), findsOneWidget);
    });

    testWidgets('has floating action button', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: GrowthTimelineScreen(plantId: 1),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(FloatingActionButton), findsOneWidget);
    });

    testWidgets('shows empty state when no entries', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: GrowthTimelineScreen(plantId: 1),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.textContaining('Nessuna'), findsOneWidget);
    });
  });
}