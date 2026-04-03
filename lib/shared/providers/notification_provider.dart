import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:timezone/timezone.dart' as tz;
import '../../data/models/reminder.dart';

/// Notification settings model
class NotificationSettings {
  const NotificationSettings({
    required this.enabled,
    this.sound = true,
  });

  final bool enabled;
  final bool sound;

  NotificationSettings copyWith({bool? enabled, bool? sound}) {
    return NotificationSettings(
      enabled: enabled ?? this.enabled,
      sound: sound ?? this.sound,
    );
  }
}

/// Notification provider for managing local notifications
class NotificationNotifier extends StateNotifier<NotificationSettings> {
  NotificationNotifier() : super(const NotificationSettings(enabled: true)) {
    _init();
  }

  /// Test constructor that skips platform-specific initialization
  @visibleForTesting
  NotificationNotifier.test() : super(const NotificationSettings(enabled: true));

  late final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  static const String _settingsBoxName = 'notification_settings';
  static const String _enabledKey = 'notifications_enabled';
  static const String _soundKey = 'notification_sound';

  late Box _box;

  /// Initialize notifications
  Future<void> _init() async {
    _box = await Hive.openBox(_settingsBoxName);

    final enabled = _box.get(_enabledKey, defaultValue: true) as bool;
    final sound = _box.get(_soundKey, defaultValue: true) as bool;
    state = NotificationSettings(enabled: enabled, sound: sound);

    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const darwinSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    const settings = InitializationSettings(
      android: androidSettings,
      iOS: darwinSettings,
      macOS: darwinSettings,
    );

    await _notifications.initialize(
      settings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );

    // Request permissions for Android
    await _notifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

    // Request permissions for iOS/macOS
    await _notifications
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(alert: true, badge: true, sound: true);
  }

  /// Handle notification tap
  void _onNotificationTapped(NotificationResponse response) {
    debugPrint('Notification tapped: ${response.payload}');
  }

  /// Generate deterministic notification ID based on reminder properties
  int _generateNotificationId(Reminder reminder) {
    return reminder.id.hashCode & 0x7FFFFFFF;
  }

  /// Toggle notifications enabled
  Future<void> toggleEnabled() async {
    final newValue = !state.enabled;
    state = state.copyWith(enabled: newValue);
    await _box.put(_enabledKey, newValue);

    if (!newValue) {
      await cancelAll();
    }
  }

  /// Toggle sound
  Future<void> toggleSound() async {
    final newValue = !state.sound;
    state = state.copyWith(sound: newValue);
    await _box.put(_soundKey, newValue);
  }

  /// Schedule a reminder notification
  Future<int> scheduleReminder(Reminder reminder, String plantName) async {
    if (!state.enabled) return -1;
    if (!reminder.isEnabled) return -1;

    final notificationId = _generateNotificationId(reminder);
    reminder.notificationId = notificationId;

    final title = reminder.typeDisplayName;
    final body =
        'È ora di ${reminder.typeDisplayName.toLowerCase()} $plantName';

    final androidDetails = AndroidNotificationDetails(
      'linfa_reminders',
      'Linfa Promemoria',
      channelDescription: 'Promemoria per la cura delle piante',
      importance: Importance.high,
      priority: Priority.high,
      styleInformation: BigTextStyleInformation(body),
    );

    const darwinDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    final details = NotificationDetails(
      android: androidDetails,
      iOS: darwinDetails,
      macOS: darwinDetails,
    );

    // Schedule at the reminder's time
    final scheduledDate =
        reminder.nextScheduled ?? reminder.calculateNextScheduled();
    final notificationTime = reminder.time;
    final finalDate = DateTime(
      scheduledDate.year,
      scheduledDate.month,
      scheduledDate.day,
      notificationTime.hour,
      notificationTime.minute,
    );

    if (finalDate.isAfter(DateTime.now())) {
      await _notifications.zonedSchedule(
        notificationId,
        title,
        body,
        tz.TZDateTime.from(finalDate, tz.local),
        details,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        payload: 'reminder_${reminder.id}',
      );
    }

    return notificationId;
  }

  /// Cancel a specific notification
  Future<void> cancelNotification(int id) async {
    await _notifications.cancel(id);
  }

  /// Cancel all notifications
  Future<void> cancelAll() async {
    await _notifications.cancelAll();
  }

  /// Cancel notifications for a specific plant
  Future<void> cancelPlantReminders(List<Reminder> reminders) async {
    for (final reminder in reminders) {
      if (reminder.notificationId != null) {
        await cancelNotification(reminder.notificationId!);
      }
    }
  }
}

final notificationProvider =
    StateNotifierProvider<NotificationNotifier, NotificationSettings>((ref) {
  return NotificationNotifier();
});
