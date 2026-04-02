/// Plant type model for predefined plant care information
class PlantType {
  PlantType({
    required this.name,
    required this.scientificName,
    required this.wateringFrequencyDays,
    required this.lightRequirements,
    required this.humidityLevel,
    required this.difficulty,
    this.tips = const [],
    this.description = '',
    this.toxicToPets = false,
    this.petFriendly = true,
    this.maxHeightCm,
    this.growthRate = 'medium',
  });

  /// Common name
  final String name;

  /// Scientific name
  final String scientificName;

  /// Recommended watering frequency in days
  final int wateringFrequencyDays;

  /// Light requirements
  final String lightRequirements;

  /// Humidity level preference
  final String humidityLevel;

  /// Difficulty level
  final String difficulty;

  /// Care tips
  final List<String> tips;

  /// Description
  final String description;

  /// Whether it's toxic to pets
  final bool toxicToPets;

  /// Whether it's pet friendly
  final bool petFriendly;

  /// Maximum height in cm
  final int? maxHeightCm;

  /// Growth rate
  final String growthRate;

  /// Create from JSON
  factory PlantType.fromJson(Map<String, dynamic> json) {
    return PlantType(
      name: json['name'] as String,
      scientificName: json['scientific_name'] as String,
      wateringFrequencyDays: json['watering_frequency_days'] as int,
      lightRequirements: json['light_requirements'] as String,
      humidityLevel: json['humidity_level'] as String,
      difficulty: json['difficulty'] as String,
      tips: (json['tips'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      description: json['description'] as String? ?? '',
      toxicToPets: json['toxic_to_pets'] as bool? ?? false,
      petFriendly: json['pet_friendly'] as bool? ?? true,
      maxHeightCm: json['max_height_cm'] as int?,
      growthRate: json['growth_rate'] as String? ?? 'medium',
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'scientific_name': scientificName,
      'watering_frequency_days': wateringFrequencyDays,
      'light_requirements': lightRequirements,
      'humidity_level': humidityLevel,
      'difficulty': difficulty,
      'tips': tips,
      'description': description,
      'toxic_to_pets': toxicToPets,
      'pet_friendly': petFriendly,
      'max_height_cm': maxHeightCm,
      'growth_rate': growthRate,
    };
  }

  /// Get display name for light requirements
  String get lightDisplayName {
    switch (lightRequirements) {
      case 'direct':
        return 'Diretta';
      case 'indirect_bright':
        return 'Indiretta Brillante';
      case 'indirect':
        return 'Indiretta';
      case 'low':
        return 'Bassa';
      default:
        return lightRequirements;
    }
  }

  /// Get display name for humidity level
  String get humidityDisplayName {
    switch (humidityLevel) {
      case 'low':
        return 'Bassa';
      case 'medium':
        return 'Media';
      case 'high':
        return 'Alta';
      default:
        return humidityLevel;
    }
  }

  /// Get display name for difficulty
  String get difficultyDisplayName {
    switch (difficulty) {
      case 'easy':
        return 'Facile';
      case 'medium':
        return 'Media';
      case 'hard':
        return 'Difficile';
      default:
        return difficulty;
    }
  }

  /// Get display name for growth rate
  String get growthRateDisplayName {
    switch (growthRate) {
      case 'slow':
        return 'Lenta';
      case 'medium':
        return 'Media';
      case 'fast':
        return 'Veloce';
      default:
        return growthRate;
    }
  }
}
