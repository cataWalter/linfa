import 'package:isar/isar.dart';
import '../database/database.dart';
import '../models/reminder.dart';

/// Repository for reminder CRUD operations
class ReminderRepository {
  ReminderRepository({required this.databaseService});

  final DatabaseService databaseService;

  Isar get _db => databaseService.isar;

  /// Get all reminders
  Future<List<Reminder>> getAllReminders() async {
    return _db.reminders.where().sortByNextScheduled().findAll();
  }

  /// Get reminders for a specific plant
  Future<List<Reminder>> getRemindersForPlant(int plantId) async {
    final reminders = await _db.reminders.where().findAll();
    return reminders
        .where((r) => r.plant.value?.id == plantId)
        .toList();
  }

  /// Get active reminders
  Future<List<Reminder>> getActiveReminders() async {
    final allReminders = await _db.reminders.where().sortByNextScheduled().findAll();
    return allReminders.where((r) => r.isEnabled).toList();
  }

  /// Get overdue reminders
  Future<List<Reminder>> getOverdueReminders() async {
    final reminders = await getActiveReminders();
    final now = DateTime.now();
    return reminders
        .where((r) =>
            r.nextScheduled != null && r.nextScheduled!.isBefore(now))
        .toList();
  }

  /// Get reminders due today
  Future<List<Reminder>> getTodayReminders() async {
    final reminders = await getActiveReminders();
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(const Duration(days: 1));
    return reminders.where((r) {
      if (r.nextScheduled == null) return false;
      return r.nextScheduled!.isAtSameMomentAs(today) ||
          (r.nextScheduled!.isAfter(today) && r.nextScheduled!.isBefore(tomorrow));
    }).toList();
  }

  /// Get upcoming reminders (next 7 days)
  Future<List<Reminder>> getUpcomingReminders() async {
    final reminders = await getActiveReminders();
    final now = DateTime.now();
    final weekFromNow = now.add(const Duration(days: 7));
    return reminders.where((r) {
      if (r.nextScheduled == null) return false;
      return r.nextScheduled!.isAfter(now) && r.nextScheduled!.isBefore(weekFromNow);
    }).toList();
  }

  /// Get a single reminder by ID
  Future<Reminder?> getReminder(int id) async {
    return _db.reminders.get(id);
  }

  /// Add a new reminder
  Future<int> addReminder(Reminder reminder) async {
    return _db.writeTxn(() async {
      reminder.nextScheduled = reminder.calculateNextScheduled();
      await _db.reminders.put(reminder);
      return reminder.id;
    });
  }

  /// Update a reminder
  Future<void> updateReminder(Reminder reminder) async {
    await _db.writeTxn(() async {
      await _db.reminders.put(reminder);
    });
  }

  /// Delete a reminder
  Future<void> deleteReminder(int id) async {
    await _db.writeTxn(() async {
      await _db.reminders.delete(id);
    });
  }

  /// Toggle reminder enabled
  Future<void> toggleEnabled(int id) async {
    final reminder = await _db.reminders.get(id);
    if (reminder != null) {
      reminder.isEnabled = !reminder.isEnabled;
      await _db.writeTxn(() async {
        await _db.reminders.put(reminder);
      });
    }
  }

  /// Mark reminder as triggered
  Future<void> markTriggered(int id) async {
    final reminder = await _db.reminders.get(id);
    if (reminder != null) {
      reminder.lastTriggered = DateTime.now();
      reminder.nextScheduled = reminder.calculateNextScheduled();
      await _db.writeTxn(() async {
        await _db.reminders.put(reminder);
      });
    }
  }

  /// Get reminder count
  Future<int> getReminderCount() async {
    final allReminders = await _db.reminders.where().findAll();
    return allReminders.where((r) => r.isEnabled).length;
  }

  /// Export all reminders
  Future<List<Map<String, dynamic>>> exportAllReminders() async {
    final reminders = await _db.reminders.where().findAll();
    return reminders.map((r) => r.toJson()).toList();
  }

  /// Import reminders from JSON
  Future<void> importReminders(List<Map<String, dynamic>> remindersJson) async {
    await _db.writeTxn(() async {
      for (final json in remindersJson) {
        final reminder = Reminder.fromJson(json);
        await _db.reminders.put(reminder);
      }
    });
  }
}
