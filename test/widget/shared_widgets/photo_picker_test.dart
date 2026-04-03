import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:linfa/shared/widgets/photo_picker.dart';
import 'package:linfa/core/constants/strings.dart';

void main() {
  group('PhotoPicker', () {
    testWidgets('shows placeholder when no photo', (WidgetTester tester) async {
      String? selectedPath;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PhotoPicker(
              onPhotoSelected: (path) {
                selectedPath = path;
              },
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.add_a_photo), findsOneWidget);
      expect(find.text(AppStrings.photo), findsOneWidget);
    });

    testWidgets('shows photo when currentPhotoPath provided',
        (WidgetTester tester) async {
      String? selectedPath;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PhotoPicker(
              currentPhotoPath: '/fake/path/photo.jpg',
              onPhotoSelected: (path) {
                selectedPath = path;
              },
            ),
          ),
        ),
      );

      expect(find.byType(Image), findsOneWidget);
      expect(find.byIcon(Icons.camera_alt), findsOneWidget);
    });

    testWidgets('shows camera icon overlay when photo present',
        (WidgetTester tester) async {
      String? selectedPath;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PhotoPicker(
              currentPhotoPath: '/fake/path/photo.jpg',
              onPhotoSelected: (path) {
                selectedPath = path;
              },
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.camera_alt), findsOneWidget);
    });

    testWidgets('tap opens bottom sheet with options',
        (WidgetTester tester) async {
      String? selectedPath;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PhotoPicker(
              onPhotoSelected: (path) {
                selectedPath = path;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.byType(PhotoPicker));
      await tester.pumpAndSettle();

      expect(find.text(AppStrings.takePhoto), findsOneWidget);
      expect(find.text(AppStrings.chooseFromGallery), findsOneWidget);
    });

    testWidgets('remove option only shown when photo exists',
        (WidgetTester tester) async {
      String? selectedPath;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PhotoPicker(
              currentPhotoPath: '/fake/path/photo.jpg',
              onPhotoSelected: (path) {
                selectedPath = path;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.byType(PhotoPicker));
      await tester.pumpAndSettle();

      expect(find.text(AppStrings.removePhoto), findsOneWidget);
    });

    testWidgets('remove option not shown when no photo',
        (WidgetTester tester) async {
      String? selectedPath;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PhotoPicker(
              onPhotoSelected: (path) {
                selectedPath = path;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.byType(PhotoPicker));
      await tester.pumpAndSettle();

      expect(find.text(AppStrings.removePhoto), findsNothing);
    });

    testWidgets('isSquare affects height', (WidgetTester tester) async {
      String? selectedPath;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                PhotoPicker(
                  key: const ValueKey('square'),
                  isSquare: true,
                  onPhotoSelected: (path) {
                    selectedPath = path;
                  },
                ),
                PhotoPicker(
                  key: const ValueKey('nonSquare'),
                  isSquare: false,
                  onPhotoSelected: (path) {
                    selectedPath = path;
                  },
                ),
              ],
            ),
          ),
        ),
      );

      final squareContainer = tester.widget<Container>(
        find
            .descendant(
              of: find.byKey(const ValueKey('square')),
              matching: find.byType(Container),
            )
            .first,
      );
      final nonSquareContainer = tester.widget<Container>(
        find
            .descendant(
              of: find.byKey(const ValueKey('nonSquare')),
              matching: find.byType(Container),
            )
            .first,
      );

      expect(squareContainer.constraints?.maxHeight, 200);
      expect(nonSquareContainer.constraints?.maxHeight, 180);
    });

    testWidgets('removes photo when remove option tapped',
        (WidgetTester tester) async {
      String? selectedPath = '/fake/path/photo.jpg';

      await tester.pumpWidget(
        MaterialApp(
          home: StatefulBuilder(
            builder: (context, setState) {
              return Scaffold(
                body: PhotoPicker(
                  currentPhotoPath: selectedPath,
                  onPhotoSelected: (path) {
                    setState(() {
                      selectedPath = path;
                    });
                  },
                ),
              );
            },
          ),
        ),
      );

      await tester.tap(find.byType(PhotoPicker));
      await tester.pumpAndSettle();

      await tester.tap(find.text(AppStrings.removePhoto));
      await tester.pumpAndSettle();

      expect(selectedPath, isNull);
    });
  });
}
