import 'package:isar/isar.dart';
import 'plant.dart';

part 'growth_entry.g.dart';

/// Growth entry model for tracking plant growth over time
@collection
class GrowthEntry {
  GrowthEntry();

  /// Unique identifier
  Id id = Isar.autoIncrement;

  /// Date of the entry
  late DateTime date;

  /// Photo path (optional)
  String? photoPath;

  /// Height in cm (optional)
  double? heightCm;

  /// Number of new leaves
  int? newLeaves;

  /// Health rating (1-5)
  int? healthRating;

  /// Notes about growth
  String? notes;

  /// Entry type
  String entryType = 'photo'; // photo, note, measurement

  /// Linked plant
  final plant = IsarLink<Plant>();

  /// Copy with method
  GrowthEntry copyWith({
    int? id,
    DateTime? date,
    String? photoPath,
    double? heightCm,
    int? newLeaves,
    int? healthRating,
    String? notes,
    String? entryType,
  }) {
    return GrowthEntry()
      ..id = id ?? this.id
      ..date = date ?? this.date
      ..photoPath = photoPath ?? this.photoPath
      ..heightCm = heightCm ?? this.heightCm
      ..newLeaves = newLeaves ?? this.newLeaves
      ..healthRating = healthRating ?? this.healthRating
      ..notes = notes ?? this.notes
      ..entryType = entryType ?? this.entryType;
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'photoPath': photoPath,
      'heightCm': heightCm,
      'newLeaves': newLeaves,
      'healthRating': healthRating,
      'notes': notes,
      'entryType': entryType,
      'plantId': plant.value?.id,
    };
  }

  /// Create from JSON
  factory GrowthEntry.fromJson(Map<String, dynamic> json) {
    return GrowthEntry()
      ..id = json['id'] as int? ?? Isar.autoIncrement
      ..date = json['date'] != null
          ? DateTime.parse(json['date'] as String)
          : DateTime.now()
      ..photoPath = json['photoPath'] as String?
      ..heightCm = (json['heightCm'] as num?)?.toDouble()
      ..newLeaves = json['newLeaves'] as int?
      ..healthRating = json['healthRating'] as int?
      ..notes = json['notes'] as String?
      ..entryType = json['entryType'] as String? ?? 'photo';
  }
}
