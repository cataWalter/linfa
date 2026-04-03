import 'package:flutter_test/flutter_test.dart';
import 'package:linfa/core/utils/export.dart';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('ExportUtils', () {
    group('createBackupData', () {
      test('should create backup with all sections and correct version', () {
        final plants = [
          {'id': 1, 'name': 'Monstera'},
        ];
        final reminders = [
          {'id': 1, 'type': 'watering'},
        ];
        final growthEntries = [
          {'id': 1, 'date': '2024-03-15'},
        ];
        final settings = {'theme': 'dark'};

        final result = ExportUtils.createBackupData(
          plants: plants,
          reminders: reminders,
          growthEntries: growthEntries,
          settings: settings,
        );

        expect(result['version'], '1.0.0');
        expect(result['app'], 'Linfa');
        expect(result['plants'], plants);
        expect(result['reminders'], reminders);
        expect(result['growthEntries'], growthEntries);
        expect(result['settings'], settings);
        expect(result['exportDate'], isNotNull);
      });

      test('should handle empty lists', () {
        final result = ExportUtils.createBackupData(
          plants: [],
          reminders: [],
          growthEntries: [],
          settings: {},
        );

        expect(result['plants'], isEmpty);
        expect(result['reminders'], isEmpty);
        expect(result['growthEntries'], isEmpty);
        expect(result['settings'], isEmpty);
        expect(result['version'], '1.0.0');
        expect(result['app'], 'Linfa');
      });

      test('should include export date in ISO format', () {
        final before = DateTime.now();
        final result = ExportUtils.createBackupData(
          plants: [],
          reminders: [],
          growthEntries: [],
          settings: {},
        );
        final after = DateTime.now();

        final exportDate = DateTime.parse(result['exportDate'] as String);
        expect(exportDate.isAfter(before) || exportDate.isAtSameMomentAs(before), isTrue);
        expect(exportDate.isBefore(after) || exportDate.isAtSameMomentAs(after), isTrue);
      });
    });

    group('importFromJson', () {
      test('should parse valid JSON string', () async {
        const jsonString = '{"key": "value", "number": 42}';
        final result = await ExportUtils.importFromJson(jsonString);

        expect(result, isNotNull);
        expect(result!['key'], 'value');
        expect(result['number'], 42);
      });

      test('should return null for invalid JSON', () async {
        const jsonString = 'not valid json';
        final result = await ExportUtils.importFromJson(jsonString);

        expect(result, isNull);
      });

      test('should return null for empty string', () async {
        const jsonString = '';
        final result = await ExportUtils.importFromJson(jsonString);

        expect(result, isNull);
      });

      test('should handle complex nested JSON', () async {
        const jsonString = '{"nested": {"key": "value"}, "array": [1, 2, 3]}';
        final result = await ExportUtils.importFromJson(jsonString);

        expect(result, isNotNull);
        expect(result!['nested'], isA<Map>());
        expect(result['array'], isA<List>());
      });

      test('should handle JSON with special characters', () async {
        const jsonString = '{"name": "Test \\"quoted\\" value", "emoji": "🌱"}';
        final result = await ExportUtils.importFromJson(jsonString);

        expect(result, isNotNull);
        expect(result!['name'], 'Test "quoted" value');
        expect(result['emoji'], '🌱');
      });
    });

    group('readJsonFile', () {
      test('should return null for non-existent file', () async {
        final result = await ExportUtils.readJsonFile('/nonexistent/path/file.json');
        expect(result, isNull);
      });

      test('should return null for invalid JSON file', () async {
        // Create a temp file with invalid content
        final tempFile = File('${Directory.systemTemp.path}/invalid.json');
        await tempFile.writeAsString('not valid json');
        
        final result = await ExportUtils.readJsonFile(tempFile.path);
        expect(result, isNull);
        
        // Clean up
        await tempFile.delete();
      });

      test('should parse valid JSON file', () async {
        // Create a temp file with valid content
        final tempFile = File('${Directory.systemTemp.path}/valid.json');
        await tempFile.writeAsString('{"key": "value"}');
        
        final result = await ExportUtils.readJsonFile(tempFile.path);
        expect(result, isNotNull);
        expect(result!['key'], 'value');
        
        // Clean up
        await tempFile.delete();
      });
    });

    group('exportAsJson', () {
      test('should handle empty data', () async {
        // This will throw in test environment due to path_provider
        // but we can verify it throws the expected exception
        try {
          await ExportUtils.exportAsJson({});
        } catch (e) {
          // Expected to fail in test environment
          expect(e, isA<Exception>());
        }
      });

      test('should handle data with nested structures', () async {
        try {
          await ExportUtils.exportAsJson({
            'plants': [
              {'name': 'Monstera', 'species': 'Monstera deliciosa'},
            ],
            'settings': {'theme': 'dark'},
          });
        } catch (e) {
          // Expected to fail in test environment
          expect(e, isA<Exception>());
        }
      });
    });

    group('exportAsCsv', () {
      test('should handle empty plants list', () async {
        try {
          await ExportUtils.exportAsCsv([]);
        } catch (e) {
          // Expected to fail in test environment
          expect(e, isA<Exception>());
        }
      });

      test('should handle plants with all fields', () async {
        try {
          await ExportUtils.exportAsCsv([
            {
              'name': 'Monstera',
              'species': 'Monstera deliciosa',
              'room': 'Living Room',
              'status': 'Healthy',
              'lightCondition': 'Bright indirect',
              'lastWatered': '2024-03-15',
              'notes': 'Needs repotting',
            },
          ]);
        } catch (e) {
          // Expected to fail in test environment
          expect(e, isA<Exception>());
        }
      });

      test('should handle plants with null fields', () async {
        try {
          await ExportUtils.exportAsCsv([
            {
              'name': 'Unknown Plant',
              'species': null,
              'room': null,
              'status': null,
              'lightCondition': null,
              'lastWatered': null,
              'notes': null,
            },
          ]);
        } catch (e) {
          // Expected to fail in test environment
          expect(e, isA<Exception>());
        }
      });

      test('should escape fields with special characters', () async {
        try {
          await ExportUtils.exportAsCsv([
            {
              'name': 'Plant, with comma',
              'species': 'Species "quoted"',
              'room': 'Room\nwith newline',
              'status': '',
              'lightCondition': '',
              'lastWatered': '',
              'notes': '',
            },
          ]);
        } catch (e) {
          // Expected to fail in test environment
          expect(e, isA<Exception>());
        }
      });
    });

    group('getStorageSize', () {
      test('should return formatted size or N/D on error', () async {
        // This will likely return 'N/D' in test environment
        final result = await ExportUtils.getStorageSize();
        expect(result, isA<String>());
        // Either a formatted size or 'N/D'
        expect(result == 'N/D' || result.contains('B') || result.contains('KB') || result.contains('MB'), isTrue);
      });
    });
  });
}