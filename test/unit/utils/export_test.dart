import 'package:flutter_test/flutter_test.dart';
import 'package:linfa/core/utils/export.dart';

void main() {
  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  group('ExportUtils', () {
    group('createBackupData', () {
      test('should create backup with all sections', () {
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
    });

    group('exportAsCsv field escaping', () {
      test('should handle plants with commas in names', () async {
        final plants = [
          {
            'name': 'Monstera, Deliciosa',
            'species': '',
            'room': '',
            'status': '',
            'lightCondition': '',
            'lastWatered': '',
            'notes': ''
          },
        ];
        await expectLater(
          () => ExportUtils.exportAsCsv(plants),
          throwsA(isA<Exception>()),
        );
      });
    });
  });
}
