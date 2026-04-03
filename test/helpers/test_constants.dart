import 'package:linfa/data/models/plant.dart';
import 'package:linfa/data/models/reminder.dart';
import 'package:linfa/data/models/growth_entry.dart';
import 'package:isar/isar.dart';

class TestConstants {
  TestConstants._();

  static const String testPlantName = 'Monstera';
  static const String testPlantSpecies = 'Monstera Deliciosa';
  static const String testPlantRoom = 'Soggiorno';
  static const String testPlantLight = 'indirect_bright';
  static const String testPlantStatus = 'healthy';
  static const String testPlantNotes = 'Una bella pianta';

  static const String testReminderType = 'watering';
  static const int testReminderFrequency = 7;
  static const String testReminderCustomMessage = 'Annaffia la Monstera';

  static const String testGrowthEntryType = 'photo';
  static const double testHeightCm = 45.5;
  static const int testNewLeaves = 3;
  static const int testHealthRating = 4;
  static const String testGrowthNotes = 'Sta crescendo bene';

  static final DateTime testDate = DateTime(2024, 3, 15);
  static final DateTime testDateTime = DateTime(2024, 3, 15, 10, 30);
  static final DateTime testPastDate = DateTime(2024, 1, 1);
  static final DateTime testFutureDate = DateTime(2024, 12, 31);

  static const String testPhotoPath = '/photos/1_test.jpg';
  static const String testExportJson = '{"plants": [], "reminders": []}';
}

Plant createTestPlant({
  int id = Isar.autoIncrement,
  String name = TestConstants.testPlantName,
  String? species = TestConstants.testPlantSpecies,
  String? room = TestConstants.testPlantRoom,
  String? lightCondition = TestConstants.testPlantLight,
  String? status = TestConstants.testPlantStatus,
  String? photoPath,
  String? notes = TestConstants.testPlantNotes,
  DateTime? createdAt,
  DateTime? lastWatered,
  DateTime? lastFertilized,
  DateTime? lastRepotted,
  DateTime? lastCleaned,
  DateTime? lastPruned,
  DateTime? lastMisted,
  bool isArchived = false,
  bool isFavorite = false,
}) {
  return Plant()
    ..id = id
    ..name = name
    ..species = species
    ..room = room
    ..lightCondition = lightCondition
    ..status = status
    ..photoPath = photoPath
    ..notes = notes
    ..createdAt = createdAt ?? TestConstants.testDate
    ..lastWatered = lastWatered
    ..lastFertilized = lastFertilized
    ..lastRepotted = lastRepotted
    ..lastCleaned = lastCleaned
    ..lastPruned = lastPruned
    ..lastMisted = lastMisted
    ..isArchived = isArchived
    ..isFavorite = isFavorite;
}

Reminder createTestReminder({
  int id = Isar.autoIncrement,
  String type = TestConstants.testReminderType,
  int frequencyDays = TestConstants.testReminderFrequency,
  DateTime? time,
  bool isEnabled = true,
  String? customMessage,
  int? notificationId,
  DateTime? lastTriggered,
  DateTime? nextScheduled,
}) {
  return Reminder()
    ..id = id
    ..type = type
    ..frequencyDays = frequencyDays
    ..time = time ?? TestConstants.testDateTime
    ..isEnabled = isEnabled
    ..customMessage = customMessage
    ..notificationId = notificationId
    ..lastTriggered = lastTriggered
    ..nextScheduled = nextScheduled;
}

GrowthEntry createTestGrowthEntry({
  int id = Isar.autoIncrement,
  DateTime? date,
  String? photoPath,
  double? heightCm = TestConstants.testHeightCm,
  int? newLeaves = TestConstants.testNewLeaves,
  int? healthRating = TestConstants.testHealthRating,
  String? notes = TestConstants.testGrowthNotes,
  String entryType = TestConstants.testGrowthEntryType,
}) {
  return GrowthEntry()
    ..id = id
    ..date = date ?? TestConstants.testDate
    ..photoPath = photoPath
    ..heightCm = heightCm
    ..newLeaves = newLeaves
    ..healthRating = healthRating
    ..notes = notes
    ..entryType = entryType;
}
