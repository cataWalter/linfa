import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:linfa/data/repositories/plant_repository.dart';
import 'package:linfa/data/repositories/reminder_repository.dart';
import 'package:linfa/data/database/database.dart';
import 'package:linfa/shared/providers/notification_provider.dart';
import 'package:linfa/shared/providers/theme_provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:isar/isar.dart';
import 'package:linfa/data/models/plant.dart';
import 'package:linfa/data/models/reminder.dart';
import 'package:linfa/data/models/growth_entry.dart';

@GenerateMocks([
  PlantRepository,
  ReminderRepository,
  DatabaseService,
  NotificationNotifier,
  ThemeNotifier,
  FlutterLocalNotificationsPlugin,
])
void main() {}
