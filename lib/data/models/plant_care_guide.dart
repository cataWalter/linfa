/// Comprehensive plant care guide data model
class PlantCareGuide {
  final String id;
  final String commonName;
  final String scientificName;
  final String? family;
  final String? origin;
  final PlantDifficulty difficulty;
  final WateringGuide watering;
  final LightRequirements light;
  final HumidityRequirements humidity;
  final TemperatureRange temperature;
  final SoilRequirements soil;
  final FertilizingGuide fertilizing;
  final PruningGuide pruning;
  final PropagationMethods propagation;
  final List<String> toxicTo;
  final List<String> benefits;
  final List<CareTip> careTips;
  final List<CommonProblem> commonProblems;
  final GrowthCharacteristics growth;

  PlantCareGuide({
    required this.id,
    required this.commonName,
    required this.scientificName,
    this.family,
    this.origin,
    required this.difficulty,
    required this.watering,
    required this.light,
    required this.humidity,
    required this.temperature,
    required this.soil,
    required this.fertilizing,
    required this.pruning,
    required this.propagation,
    this.toxicTo = const [],
    this.benefits = const [],
    this.careTips = const [],
    this.commonProblems = const [],
    required this.growth,
  });

  factory PlantCareGuide.fromJson(Map<String, dynamic> json) {
    final wateringData = json['watering'] as Map<String, dynamic>? ?? {};
    final lightData = json['light'] as Map<String, dynamic>? ?? {};
    final humidityData = json['humidity'] as Map<String, dynamic>? ?? {};
    final temperatureData = json['temperature'] as Map<String, dynamic>? ?? {};
    final soilData = json['soil'] as Map<String, dynamic>? ?? {};
    final fertilizingData = json['fertilizing'] as Map<String, dynamic>? ?? {};
    final pruningData = json['pruning'] as Map<String, dynamic>? ?? {};
    final propagationData = json['propagation'] as Map<String, dynamic>? ?? {};
    final growthData = json['growth'] as Map<String, dynamic>? ?? {};

    return PlantCareGuide(
      id: (json['id'] as String?) ?? '',
      commonName: (json['common_name'] as String?) ?? 'Unknown',
      scientificName: (json['scientific_name'] as String?) ?? '',
      family: json['family'] as String?,
      origin: json['origin'] as String?,
      difficulty: PlantDifficulty.values.firstWhere(
        (d) => d.name == (json['difficulty'] as String?),
        orElse: () => PlantDifficulty.medium,
      ),
      watering: WateringGuide.fromJson(wateringData),
      light: LightRequirements.fromJson(lightData),
      humidity: HumidityRequirements.fromJson(humidityData),
      temperature: TemperatureRange.fromJson(temperatureData),
      soil: SoilRequirements.fromJson(soilData),
      fertilizing: FertilizingGuide.fromJson(fertilizingData),
      pruning: PruningGuide.fromJson(pruningData),
      propagation: PropagationMethods.fromJson(propagationData),
      toxicTo: (json['toxic_to'] as List?)?.cast<String>() ?? [],
      benefits: (json['benefits'] as List?)?.cast<String>() ?? [],
      careTips: (json['care_tips'] as List?)
              ?.cast<Map<String, dynamic>>()
              .map((tip) => CareTip.fromJson(tip))
              .toList() ??
          [],
      commonProblems: (json['common_problems'] as List?)
              ?.cast<Map<String, dynamic>>()
              .map((problem) => CommonProblem.fromJson(problem))
              .toList() ??
          [],
      growth: GrowthCharacteristics.fromJson(growthData),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'common_name': commonName,
        'scientific_name': scientificName,
        'family': family,
        'origin': origin,
        'difficulty': difficulty.name,
        'watering': watering.toJson(),
        'light': light.toJson(),
        'humidity': humidity.toJson(),
        'temperature': temperature.toJson(),
        'soil': soil.toJson(),
        'fertilizing': fertilizing.toJson(),
        'pruning': pruning.toJson(),
        'propagation': propagation.toJson(),
        'toxic_to': toxicTo,
        'benefits': benefits,
        'care_tips': careTips.map((tip) => tip.toJson()).toList(),
        'common_problems': commonProblems.map((p) => p.toJson()).toList(),
        'growth': growth.toJson(),
      };

  /// Get watering frequency in days
  int get wateringFrequencyDays => watering.frequencyDays;

  /// Get care difficulty display name
  String get difficultyDisplayName {
    switch (difficulty) {
      case PlantDifficulty.easy:
        return 'Easy - Perfect for beginners';
      case PlantDifficulty.medium:
        return 'Moderate - Some experience helpful';
      case PlantDifficulty.hard:
        return 'Challenging - For experienced plant parents';
    }
  }

  /// Check if plant is pet-friendly
  bool get isPetFriendly => toxicTo.isEmpty;

  /// Get estimated growth rate description
  String get growthRateDescription {
    switch (growth.rate) {
      case GrowthRate.slow:
        return 'Slow growing - Patience required';
      case GrowthRate.moderate:
        return 'Moderate growth - Steady progress';
      case GrowthRate.fast:
        return 'Fast growing - Quick results';
    }
  }
}

enum PlantDifficulty { easy, medium, hard }

enum GrowthRate { slow, moderate, fast }

class WateringGuide {
  final int frequencyDays;
  final String method;
  final List<String> signs;
  final String? seasonalAdjustment;

  WateringGuide({
    required this.frequencyDays,
    required this.method,
    required this.signs,
    this.seasonalAdjustment,
  });

  factory WateringGuide.fromJson(Map<String, dynamic> json) {
    return WateringGuide(
      frequencyDays: json['frequency_days'] ?? 7,
      method: json['method'] ?? 'Regular',
      signs: List<String>.from(json['signs'] ?? []),
      seasonalAdjustment: json['seasonal_adjustment'],
    );
  }

  Map<String, dynamic> toJson() => {
        'frequency_days': frequencyDays,
        'method': method,
        'signs': signs,
        'seasonal_adjustment': seasonalAdjustment,
      };
}

class LightRequirements {
  final LightType type;
  final int hoursPerDay;
  final String description;
  final List<String> signs;

  LightRequirements({
    required this.type,
    required this.hoursPerDay,
    required this.description,
    required this.signs,
  });

  factory LightRequirements.fromJson(Map<String, dynamic> json) {
    return LightRequirements(
      type: LightType.values.firstWhere(
        (t) => t.name == json['type'],
        orElse: () => LightType.indirectBright,
      ),
      hoursPerDay: json['hours_per_day'] ?? 6,
      description: json['description'] ?? '',
      signs: List<String>.from(json['signs'] ?? []),
    );
  }

  Map<String, dynamic> toJson() => {
        'type': type.name,
        'hours_per_day': hoursPerDay,
        'description': description,
        'signs': signs,
      };
}

enum LightType {
  direct,
  indirectBright,
  indirect,
  low,
  shade,
}

class HumidityRequirements {
  final HumidityLevel level;
  final int percentage;
  final List<String> tips;

  HumidityRequirements({
    required this.level,
    required this.percentage,
    required this.tips,
  });

  factory HumidityRequirements.fromJson(Map<String, dynamic> json) {
    return HumidityRequirements(
      level: HumidityLevel.values.firstWhere(
        (l) => l.name == json['level'],
        orElse: () => HumidityLevel.medium,
      ),
      percentage: json['percentage'] ?? 50,
      tips: List<String>.from(json['tips'] ?? []),
    );
  }

  Map<String, dynamic> toJson() => {
        'level': level.name,
        'percentage': percentage,
        'tips': tips,
      };
}

enum HumidityLevel { low, medium, high }

class TemperatureRange {
  final int minCelsius;
  final int maxCelsius;
  final String? notes;

  TemperatureRange({
    required this.minCelsius,
    required this.maxCelsius,
    this.notes,
  });

  factory TemperatureRange.fromJson(Map<String, dynamic> json) {
    return TemperatureRange(
      minCelsius: json['min_celsius'] ?? 15,
      maxCelsius: json['max_celsius'] ?? 25,
      notes: json['notes'],
    );
  }

  Map<String, dynamic> toJson() => {
        'min_celsius': minCelsius,
        'max_celsius': maxCelsius,
        'notes': notes,
      };

  String get displayRange => '$minCelsius°C - $maxCelsius°C';
}

class SoilRequirements {
  final String type;
  final int? phMin;
  final int? phMax;
  final List<String> characteristics;

  SoilRequirements({
    required this.type,
    this.phMin,
    this.phMax,
    required this.characteristics,
  });

  factory SoilRequirements.fromJson(Map<String, dynamic> json) {
    return SoilRequirements(
      type: json['type'] ?? 'Well-draining',
      phMin: json['ph_min'],
      phMax: json['ph_max'],
      characteristics: List<String>.from(json['characteristics'] ?? []),
    );
  }

  Map<String, dynamic> toJson() => {
        'type': type,
        'ph_min': phMin,
        'ph_max': phMax,
        'characteristics': characteristics,
      };

  String? get phRange {
    if (phMin != null && phMax != null) return '$phMin - $phMax';
    return null;
  }
}

class FertilizingGuide {
  final int frequencyWeeks;
  final String type;
  final String? seasonalNotes;

  FertilizingGuide({
    required this.frequencyWeeks,
    required this.type,
    this.seasonalNotes,
  });

  factory FertilizingGuide.fromJson(Map<String, dynamic> json) {
    return FertilizingGuide(
      frequencyWeeks: json['frequency_weeks'] ?? 4,
      type: json['type'] ?? 'Balanced',
      seasonalNotes: json['seasonal_notes'],
    );
  }

  Map<String, dynamic> toJson() => {
        'frequency_weeks': frequencyWeeks,
        'type': type,
        'seasonal_notes': seasonalNotes,
      };
}

class PruningGuide {
  final String? frequency;
  final List<String> techniques;
  final String? bestTime;

  PruningGuide({
    this.frequency,
    required this.techniques,
    this.bestTime,
  });

  factory PruningGuide.fromJson(Map<String, dynamic> json) {
    return PruningGuide(
      frequency: json['frequency'],
      techniques: List<String>.from(json['techniques'] ?? []),
      bestTime: json['best_time'],
    );
  }

  Map<String, dynamic> toJson() => {
        'frequency': frequency,
        'techniques': techniques,
        'best_time': bestTime,
      };
}

class PropagationMethods {
  final List<PropagationType> methods;
  final String? difficulty;
  final int? weeksToRoot;

  PropagationMethods({
    required this.methods,
    this.difficulty,
    this.weeksToRoot,
  });

  factory PropagationMethods.fromJson(Map<String, dynamic> json) {
    return PropagationMethods(
      methods: (json['methods'] as List?)
              ?.map((m) => PropagationType.values.firstWhere(
                    (t) => t.name == m,
                    orElse: () => PropagationType.stem,
                  ))
              .toList() ??
          [],
      difficulty: json['difficulty'],
      weeksToRoot: json['weeks_to_root'],
    );
  }

  Map<String, dynamic> toJson() => {
        'methods': methods.map((m) => m.name).toList(),
        'difficulty': difficulty,
        'weeks_to_root': weeksToRoot,
      };
}

enum PropagationType {
  stem,
  leaf,
  division,
  seeds,
  airLayering,
  rootCutting,
}

class CareTip {
  final String title;
  final String description;
  final CareTipCategory category;

  CareTip({
    required this.title,
    required this.description,
    required this.category,
  });

  factory CareTip.fromJson(Map<String, dynamic> json) {
    return CareTip(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      category: CareTipCategory.values.firstWhere(
        (c) => c.name == json['category'],
        orElse: () => CareTipCategory.general,
      ),
    );
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'category': category.name,
      };
}

enum CareTipCategory {
  general,
  watering,
  light,
  humidity,
  fertilizing,
  pruning,
  repotting,
  pests,
  diseases,
}

class CommonProblem {
  final String name;
  final String symptoms;
  final String solution;
  final ProblemSeverity severity;
  final List<String> prevention;

  CommonProblem({
    required this.name,
    required this.symptoms,
    required this.solution,
    required this.severity,
    required this.prevention,
  });

  factory CommonProblem.fromJson(Map<String, dynamic> json) {
    return CommonProblem(
      name: json['name'] ?? '',
      symptoms: json['symptoms'] ?? '',
      solution: json['solution'] ?? '',
      severity: ProblemSeverity.values.firstWhere(
        (s) => s.name == json['severity'],
        orElse: () => ProblemSeverity.moderate,
      ),
      prevention: List<String>.from(json['prevention'] ?? []),
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'symptoms': symptoms,
        'solution': solution,
        'severity': severity.name,
        'prevention': prevention,
      };
}

enum ProblemSeverity { mild, moderate, severe }

class GrowthCharacteristics {
  final GrowthRate rate;
  final double? maxHeightCm;
  final double? maxWidthCm;
  final String? spread;
  final List<String> features;

  GrowthCharacteristics({
    required this.rate,
    this.maxHeightCm,
    this.maxWidthCm,
    this.spread,
    required this.features,
  });

  factory GrowthCharacteristics.fromJson(Map<String, dynamic> json) {
    return GrowthCharacteristics(
      rate: GrowthRate.values.firstWhere(
        (r) => r.name == json['rate'],
        orElse: () => GrowthRate.moderate,
      ),
      maxHeightCm: json['max_height_cm']?.toDouble(),
      maxWidthCm: json['max_width_cm']?.toDouble(),
      spread: json['spread'],
      features: List<String>.from(json['features'] ?? []),
    );
  }

  Map<String, dynamic> toJson() => {
        'rate': rate.name,
        'max_height_cm': maxHeightCm,
        'max_width_cm': maxWidthCm,
        'spread': spread,
        'features': features,
      };

  String get maxSizeDescription {
    if (maxHeightCm != null && maxWidthCm != null) {
      return '${maxHeightCm}cm H × ${maxWidthCm}cm W';
    }
    return spread ?? 'Variable';
  }
}