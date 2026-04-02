import 'package:isar/isar.dart';
import 'plant.dart';

part 'reminder.g.dart';

/// Reminder model with Isar database support
@collection
class Reminder {
  Reminder();

  /// Unique identifier
  Id id = Isar.autoIncrement;

  /// Reminder type (watering, fertilizing, etc.)
  late String type;

  /// Frequency in days
  late int frequencyDays;

  /// Time of day for notification
  late DateTime time;

  /// Whether the reminder is enabled
  bool isEnabled = true;

  /// Custom message (optional)
  String? customMessage;

  /// Notification ID for local notifications
  int? notificationId;

  /// Last triggered date
  DateTime? lastTriggered;

  /// Next scheduled date
  DateTime? nextScheduled;

  /// Linked plant
  final plant = IsarLink<Plant>();

  /// Get display name for type
  String get typeDisplayName {
    switch (type) {
      case 'watering':
        return 'Annaffiare';
      case 'fertilizing':
        return 'Concimare';
      case 'repotting':
        return 'Rinvasare';
      case 'cleaning':
        return 'Pulire Foglie';
      case 'pruning':
        return 'Potare';
      case 'misting':
        return 'Nebulizzare';
      default:
        return type;
    }
  }

  /// Get icon name for type
  String get typeIcon {
    switch (type) {
      case 'watering':
        return 'water_drop';
      case 'fertilizing':
        return 'science';
      case 'repotting':
        return 'square_foot';
      case 'cleaning':
        return 'cleaning_services';
      case 'pruning':
        return 'content_cut';
      case 'misting':
        return 'air';
      default:
        return 'notifications';
    }
  }

  /// Calculate next scheduled date
  DateTime calculateNextScheduled() {
    final baseDate = lastTriggered ?? DateTime.now();
    return baseDate.add(Duration(days: frequencyDays));
  }

  /// Check if reminder is overdue
  bool get isOverdue {
    if (nextScheduled == null) return false;
    return DateTime.now().isAfter(nextScheduled!);
  }

  /// Copy with method
  Reminder copyWith({
    int? id,
    String? type,
    int? frequencyDays,
    DateTime? time,
    bool? isEnabled,
    String? customMessage,
    int? notificationId,
    DateTime? lastTriggered,
    DateTime? nextScheduled,
  }) {
    return Reminder()
      ..id = id ?? this.id
      ..type = type ?? this.type
      ..frequencyDays = frequencyDays ?? this.frequencyDays
      ..time = time ?? this.time
      ..isEnabled = isEnabled ?? this.isEnabled
      ..customMessage = customMessage ?? this.customMessage
      ..notificationId = notificationId ?? this.notificationId
      ..lastTriggered = lastTriggered ?? this.lastTriggered
      ..nextScheduled = nextScheduled ?? this.nextScheduled;
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'frequencyDays': frequencyDays,
      'time': time.toIso8601String(),
      'isEnabled': isEnabled,
      'customMessage': customMessage,
      'notificationId': notificationId,
      'lastTriggered': lastTriggered?.toIso8601String(),
      'nextScheduled': nextScheduled?.toIso8601String(),
      'plantId': plant.value?.id,
    };
  }

  /// Create from JSON
  factory Reminder.fromJson(Map<String, dynamic> json) {
    return Reminder()
      ..id = json['id'] as int? ?? Isar.autoIncrement
      ..type = json['type'] as String? ?? 'watering'
      ..frequencyDays = json['frequencyDays'] as int? ?? 7
      ..time = json['time'] != null
          ? DateTime.parse(json['time'] as String)
          : DateTime.now()
      ..isEnabled = json['isEnabled'] as bool? ?? true
      ..customMessage = json['customMessage'] as String?
      ..notificationId = json['notificationId'] as int?
      ..lastTriggered = json['lastTriggered'] != null
          ? DateTime.parse(json['lastTriggered'] as String)
          : null
      ..nextScheduled = json['nextScheduled'] != null
          ? DateTime.parse(json['nextScheduled'] as String)
          : null;
  }
}
