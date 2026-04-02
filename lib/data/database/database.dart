import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../models/plant.dart';
import '../models/reminder.dart';
import '../models/growth_entry.dart';

/// Database service for Isar
class DatabaseService {
  DatabaseService._();

  static final DatabaseService instance = DatabaseService._();

  static Isar? _isar;

  /// Check if database is initialized
  bool get isInitialized => _isar != null && _isar!.isOpen;

  /// Get Isar instance
  Isar get isar {
    final db = _isar;
    if (db == null || !db.isOpen) {
      throw StateError('Database not initialized. Call init() first.');
    }
    return db;
  }

  /// Initialize the database
  Future<void> init() async {
    if (_isar != null && _isar!.isOpen) return;

    final dir = await getApplicationDocumentsDirectory();
    _isar = await Isar.open(
      [PlantSchema, ReminderSchema, GrowthEntrySchema],
      directory: dir.path,
      inspector: true, // Enable Isar Inspector for debugging
    );
  }

  /// Close the database
  Future<void> close() async {
    final db = _isar;
    if (db != null && db.isOpen) {
      await db.close();
      _isar = null;
    }
  }

  /// Clear all data (for testing/reset)
  Future<void> clearAll() async {
    final db = isar;
    await db.writeTxn(() async {
      await db.plants.clear();
      await db.reminders.clear();
      await db.growthEntrys.clear();
    });
  }

  /// Get database size
  Future<int> getSize() async {
    return isar.getSize();
  }
}
