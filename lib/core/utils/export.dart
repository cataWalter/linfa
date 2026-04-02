import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:share_plus/share_plus.dart';

/// Export utility functions for Linfa
class ExportUtils {
  ExportUtils._();

  /// Export data as JSON and share
  static Future<void> exportAsJson(Map<String, dynamic> data) async {
    try {
      final jsonString = const JsonEncoder.withIndent('  ').convert(data);
      final dir = await getApplicationDocumentsDirectory();
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final filePath = path.join(dir.path, 'linfa_backup_$timestamp.json');
      final file = File(filePath);
      await file.writeAsString(jsonString);

      await Share.shareXFiles(
        [XFile(filePath)],
        subject: 'Linfa Backup',
        text: 'Backup dei dati Linfa',
      );
    } catch (e) {
      debugPrint('Error exporting JSON: $e');
      rethrow;
    }
  }

  /// Export data as CSV
  static Future<void> exportAsCsv(List<Map<String, dynamic>> plants) async {
    try {
      final buffer = StringBuffer();
      // Header
      buffer.writeln('Nome,Specie,Stanza,Stato,Luce,Ultima Annaffiatura,Note');
      // Data rows
      for (final plant in plants) {
        buffer.writeln([
          _escapeCsvField((plant['name'] ?? '') as String),
          _escapeCsvField((plant['species'] ?? '') as String),
          _escapeCsvField((plant['room'] ?? '') as String),
          _escapeCsvField((plant['status'] ?? '') as String),
          _escapeCsvField((plant['lightCondition'] ?? '') as String),
          _escapeCsvField((plant['lastWatered'] ?? '') as String),
          _escapeCsvField((plant['notes'] ?? '') as String),
        ].join(','));
      }

      final dir = await getApplicationDocumentsDirectory();
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final filePath = path.join(dir.path, 'linfa_plants_$timestamp.csv');
      final file = File(filePath);
      await file.writeAsString(buffer.toString());

      await Share.shareXFiles(
        [XFile(filePath)],
        subject: 'Linfa Plants Export',
        text: 'Esportazione piante Linfa',
      );
    } catch (e) {
      debugPrint('Error exporting CSV: $e');
      rethrow;
    }
  }

  /// Escape a CSV field
  static String _escapeCsvField(String field) {
    if (field.contains(',') || field.contains('"') || field.contains('\n')) {
      return '"${field.replaceAll('"', '""')}"';
    }
    return field;
  }

  /// Import data from JSON string
  static Future<Map<String, dynamic>?> importFromJson(String jsonString) async {
    try {
      final data = jsonDecode(jsonString) as Map<String, dynamic>;
      return data;
    } catch (e) {
      debugPrint('Error importing JSON: $e');
      return null;
    }
  }

  /// Read JSON file from path
  static Future<Map<String, dynamic>?> readJsonFile(String filePath) async {
    try {
      final file = File(filePath);
      if (await file.exists()) {
        final content = await file.readAsString();
        return importFromJson(content);
      }
      return null;
    } catch (e) {
      debugPrint('Error reading JSON file: $e');
      return null;
    }
  }

  /// Create backup data structure
  static Map<String, dynamic> createBackupData({
    required List<Map<String, dynamic>> plants,
    required List<Map<String, dynamic>> reminders,
    required List<Map<String, dynamic>> growthEntries,
    required Map<String, dynamic> settings,
  }) {
    return {
      'version': '1.0.0',
      'exportDate': DateTime.now().toIso8601String(),
      'app': 'Linfa',
      'plants': plants,
      'reminders': reminders,
      'growthEntries': growthEntries,
      'settings': settings,
    };
  }

  /// Get storage size of all app data
  static Future<String> getStorageSize() async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      int totalBytes = 0;
      await for (final entity in dir.list(recursive: true)) {
        if (entity is File) {
          totalBytes += await entity.length();
        }
      }
      return _formatBytes(totalBytes);
    } catch (e) {
      return 'N/D';
    }
  }

  /// Format bytes to human-readable
  static String _formatBytes(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    if (bytes < 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    }
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(2)} GB';
  }
}
