import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import '../../data/database/database.dart';
import '../../data/models/reminder.dart';
import '../../data/repositories/reminder_repository.dart';
import 'notification_provider.dart';

/// Provider for ReminderRepository
final reminderRepositoryProvider = Provider<ReminderRepository>((ref) {
  return ReminderRepository(databaseService: DatabaseService.instance);
});

/// Provider for all reminders
final remindersProvider =
    StateNotifierProvider<RemindersNotifier, AsyncValue<List<Reminder>>>((ref) {
  return RemindersNotifier(
    ref.watch(reminderRepositoryProvider),
    ref.watch(notificationProvider.notifier),
  );
});

/// Provider for reminders for a specific plant
final plantRemindersProvider =
    FutureProvider.family<List<Reminder>, int>((ref, plantId) async {
  final repository = ref.watch(reminderRepositoryProvider);
  return repository.getRemindersForPlant(plantId);
});

/// Provider for overdue reminders
final overdueRemindersProvider = FutureProvider<List<Reminder>>((ref) async {
  final repository = ref.watch(reminderRepositoryProvider);
  return repository.getOverdueReminders();
});

/// Provider for upcoming reminders
final upcomingRemindersProvider = FutureProvider<List<Reminder>>((ref) async {
  final repository = ref.watch(reminderRepositoryProvider);
  return repository.getUpcomingReminders();
});

/// Provider for today's reminders
final todayRemindersProvider = FutureProvider<List<Reminder>>((ref) async {
  final repository = ref.watch(reminderRepositoryProvider);
  return repository.getTodayReminders();
});

/// Reminders notifier
class RemindersNotifier extends StateNotifier<AsyncValue<List<Reminder>>> {
  RemindersNotifier(
    this._repository,
    this._notificationNotifier,
  ) : super(const AsyncValue.loading()) {
    loadReminders();
  }

  final ReminderRepository _repository;
  final NotificationNotifier _notificationNotifier;

  /// Test constructor that skips initialization
  @visibleForTesting
  RemindersNotifier._test()
      : _repository = _TestReminderRepository(),
        _notificationNotifier = NotificationNotifier.test(),
        super(AsyncValue.data([]));

  /// Load all reminders
  Future<void> loadReminders() async {
    try {
      final reminders = await _repository.getAllReminders();
      state = AsyncValue.data(reminders);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  /// Add a reminder
  Future<void> addReminder(Reminder reminder) async {
    try {
      await _repository.addReminder(reminder);
      await loadReminders();

      final plant = reminder.plant.value;
      if (plant != null) {
        await _notificationNotifier.scheduleReminder(reminder, plant.name);
      }
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  /// Update a reminder
  Future<void> updateReminder(Reminder reminder) async {
    try {
      final oldReminder = await _repository.getReminder(reminder.id);
      if (oldReminder?.notificationId != null) {
        await _notificationNotifier
            .cancelNotification(oldReminder!.notificationId!);
      }

      await _repository.updateReminder(reminder);
      await loadReminders();

      if (reminder.isEnabled) {
        final plant = reminder.plant.value;
        if (plant != null) {
          await _notificationNotifier.scheduleReminder(reminder, plant.name);
        }
      }
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  /// Delete a reminder
  Future<void> deleteReminder(int id) async {
    try {
      final reminder = await _repository.getReminder(id);
      if (reminder?.notificationId != null) {
        await _notificationNotifier
            .cancelNotification(reminder!.notificationId!);
      }

      await _repository.deleteReminder(id);
      await loadReminders();
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  /// Toggle reminder enabled
  Future<void> toggleEnabled(int id) async {
    try {
      await _repository.toggleEnabled(id);
      final reminder = await _repository.getReminder(id);
      if (reminder != null) {
        if (reminder.isEnabled && reminder.notificationId == null) {
          final plant = reminder.plant.value;
          if (plant != null) {
            await _notificationNotifier.scheduleReminder(reminder, plant.name);
          }
        } else if (!reminder.isEnabled && reminder.notificationId != null) {
          await _notificationNotifier
              .cancelNotification(reminder.notificationId!);
          reminder.notificationId = null;
          await _repository.updateReminder(reminder);
        }
      }
      await loadReminders();
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  /// Mark reminder as triggered
  Future<void> markTriggered(int id) async {
    try {
      final reminder = await _repository.getReminder(id);
      if (reminder?.notificationId != null) {
        await _notificationNotifier
            .cancelNotification(reminder!.notificationId!);
      }

      await _repository.markTriggered(id);
      await loadReminders();

      final updatedReminder = await _repository.getReminder(id);
      if (updatedReminder != null && updatedReminder.isEnabled) {
        final plant = updatedReminder.plant.value;
        if (plant != null) {
          await _notificationNotifier.scheduleReminder(
              updatedReminder, plant.name);
        }
      }
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  /// Reschedule all notifications (e.g., on app startup)
  Future<void> rescheduleAll() async {
    try {
      final reminders = await _repository.getActiveReminders();
      for (final reminder in reminders) {
        final plant = reminder.plant.value;
        if (plant != null) {
          await _notificationNotifier.scheduleReminder(reminder, plant.name);
        }
      }
    } catch (e) {
      debugPrint('Error rescheduling notifications: $e');
    }
  }
}

/// Test implementation of ReminderRepository for testing purposes
@visibleForTesting
class _TestReminderRepository implements ReminderRepository {
  @override
  late final DatabaseService databaseService;

  _TestReminderRepository() : databaseService = DatabaseService.test(_TestMockIsar());

  @override
  Future<List<Reminder>> getAllReminders() async => [];

  @override
  Future<List<Reminder>> getRemindersForPlant(int plantId) async => [];

  @override
  Future<List<Reminder>> getActiveReminders() async => [];

  @override
  Future<List<Reminder>> getOverdueReminders() async => [];

  @override
  Future<List<Reminder>> getTodayReminders() async => [];

  @override
  Future<List<Reminder>> getUpcomingReminders() async => [];

  @override
  Future<Reminder?> getReminder(int id) async => null;

  @override
  Future<int> addReminder(Reminder reminder) async => 0;

  @override
  Future<void> updateReminder(Reminder reminder) async {}

  @override
  Future<void> deleteReminder(int id) async {}

  @override
  Future<void> toggleEnabled(int id) async {}

  @override
  Future<void> markTriggered(int id) async {}

  @override
  Future<int> getReminderCount() async => 0;

  @override
  Future<List<Map<String, dynamic>>> exportAllReminders() async => [];

  @override
  Future<void> importReminders(List<Map<String, dynamic>> remindersJson) async {}
}

/// Minimal mock Isar for testing
class _TestMockIsar implements Isar {
  @override
  IsarCollection<T> collection<T>() {
    throw UnimplementedError('Mock Isar collection not implemented');
  }

  @override
  Future<T> writeTxn<T>(Future<T> Function() callback, {bool silent = false}) async {
    return callback();
  }

  @override
  dynamic noSuchMethod(Invocation invocation) {
    throw UnimplementedError('MockIsar.${invocation.memberName} not implemented');
  }
}
