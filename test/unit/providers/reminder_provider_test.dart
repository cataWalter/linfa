import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mockito/mockito.dart';
import 'package:linfa/shared/providers/reminder_provider.dart';
import 'package:linfa/shared/providers/notification_provider.dart';
import 'package:linfa/data/models/reminder.dart';
import 'package:linfa/data/repositories/reminder_repository.dart';
import 'package:linfa/data/database/database.dart';
import '../../mocks/mocks.mocks.dart';

void main() {
  group('RemindersNotifier', () {
    late _MockReminderRepository mockRepository;
    late MockNotificationNotifier mockNotificationNotifier;
    late RemindersNotifier notifier;

    Reminder createReminder(
        {int id = 1, bool isEnabled = true, int? notificationId}) {
      return Reminder()
        ..id = id
        ..type = 'watering'
        ..frequencyDays = 7
        ..time = DateTime.now()
        ..isEnabled = isEnabled
        ..notificationId = notificationId;
    }

    setUp(() {
      mockRepository = _MockReminderRepository();
      mockNotificationNotifier = MockNotificationNotifier();
      notifier = RemindersNotifier(mockRepository, mockNotificationNotifier);
    });

    test('initial state should be data after loading', () {
      expect(notifier.state, isA<AsyncData>());
      expect((notifier.state as AsyncData).value, isEmpty);
    });

    test('loadReminders should update state with reminders', () async {
      final reminders = [
        createReminder(id: 1),
        createReminder(id: 2),
      ];
      mockRepository.reminders = reminders;

      await notifier.loadReminders();

      expect(notifier.state.hasValue, true);
      expect(notifier.state.value, reminders);
    });

    test('loadReminders should handle errors', () async {
      mockRepository.shouldThrow = true;

      await notifier.loadReminders();

      expect(notifier.state.hasError, true);
    });

    test('addReminder should call repository and schedule notification',
        () async {
      final reminder = createReminder();
      mockRepository.reminders = [reminder];

      await notifier.addReminder(reminder);

      expect(mockRepository.addReminderCalled, true);
      expect(mockRepository.getAllRemindersCalled, true);
    });

    test('updateReminder should cancel old notification and schedule new',
        () async {
      final oldReminder = createReminder(id: 1, notificationId: 100);
      final updatedReminder = createReminder(id: 1, isEnabled: true);
      mockRepository.reminder = oldReminder;
      mockRepository.reminders = [updatedReminder];

      await notifier.updateReminder(updatedReminder);

      verify(mockNotificationNotifier.cancelNotification(100)).called(1);
      expect(mockRepository.updateReminderCalled, true);
    });

    test('deleteReminder should cancel notification and delete', () async {
      final reminder = createReminder(id: 1, notificationId: 100);
      mockRepository.reminder = reminder;
      mockRepository.reminders = [];

      await notifier.deleteReminder(1);

      verify(mockNotificationNotifier.cancelNotification(100)).called(1);
      expect(mockRepository.deleteReminderCalled, true);
    });

    test('deleteReminder should handle reminder without notification',
        () async {
      final reminder = createReminder(id: 1, notificationId: null);
      mockRepository.reminder = reminder;
      mockRepository.reminders = [];

      await notifier.deleteReminder(1);

      verifyNever(mockNotificationNotifier.cancelNotification(any));
      expect(mockRepository.deleteReminderCalled, true);
    });

    test('toggleEnabled should enable and schedule notification', () async {
      final reminder = createReminder(id: 1, isEnabled: true);
      mockRepository.reminder = reminder;
      mockRepository.reminders = [reminder];

      await notifier.toggleEnabled(1);

      expect(mockRepository.toggleEnabledCalled, true);
    });

    test('markTriggered should cancel notification and reschedule', () async {
      final reminder = createReminder(id: 1, notificationId: 100);
      mockRepository.reminder = reminder;
      mockRepository.reminders = [reminder];

      await notifier.markTriggered(1);

      verify(mockNotificationNotifier.cancelNotification(100)).called(1);
      expect(mockRepository.markTriggeredCalled, true);
    });

    test('rescheduleAll should schedule all active reminders', () async {
      final reminders = [createReminder(id: 1), createReminder(id: 2)];
      mockRepository.activeReminders = reminders;

      await notifier.rescheduleAll();

      expect(mockRepository.getActiveRemindersCalled, true);
    });
  });

  group('Reminder provider definitions', () {
    test('reminderRepositoryProvider should be defined', () {
      expect(reminderRepositoryProvider, isNotNull);
    });

    test('remindersProvider should be defined', () {
      expect(remindersProvider, isNotNull);
    });

    test('plantRemindersProvider should be defined', () {
      expect(plantRemindersProvider, isNotNull);
    });

    test('overdueRemindersProvider should be defined', () {
      expect(overdueRemindersProvider, isNotNull);
    });

    test('upcomingRemindersProvider should be defined', () {
      expect(upcomingRemindersProvider, isNotNull);
    });

    test('todayRemindersProvider should be defined', () {
      expect(todayRemindersProvider, isNotNull);
    });
  });
}

class _MockReminderRepository implements ReminderRepository {
  List<Reminder> reminders = [];
  Reminder? reminder;
  List<Reminder> activeReminders = [];
  bool shouldThrow = false;

  bool getAllRemindersCalled = false;
  bool addReminderCalled = false;
  bool updateReminderCalled = false;
  bool deleteReminderCalled = false;
  bool toggleEnabledCalled = false;
  bool markTriggeredCalled = false;
  bool getActiveRemindersCalled = false;

  @override
  Future<List<Reminder>> getAllReminders() async {
    if (shouldThrow) throw Exception('DB error');
    getAllRemindersCalled = true;
    return reminders;
  }

  @override
  Future<Reminder?> getReminder(int id) async {
    return reminder;
  }

  @override
  Future<int> addReminder(Reminder reminder) async {
    addReminderCalled = true;
    return reminder.id;
  }

  @override
  Future<void> updateReminder(Reminder reminder) async {
    updateReminderCalled = true;
  }

  @override
  Future<void> deleteReminder(int id) async {
    deleteReminderCalled = true;
  }

  @override
  Future<void> toggleEnabled(int id) async {
    toggleEnabledCalled = true;
  }

  @override
  Future<void> markTriggered(int id) async {
    markTriggeredCalled = true;
  }

  @override
  Future<List<Reminder>> getActiveReminders() async {
    getActiveRemindersCalled = true;
    return activeReminders;
  }

  @override
  Future<List<Reminder>> getRemindersForPlant(int plantId) async => [];

  @override
  Future<List<Reminder>> getOverdueReminders() async => [];

  @override
  Future<List<Reminder>> getTodayReminders() async => [];

  @override
  Future<List<Reminder>> getUpcomingReminders() async => [];

  @override
  Future<int> getReminderCount() async => 0;

  @override
  Future<List<Map<String, dynamic>>> exportAllReminders() async => [];

  @override
  Future<void> importReminders(
      List<Map<String, dynamic>> remindersJson) async {}

  @override
  DatabaseService get databaseService => throw UnimplementedError();
}
