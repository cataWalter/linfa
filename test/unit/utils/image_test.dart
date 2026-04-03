import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:linfa/core/utils/image.dart';

void main() {
  group('ImageUtils', () {
    group('getPlantIcon', () {
      test('should return eco_outlined for null species', () {
        expect(ImageUtils.getPlantIcon(null), Icons.eco_outlined);
      });

      test('should return eco_outlined for empty species', () {
        expect(ImageUtils.getPlantIcon(''), Icons.eco_outlined);
      });

      test('should return park_outlined for succulent', () {
        expect(ImageUtils.getPlantIcon('Succulent'), Icons.park_outlined);
      });

      test('should return park_outlined for cactus', () {
        expect(ImageUtils.getPlantIcon('Cactus'), Icons.park_outlined);
      });

      test('should return park_outlined for cacto', () {
        expect(ImageUtils.getPlantIcon('Cacto'), Icons.park_outlined);
      });

      test('should return grass for fern', () {
        expect(ImageUtils.getPlantIcon('Fern'), Icons.grass);
      });

      test('should return grass for felce', () {
        expect(ImageUtils.getPlantIcon('Felce'), Icons.grass);
      });

      test('should return local_florist for flower', () {
        expect(ImageUtils.getPlantIcon('Flower'), Icons.local_florist);
      });

      test('should return local_florist for fiore', () {
        expect(ImageUtils.getPlantIcon('Fiore'), Icons.local_florist);
      });

      test('should return park for tree', () {
        expect(ImageUtils.getPlantIcon('Tree'), Icons.park);
      });

      test('should return park for albero', () {
        expect(ImageUtils.getPlantIcon('Albero'), Icons.park);
      });

      test('should be case insensitive', () {
        expect(ImageUtils.getPlantIcon('FERN'), Icons.grass);
        expect(ImageUtils.getPlantIcon('fern'), Icons.grass);
        expect(ImageUtils.getPlantIcon('Fern'), Icons.grass);
      });

      test('should return eco_outlined for unknown species', () {
        expect(ImageUtils.getPlantIcon('Unknown Plant'), Icons.eco_outlined);
      });
    });

    group('getHealthColor', () {
      test('should return grey for null rating', () {
        expect(ImageUtils.getHealthColor(null), Colors.grey);
      });

      test('should return green for rating 4', () {
        expect(ImageUtils.getHealthColor(4), const Color(0xFF66BB6A));
      });

      test('should return green for rating 5', () {
        expect(ImageUtils.getHealthColor(5), const Color(0xFF66BB6A));
      });

      test('should return orange for rating 3', () {
        expect(ImageUtils.getHealthColor(3), const Color(0xFFFFA726));
      });

      test('should return red for rating 1', () {
        expect(ImageUtils.getHealthColor(1), const Color(0xFFEF5350));
      });

      test('should return red for rating 2', () {
        expect(ImageUtils.getHealthColor(2), const Color(0xFFEF5350));
      });
    });
  });
}
