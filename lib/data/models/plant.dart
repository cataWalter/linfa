import 'package:isar/isar.dart';
import 'reminder.dart';
import 'growth_entry.dart';

part 'plant.g.dart';

/// Plant model with Isar database support
@collection
class Plant {
  Plant();

  /// Unique identifier
  Id id = Isar.autoIncrement;

  /// Plant name (required)
  late String name;

  /// Species name
  String? species;

  /// Room/location in the house
  String? room;

  /// Light condition
  String? lightCondition;

  /// Current health status
  String? status;

  /// Photo path
  String? photoPath;

  /// Notes about the plant
  String? notes;

  /// Date when the plant was added
  late DateTime createdAt;

  /// Date of last watering
  DateTime? lastWatered;

  /// Date of last fertilizing
  DateTime? lastFertilized;

  /// Date of last repotting
  DateTime? lastRepotted;

  /// Date of last cleaning
  DateTime? lastCleaned;

  /// Date of last pruning
  DateTime? lastPruned;

  /// Date of last misting
  DateTime? lastMisted;

  /// Whether the plant is archived
  bool isArchived = false;

  /// Favorite plant
  bool isFavorite = false;

  /// Linked reminders
  final reminders = IsarLinks<Reminder>();

  /// Linked growth entries
  final growthEntries = IsarLinks<GrowthEntry>();

  /// Get the most recent care date
  DateTime? get lastCareDate {
    final dates = [
      lastWatered,
      lastFertilized,
      lastRepotted,
      lastCleaned,
      lastPruned,
      lastMisted,
    ].whereType<DateTime>();
    if (dates.isEmpty) return null;
    return dates.reduce((a, b) => a.isAfter(b) ? a : b);
  }

  /// Get days since last watering
  int? get daysSinceLastWatering {
    if (lastWatered == null) return null;
    return DateTime.now().difference(lastWatered!).inDays;
  }

  /// Copy with method for immutability
  Plant copyWith({
    int? id,
    String? name,
    String? species,
    String? room,
    String? lightCondition,
    String? status,
    String? photoPath,
    String? notes,
    DateTime? createdAt,
    DateTime? lastWatered,
    DateTime? lastFertilized,
    DateTime? lastRepotted,
    DateTime? lastCleaned,
    DateTime? lastPruned,
    DateTime? lastMisted,
    bool? isArchived,
    bool? isFavorite,
  }) {
    return Plant()
      ..id = id ?? this.id
      ..name = name ?? this.name
      ..species = species ?? this.species
      ..room = room ?? this.room
      ..lightCondition = lightCondition ?? this.lightCondition
      ..status = status ?? this.status
      ..photoPath = photoPath ?? this.photoPath
      ..notes = notes ?? this.notes
      ..createdAt = createdAt ?? this.createdAt
      ..lastWatered = lastWatered ?? this.lastWatered
      ..lastFertilized = lastFertilized ?? this.lastFertilized
      ..lastRepotted = lastRepotted ?? this.lastRepotted
      ..lastCleaned = lastCleaned ?? this.lastCleaned
      ..lastPruned = lastPruned ?? this.lastPruned
      ..lastMisted = lastMisted ?? this.lastMisted
      ..isArchived = isArchived ?? this.isArchived
      ..isFavorite = isFavorite ?? this.isFavorite;
  }

  /// Convert to JSON for export
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'species': species,
      'room': room,
      'lightCondition': lightCondition,
      'status': status,
      'photoPath': photoPath,
      'notes': notes,
      'createdAt': createdAt.toIso8601String(),
      'lastWatered': lastWatered?.toIso8601String(),
      'lastFertilized': lastFertilized?.toIso8601String(),
      'lastRepotted': lastRepotted?.toIso8601String(),
      'lastCleaned': lastCleaned?.toIso8601String(),
      'lastPruned': lastPruned?.toIso8601String(),
      'lastMisted': lastMisted?.toIso8601String(),
      'isArchived': isArchived,
      'isFavorite': isFavorite,
    };
  }

  /// Create from JSON for import
  factory Plant.fromJson(Map<String, dynamic> json) {
    return Plant()
      ..id = json['id'] as int? ?? Isar.autoIncrement
      ..name = json['name'] as String? ?? 'Senza nome'
      ..species = json['species'] as String?
      ..room = json['room'] as String?
      ..lightCondition = json['lightCondition'] as String?
      ..status = json['status'] as String?
      ..photoPath = json['photoPath'] as String?
      ..notes = json['notes'] as String?
      ..createdAt = json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : DateTime.now()
      ..lastWatered = json['lastWatered'] != null
          ? DateTime.parse(json['lastWatered'] as String)
          : null
      ..lastFertilized = json['lastFertilized'] != null
          ? DateTime.parse(json['lastFertilized'] as String)
          : null
      ..lastRepotted = json['lastRepotted'] != null
          ? DateTime.parse(json['lastRepotted'] as String)
          : null
      ..lastCleaned = json['lastCleaned'] != null
          ? DateTime.parse(json['lastCleaned'] as String)
          : null
      ..lastPruned = json['lastPruned'] != null
          ? DateTime.parse(json['lastPruned'] as String)
          : null
      ..lastMisted = json['lastMisted'] != null
          ? DateTime.parse(json['lastMisted'] as String)
          : null
      ..isArchived = json['isArchived'] as bool? ?? false
      ..isFavorite = json['isFavorite'] as bool? ?? false;
  }
}
