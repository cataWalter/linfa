import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:linfa/shared/widgets/empty_state.dart';
import 'package:linfa/core/constants/colors.dart';

void main() {
  group('EmptyState Golden Tests', () {
    testWidgets('empty state with eco icon matches golden',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.light(),
          home: Scaffold(
            body: EmptyState(
              icon: Icons.eco_outlined,
              title: 'Nessuna pianta',
              message: 'Aggiungi la tua prima pianta per iniziare',
              actionLabel: 'Aggiungi pianta',
              onAction: () {},
            ),
          ),
        ),
      );

      // Wait for scale animation to complete (600ms)
      await tester.pumpAndSettle();
      await tester.pump(const Duration(milliseconds: 700));
      await tester.pumpAndSettle();

      final finder = find.byType(EmptyState);
      await expectLater(
        finder,
        matchesGoldenFile('empty_state_eco.png'),
      );
    });

    testWidgets('empty state without action matches golden',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.light(),
          home: Scaffold(
            body: EmptyState(
              icon: Icons.search_off,
              title: 'Nessun risultato',
              message: 'Prova con termini di ricerca diversi',
            ),
          ),
        ),
      );

      // Wait for scale animation to complete (600ms)
      await tester.pumpAndSettle();
      await tester.pump(const Duration(milliseconds: 700));
      await tester.pumpAndSettle();

      final finder = find.byType(EmptyState);
      await expectLater(
        finder,
        matchesGoldenFile('empty_state_no_action.png'),
      );
    });

    testWidgets('skeleton loader matches golden', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.light(),
          home: Scaffold(
            body: const Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  SkeletonLoader(width: 200, height: 20, shimmer: false),
                  SizedBox(height: 16),
                  SkeletonLoader(width: 150, height: 16, shimmer: false),
                  SizedBox(height: 16),
                  SkeletonLoader(width: 180, height: 14, shimmer: false),
                ],
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      final finder = find.byType(Column);
      await expectLater(
        finder,
        matchesGoldenFile('skeleton_loader.png'),
      );
    });

    testWidgets('plant card skeleton matches golden',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.light(),
          home: const Scaffold(
            body: Padding(
              padding: EdgeInsets.all(16),
              child: PlantCardSkeleton(shimmer: false),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      final finder = find.byType(PlantCardSkeleton);
      await expectLater(
        finder,
        matchesGoldenFile('plant_card_skeleton.png'),
      );
    });

    testWidgets('stats card skeleton matches golden',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.light(),
          home: const Scaffold(
            body: Padding(
              padding: EdgeInsets.all(16),
              child: StatsCardSkeleton(shimmer: false),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      final finder = find.byType(StatsCardSkeleton);
      await expectLater(
        finder,
        matchesGoldenFile('stats_card_skeleton.png'),
      );
    });
  });
}
