import 'package:flutter_test/flutter_test.dart';
import 'package:linfa/data/models/plant_type.dart';

void main() {
  group('PlantType', () {
    group('constructor', () {
      test('should create with all required fields', () {
        final plantType = PlantType(
          name: 'Monstera',
          scientificName: 'Monstera Deliciosa',
          wateringFrequencyDays: 7,
          lightRequirements: 'indirect_bright',
          humidityLevel: 'medium',
          difficulty: 'easy',
        );

        expect(plantType.name, 'Monstera');
        expect(plantType.scientificName, 'Monstera Deliciosa');
        expect(plantType.wateringFrequencyDays, 7);
        expect(plantType.lightRequirements, 'indirect_bright');
        expect(plantType.humidityLevel, 'medium');
        expect(plantType.difficulty, 'easy');
      });

      test('should use default values for optional fields', () {
        final plantType = PlantType(
          name: 'Test',
          scientificName: 'Testus',
          wateringFrequencyDays: 5,
          lightRequirements: 'direct',
          humidityLevel: 'low',
          difficulty: 'medium',
        );

        expect(plantType.tips, isEmpty);
        expect(plantType.description, '');
        expect(plantType.toxicToPets, false);
        expect(plantType.petFriendly, true);
        expect(plantType.maxHeightCm, isNull);
        expect(plantType.growthRate, 'medium');
      });

      test('should accept all optional fields', () {
        final plantType = PlantType(
          name: 'Test',
          scientificName: 'Testus',
          wateringFrequencyDays: 5,
          lightRequirements: 'direct',
          humidityLevel: 'low',
          difficulty: 'medium',
          tips: ['Tip 1', 'Tip 2'],
          description: 'A test plant',
          toxicToPets: true,
          petFriendly: false,
          maxHeightCm: 100,
          growthRate: 'fast',
        );

        expect(plantType.tips, ['Tip 1', 'Tip 2']);
        expect(plantType.description, 'A test plant');
        expect(plantType.toxicToPets, true);
        expect(plantType.petFriendly, false);
        expect(plantType.maxHeightCm, 100);
        expect(plantType.growthRate, 'fast');
      });
    });

    group('toJson', () {
      test('should serialize all fields', () {
        final plantType = PlantType(
          name: 'Monstera',
          scientificName: 'Monstera Deliciosa',
          wateringFrequencyDays: 7,
          lightRequirements: 'indirect_bright',
          humidityLevel: 'medium',
          difficulty: 'easy',
          tips: ['Keep moist', 'Avoid direct sun'],
          description: 'Popular houseplant',
          toxicToPets: true,
          petFriendly: false,
          maxHeightCm: 200,
          growthRate: 'fast',
        );

        final json = plantType.toJson();

        expect(json['name'], 'Monstera');
        expect(json['scientific_name'], 'Monstera Deliciosa');
        expect(json['watering_frequency_days'], 7);
        expect(json['light_requirements'], 'indirect_bright');
        expect(json['humidity_level'], 'medium');
        expect(json['difficulty'], 'easy');
        expect(json['tips'], ['Keep moist', 'Avoid direct sun']);
        expect(json['description'], 'Popular houseplant');
        expect(json['toxic_to_pets'], true);
        expect(json['pet_friendly'], false);
        expect(json['max_height_cm'], 200);
        expect(json['growth_rate'], 'fast');
      });
    });

    group('fromJson', () {
      test('should deserialize all fields', () {
        final json = {
          'name': 'Monstera',
          'scientific_name': 'Monstera Deliciosa',
          'watering_frequency_days': 7,
          'light_requirements': 'indirect_bright',
          'humidity_level': 'medium',
          'difficulty': 'easy',
          'tips': ['Keep moist', 'Avoid direct sun'],
          'description': 'Popular houseplant',
          'toxic_to_pets': true,
          'pet_friendly': false,
          'max_height_cm': 200,
          'growth_rate': 'fast',
        };

        final plantType = PlantType.fromJson(json);

        expect(plantType.name, 'Monstera');
        expect(plantType.scientificName, 'Monstera Deliciosa');
        expect(plantType.wateringFrequencyDays, 7);
        expect(plantType.lightRequirements, 'indirect_bright');
        expect(plantType.humidityLevel, 'medium');
        expect(plantType.difficulty, 'easy');
        expect(plantType.tips, ['Keep moist', 'Avoid direct sun']);
        expect(plantType.description, 'Popular houseplant');
        expect(plantType.toxicToPets, true);
        expect(plantType.petFriendly, false);
        expect(plantType.maxHeightCm, 200);
        expect(plantType.growthRate, 'fast');
      });

      test('should use default values for missing optional fields', () {
        final json = {
          'name': 'Test',
          'scientific_name': 'Testus',
          'watering_frequency_days': 5,
          'light_requirements': 'direct',
          'humidity_level': 'low',
          'difficulty': 'medium',
        };

        final plantType = PlantType.fromJson(json);

        expect(plantType.tips, isEmpty);
        expect(plantType.description, '');
        expect(plantType.toxicToPets, false);
        expect(plantType.petFriendly, true);
        expect(plantType.maxHeightCm, isNull);
        expect(plantType.growthRate, 'medium');
      });
    });

    group('lightDisplayName', () {
      test('should return Diretta for direct', () {
        final plantType = PlantType(
          name: 'Test',
          scientificName: 'Testus',
          wateringFrequencyDays: 5,
          lightRequirements: 'direct',
          humidityLevel: 'low',
          difficulty: 'easy',
        );
        expect(plantType.lightDisplayName, 'Diretta');
      });

      test('should return Indiretta Brillante for indirect_bright', () {
        final plantType = PlantType(
          name: 'Test',
          scientificName: 'Testus',
          wateringFrequencyDays: 5,
          lightRequirements: 'indirect_bright',
          humidityLevel: 'low',
          difficulty: 'easy',
        );
        expect(plantType.lightDisplayName, 'Indiretta Brillante');
      });

      test('should return Indiretta for indirect', () {
        final plantType = PlantType(
          name: 'Test',
          scientificName: 'Testus',
          wateringFrequencyDays: 5,
          lightRequirements: 'indirect',
          humidityLevel: 'low',
          difficulty: 'easy',
        );
        expect(plantType.lightDisplayName, 'Indiretta');
      });

      test('should return Bassa for low', () {
        final plantType = PlantType(
          name: 'Test',
          scientificName: 'Testus',
          wateringFrequencyDays: 5,
          lightRequirements: 'low',
          humidityLevel: 'low',
          difficulty: 'easy',
        );
        expect(plantType.lightDisplayName, 'Bassa');
      });

      test('should return raw value for unknown', () {
        final plantType = PlantType(
          name: 'Test',
          scientificName: 'Testus',
          wateringFrequencyDays: 5,
          lightRequirements: 'unknown',
          humidityLevel: 'low',
          difficulty: 'easy',
        );
        expect(plantType.lightDisplayName, 'unknown');
      });
    });

    group('humidityDisplayName', () {
      test('should return Bassa for low', () {
        final plantType = PlantType(
          name: 'Test',
          scientificName: 'Testus',
          wateringFrequencyDays: 5,
          lightRequirements: 'direct',
          humidityLevel: 'low',
          difficulty: 'easy',
        );
        expect(plantType.humidityDisplayName, 'Bassa');
      });

      test('should return Media for medium', () {
        final plantType = PlantType(
          name: 'Test',
          scientificName: 'Testus',
          wateringFrequencyDays: 5,
          lightRequirements: 'direct',
          humidityLevel: 'medium',
          difficulty: 'easy',
        );
        expect(plantType.humidityDisplayName, 'Media');
      });

      test('should return Alta for high', () {
        final plantType = PlantType(
          name: 'Test',
          scientificName: 'Testus',
          wateringFrequencyDays: 5,
          lightRequirements: 'direct',
          humidityLevel: 'high',
          difficulty: 'easy',
        );
        expect(plantType.humidityDisplayName, 'Alta');
      });

      test('should return raw value for unknown', () {
        final plantType = PlantType(
          name: 'Test',
          scientificName: 'Testus',
          wateringFrequencyDays: 5,
          lightRequirements: 'direct',
          humidityLevel: 'unknown',
          difficulty: 'easy',
        );
        expect(plantType.humidityDisplayName, 'unknown');
      });
    });

    group('difficultyDisplayName', () {
      test('should return Facile for easy', () {
        final plantType = PlantType(
          name: 'Test',
          scientificName: 'Testus',
          wateringFrequencyDays: 5,
          lightRequirements: 'direct',
          humidityLevel: 'low',
          difficulty: 'easy',
        );
        expect(plantType.difficultyDisplayName, 'Facile');
      });

      test('should return Media for medium', () {
        final plantType = PlantType(
          name: 'Test',
          scientificName: 'Testus',
          wateringFrequencyDays: 5,
          lightRequirements: 'direct',
          humidityLevel: 'low',
          difficulty: 'medium',
        );
        expect(plantType.difficultyDisplayName, 'Media');
      });

      test('should return Difficile for hard', () {
        final plantType = PlantType(
          name: 'Test',
          scientificName: 'Testus',
          wateringFrequencyDays: 5,
          lightRequirements: 'direct',
          humidityLevel: 'low',
          difficulty: 'hard',
        );
        expect(plantType.difficultyDisplayName, 'Difficile');
      });

      test('should return raw value for unknown', () {
        final plantType = PlantType(
          name: 'Test',
          scientificName: 'Testus',
          wateringFrequencyDays: 5,
          lightRequirements: 'direct',
          humidityLevel: 'low',
          difficulty: 'unknown',
        );
        expect(plantType.difficultyDisplayName, 'unknown');
      });
    });

    group('growthRateDisplayName', () {
      test('should return Lenta for slow', () {
        final plantType = PlantType(
          name: 'Test',
          scientificName: 'Testus',
          wateringFrequencyDays: 5,
          lightRequirements: 'direct',
          humidityLevel: 'low',
          difficulty: 'easy',
          growthRate: 'slow',
        );
        expect(plantType.growthRateDisplayName, 'Lenta');
      });

      test('should return Media for medium', () {
        final plantType = PlantType(
          name: 'Test',
          scientificName: 'Testus',
          wateringFrequencyDays: 5,
          lightRequirements: 'direct',
          humidityLevel: 'low',
          difficulty: 'easy',
          growthRate: 'medium',
        );
        expect(plantType.growthRateDisplayName, 'Media');
      });

      test('should return Veloce for fast', () {
        final plantType = PlantType(
          name: 'Test',
          scientificName: 'Testus',
          wateringFrequencyDays: 5,
          lightRequirements: 'direct',
          humidityLevel: 'low',
          difficulty: 'easy',
          growthRate: 'fast',
        );
        expect(plantType.growthRateDisplayName, 'Veloce');
      });

      test('should return raw value for unknown', () {
        final plantType = PlantType(
          name: 'Test',
          scientificName: 'Testus',
          wateringFrequencyDays: 5,
          lightRequirements: 'direct',
          humidityLevel: 'low',
          difficulty: 'easy',
          growthRate: 'unknown',
        );
        expect(plantType.growthRateDisplayName, 'unknown');
      });
    });

    group('round-trip serialization', () {
      test('should preserve all fields through toJson and fromJson', () {
        final original = PlantType(
          name: 'Ficus',
          scientificName: 'Ficus Elastica',
          wateringFrequencyDays: 10,
          lightRequirements: 'indirect',
          humidityLevel: 'high',
          difficulty: 'hard',
          tips: ['Mist regularly'],
          description: 'Rubber plant',
          toxicToPets: true,
          petFriendly: false,
          maxHeightCm: 150,
          growthRate: 'slow',
        );

        final json = original.toJson();
        final restored = PlantType.fromJson(json);

        expect(restored.name, original.name);
        expect(restored.scientificName, original.scientificName);
        expect(restored.wateringFrequencyDays, original.wateringFrequencyDays);
        expect(restored.lightRequirements, original.lightRequirements);
        expect(restored.humidityLevel, original.humidityLevel);
        expect(restored.difficulty, original.difficulty);
        expect(restored.tips, original.tips);
        expect(restored.description, original.description);
        expect(restored.toxicToPets, original.toxicToPets);
        expect(restored.petFriendly, original.petFriendly);
        expect(restored.maxHeightCm, original.maxHeightCm);
        expect(restored.growthRate, original.growthRate);
      });
    });
  });
}
