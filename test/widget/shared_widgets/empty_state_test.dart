import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:linfa/shared/widgets/empty_state.dart';
import 'package:linfa/core/constants/colors.dart';

void main() {
  group('EmptyState', () {
    testWidgets('renders icon, title, and message',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EmptyState(
              icon: Icons.error_outline,
              title: 'No data',
              message: 'There is nothing to show',
            ),
          ),
        ),
      );

      await tester.pump(const Duration(milliseconds: 700));

      expect(find.byIcon(Icons.error_outline), findsOneWidget);
      expect(find.text('No data'), findsOneWidget);
      expect(find.text('There is nothing to show'), findsOneWidget);
    });

    testWidgets('shows action button when actionLabel and onAction provided',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EmptyState(
              icon: Icons.add,
              title: 'Empty',
              message: 'Add something',
              actionLabel: 'Add Item',
              onAction: () {},
            ),
          ),
        ),
      );

      await tester.pump(const Duration(milliseconds: 700));

      expect(find.byType(ElevatedButton), findsOneWidget);
      expect(find.text('Add Item'), findsOneWidget);
    });

    testWidgets('does not show action button when actionLabel not provided',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EmptyState(
              icon: Icons.add,
              title: 'Empty',
              message: 'Add something',
              onAction: () {},
            ),
          ),
        ),
      );

      await tester.pump(const Duration(milliseconds: 700));

      expect(find.byType(ElevatedButton), findsNothing);
    });

    testWidgets('does not show action button when onAction not provided',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EmptyState(
              icon: Icons.add,
              title: 'Empty',
              message: 'Add something',
              actionLabel: 'Add Item',
            ),
          ),
        ),
      );

      await tester.pump(const Duration(milliseconds: 700));

      expect(find.byType(ElevatedButton), findsNothing);
    });

    testWidgets('action button calls onAction when tapped',
        (WidgetTester tester) async {
      bool actionCalled = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EmptyState(
              icon: Icons.add,
              title: 'Empty',
              message: 'Add something',
              actionLabel: 'Add Item',
              onAction: () {
                actionCalled = true;
              },
            ),
          ),
        ),
      );

      await tester.pump(const Duration(milliseconds: 700));

      await tester.tap(find.byType(ElevatedButton));
      await tester.pump(const Duration(milliseconds: 400));

      expect(actionCalled, isTrue);
    });

    testWidgets('uses custom illustrationColor when provided',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EmptyState(
              icon: Icons.info,
              title: 'Info',
              message: 'Details',
              illustrationColor: LinfaColors.danger,
            ),
          ),
        ),
      );

      await tester.pump(const Duration(milliseconds: 700));

      final iconFinder = find.byIcon(Icons.info);
      expect(iconFinder, findsOneWidget);
    });
  });

  group('SkeletonLoader', () {
    testWidgets('renders with default dimensions', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SkeletonLoader(),
          ),
        ),
      );

      await tester.pump(const Duration(milliseconds: 100));

      final container = tester.widget<Container>(find.byType(Container));
      expect(container.constraints?.maxWidth, double.infinity);
    });

    testWidgets('renders with custom width and height',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SkeletonLoader(
              width: 100,
              height: 50,
            ),
          ),
        ),
      );

      await tester.pump(const Duration(milliseconds: 100));

      final container = tester.widget<Container>(find.byType(Container));
      expect(container.constraints?.maxWidth, 100);
    });

    testWidgets('renders with custom border radius',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SkeletonLoader(
              borderRadius: 16,
            ),
          ),
        ),
      );

      await tester.pump(const Duration(milliseconds: 100));

      expect(find.byType(Container), findsOneWidget);
    });
  });

  group('PlantCardSkeleton', () {
    testWidgets('renders plant card skeleton', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PlantCardSkeleton(),
          ),
        ),
      );

      await tester.pump(const Duration(milliseconds: 100));

      expect(find.byType(Card), findsOneWidget);
      expect(find.byType(SkeletonLoader), findsNWidgets(3));
    });
  });

  group('StatsCardSkeleton', () {
    testWidgets('renders stats card skeleton', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StatsCardSkeleton(),
          ),
        ),
      );

      await tester.pump(const Duration(milliseconds: 100));

      expect(find.byType(Container), findsOneWidget);
    });
  });
}
