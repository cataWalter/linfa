import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_test/flutter_test.dart';
import 'package:linfa/core/services/ai_plant_identification_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('PlantIdentificationResult', () {
    test('should create with all fields', () {
      final suggestions = [
        PlantSuggestion(
          scientificName: 'Monstera deliciosa',
          commonName: 'Swiss Cheese Plant',
          confidence: 0.92,
        ),
      ];

      final result = PlantIdentificationResult(
        scientificName: 'Monstera deliciosa',
        commonName: 'Swiss Cheese Plant',
        family: 'Araceae',
        confidence: 0.92,
        suggestions: suggestions,
        additionalData: {'nativeRegion': 'Central America'},
      );

      expect(result.scientificName, 'Monstera deliciosa');
      expect(result.commonName, 'Swiss Cheese Plant');
      expect(result.family, 'Araceae');
      expect(result.confidence, 0.92);
      expect(result.suggestions, suggestions);
      expect(result.additionalData, {'nativeRegion': 'Central America'});
    });

    group('bestMatch', () {
      test('should return first suggestion when suggestions not empty', () {
        final suggestions = [
          PlantSuggestion(
            scientificName: 'Monstera deliciosa',
            commonName: 'Swiss Cheese Plant',
            confidence: 0.92,
          ),
          PlantSuggestion(
            scientificName: 'Monstera adansonii',
            commonName: 'Swiss Cheese Vine',
            confidence: 0.65,
          ),
        ];

        final result = PlantIdentificationResult(
          confidence: 0.92,
          suggestions: suggestions,
        );

        expect(result.bestMatch, suggestions.first);
        expect(result.bestMatch?.scientificName, 'Monstera deliciosa');
      });

      test('should return null when suggestions empty', () {
        final result = PlantIdentificationResult(
          confidence: 0.5,
          suggestions: [],
        );

        expect(result.bestMatch, isNull);
      });
    });

    group('isConfident', () {
      test('should return true when confidence >= 0.7', () {
        final result = PlantIdentificationResult(
          confidence: 0.7,
          suggestions: [],
        );
        expect(result.isConfident, isTrue);

        final result2 = PlantIdentificationResult(
          confidence: 0.9,
          suggestions: [],
        );
        expect(result2.isConfident, isTrue);
      });

      test('should return false when confidence < 0.7', () {
        final result = PlantIdentificationResult(
          confidence: 0.6,
          suggestions: [],
        );
        expect(result.isConfident, isFalse);

        final result2 = PlantIdentificationResult(
          confidence: 0.5,
          suggestions: [],
        );
        expect(result2.isConfident, isFalse);
      });
    });
  });

  group('PlantSuggestion', () {
    test('should create with all fields', () {
      final suggestion = PlantSuggestion(
        scientificName: 'Monstera deliciosa',
        commonName: 'Swiss Cheese Plant',
        confidence: 0.92,
        description: 'A popular tropical plant',
      );

      expect(suggestion.scientificName, 'Monstera deliciosa');
      expect(suggestion.commonName, 'Swiss Cheese Plant');
      expect(suggestion.confidence, 0.92);
      expect(suggestion.description, 'A popular tropical plant');
    });

    test('should create without optional description', () {
      final suggestion = PlantSuggestion(
        scientificName: 'Monstera deliciosa',
        commonName: 'Swiss Cheese Plant',
        confidence: 0.92,
      );

      expect(suggestion.description, isNull);
    });
  });

  group('DiseaseDetectionResult', () {
    test('should create with all fields', () {
      final result = DiseaseDetectionResult(
        diseaseDetected: true,
        diseaseName: 'Root rot',
        description: 'Overwatering caused root rot',
        treatment: 'Reduce watering frequency',
        confidence: 0.85,
        symptoms: ['Yellowing leaves', 'Wilting'],
      );

      expect(result.diseaseDetected, true);
      expect(result.diseaseName, 'Root rot');
      expect(result.description, 'Overwatering caused root rot');
      expect(result.treatment, 'Reduce watering frequency');
      expect(result.confidence, 0.85);
      expect(result.symptoms, ['Yellowing leaves', 'Wilting']);
    });

    test('should create for healthy plant', () {
      final result = DiseaseDetectionResult(
        diseaseDetected: false,
        confidence: 0.95,
        symptoms: [],
      );

      expect(result.diseaseDetected, false);
      expect(result.diseaseName, isNull);
      expect(result.description, isNull);
      expect(result.treatment, isNull);
      expect(result.confidence, 0.95);
      expect(result.symptoms, isEmpty);
    });
  });

  group('AIPlantIdentificationService', () {
    late AIPlantIdentificationService service;

    setUp(() {
      service = AIPlantIdentificationService.instance;
    });

    group('singleton', () {
      test('should return same instance', () {
        final instance1 = AIPlantIdentificationService.instance;
        final instance2 = AIPlantIdentificationService.instance;
        expect(identical(instance1, instance2), isTrue);
      });
    });

    group('identifyPlant', () {
      test('should return PlantIdentificationResult', () async {
        // Create a mock file
        final tempDir = await Directory.systemTemp.createTemp('ai_test_');
        addTearDown(() => tempDir.delete(recursive: true));
        final file = File('${tempDir.path}/test.jpg');
        await file.writeAsBytes(Uint8List.fromList([0, 1, 2, 3]));

        final result = await service.identifyPlant(imageFile: file);

        expect(result, isA<PlantIdentificationResult>());
        expect(result.scientificName, isNotNull);
        expect(result.commonName, isNotNull);
        expect(result.confidence, greaterThanOrEqualTo(0));
        expect(result.suggestions, isA<List<PlantSuggestion>>());
      });
    });

    group('identifyPlantFromBytes', () {
      test('should return PlantIdentificationResult', () async {
        final imageBytes = Uint8List.fromList([0, 1, 2, 3]);

        final result = await service.identifyPlantFromBytes(imageBytes: imageBytes);

        expect(result, isA<PlantIdentificationResult>());
        expect(result.scientificName, isNotNull);
        expect(result.commonName, isNotNull);
      });
    });

    group('detectDisease', () {
      test('should return DiseaseDetectionResult', () async {
        final tempDir = await Directory.systemTemp.createTemp('ai_test_');
        addTearDown(() => tempDir.delete(recursive: true));
        final file = File('${tempDir.path}/test.jpg');
        await file.writeAsBytes(Uint8List.fromList([0, 1, 2, 3]));

        final result = await service.detectDisease(imageFile: file);

        expect(result, isA<DiseaseDetectionResult>());
        expect(result.confidence, greaterThanOrEqualTo(0));
        expect(result.symptoms, isA<List<String>>());
      });
    });

    group('detectDiseaseFromBytes', () {
      test('should return DiseaseDetectionResult', () async {
        final imageBytes = Uint8List.fromList([0, 1, 2, 3]);

        final result = await service.detectDiseaseFromBytes(imageBytes: imageBytes);

        expect(result, isA<DiseaseDetectionResult>());
      });
    });

    group('getCareRecommendations', () {
      test('should return care recommendations map', () async {
        final tempDir = await Directory.systemTemp.createTemp('ai_test_');
        addTearDown(() => tempDir.delete(recursive: true));
        final file = File('${tempDir.path}/test.jpg');
        await file.writeAsBytes(Uint8List.fromList([0, 1, 2, 3]));

        final result = await service.getCareRecommendations(imageFile: file);

        expect(result, isA<Map<String, dynamic>>());
        expect(result.containsKey('health'), isTrue);
        expect(result.containsKey('recommendations'), isTrue);
        expect(result.containsKey('warnings'), isTrue);
      });
    });

    group('isAvailable', () {
      test('should return false (not available)', () async {
        final available = await service.isAvailable();
        expect(available, isFalse);
      });
    });

    group('getStatus', () {
      test('should return status map', () {
        final status = service.getStatus();

        expect(status, isA<Map<String, dynamic>>());
        expect(status['available'], isFalse);
        expect(status['status'], 'placeholder');
        expect(status.containsKey('message'), isTrue);
        expect(status.containsKey('plannedFeatures'), isTrue);
        expect(status['plannedFeatures'], isA<List>());
      });
    });

    group('initialize', () {
      test('should complete without error', () async {
        expect(() => service.initialize(), returnsNormally);
        await service.initialize();
      });
    });

    group('dispose', () {
      test('should complete without error', () {
        expect(() => service.dispose(), returnsNormally);
      });
    });
  });

  group('AIServiceConfig', () {
    test('should create with all fields', () {
      final config = AIServiceConfig(
        apiKey: 'test-key',
        apiEndpoint: 'https://api.example.com',
        timeout: const Duration(seconds: 60),
        maxRetries: 5,
        useOnDeviceModel: false,
      );

      expect(config.apiKey, 'test-key');
      expect(config.apiEndpoint, 'https://api.example.com');
      expect(config.timeout, const Duration(seconds: 60));
      expect(config.maxRetries, 5);
      expect(config.useOnDeviceModel, false);
    });

    test('should use default values', () {
      final config = AIServiceConfig();

      expect(config.apiKey, isNull);
      expect(config.apiEndpoint, isNull);
      expect(config.timeout, const Duration(seconds: 30));
      expect(config.maxRetries, 3);
      expect(config.useOnDeviceModel, true);
    });

    group('fromEnv', () {
      test('should create config from environment', () {
        final config = AIServiceConfig.fromEnv();

        expect(config, isA<AIServiceConfig>());
        expect(config.apiKey, isNull);
        expect(config.useOnDeviceModel, true);
      });
    });
  });
}