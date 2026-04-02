/// Enums used throughout the application
import 'package:flutter/material.dart';

/// Light condition for plants

/// Light condition for plants
enum LightCondition {
  direct,
  indirectBright,
  indirect,
  low;

  String get displayName {
    switch (this) {
      case LightCondition.direct:
        return 'Diretta';
      case LightCondition.indirectBright:
        return 'Indiretta Brillante';
      case LightCondition.indirect:
        return 'Indiretta';
      case LightCondition.low:
        return 'Bassa';
    }
  }

  IconData get icon {
    switch (this) {
      case LightCondition.direct:
        return Icons.wb_sunny;
      case LightCondition.indirectBright:
        return Icons.wb_sunny_outlined;
      case LightCondition.indirect:
        return Icons.cloud;
      case LightCondition.low:
        return Icons.nights_stay;
    }
  }
}

/// Plant health status
enum PlantStatus {
  healthy,
  stressed,
  dormant,
  recovering;

  String get displayName {
    switch (this) {
      case PlantStatus.healthy:
        return 'Sana';
      case PlantStatus.stressed:
        return 'Stressata';
      case PlantStatus.dormant:
        return 'Dormiente';
      case PlantStatus.recovering:
        return 'In Recupero';
    }
  }

  IconData get icon {
    switch (this) {
      case PlantStatus.healthy:
        return Icons.emoji_emotions;
      case PlantStatus.stressed:
        return Icons.sentiment_dissatisfied;
      case PlantStatus.dormant:
        return Icons.bedtime;
      case PlantStatus.recovering:
        return Icons.healing;
    }
  }
}

/// Reminder type
enum ReminderType {
  watering,
  fertilizing,
  repotting,
  cleaning,
  pruning,
  misting;

  String get displayName {
    switch (this) {
      case ReminderType.watering:
        return 'Annaffiare';
      case ReminderType.fertilizing:
        return 'Concimare';
      case ReminderType.repotting:
        return 'Rinvasare';
      case ReminderType.cleaning:
        return 'Pulire Foglie';
      case ReminderType.pruning:
        return 'Potare';
      case ReminderType.misting:
        return 'Nebulizzare';
    }
  }

  IconData get icon {
    switch (this) {
      case ReminderType.watering:
        return Icons.water_drop;
      case ReminderType.fertilizing:
        return Icons.science;
      case ReminderType.repotting:
        return Icons.square_foot;
      case ReminderType.cleaning:
        return Icons.cleaning_services;
      case ReminderType.pruning:
        return Icons.content_cut;
      case ReminderType.misting:
        return Icons.air;
    }
  }
}

/// Reminder frequency
enum ReminderFrequency {
  daily,
  weekly,
  biweekly,
  monthly,
  custom;

  String get displayName {
    switch (this) {
      case ReminderFrequency.daily:
        return 'Ogni giorno';
      case ReminderFrequency.weekly:
        return 'Ogni settimana';
      case ReminderFrequency.biweekly:
        return 'Ogni 2 settimane';
      case ReminderFrequency.monthly:
        return 'Ogni mese';
      case ReminderFrequency.custom:
        return 'Personalizzato';
    }
  }

  int get days {
    switch (this) {
      case ReminderFrequency.daily:
        return 1;
      case ReminderFrequency.weekly:
        return 7;
      case ReminderFrequency.biweekly:
        return 14;
      case ReminderFrequency.monthly:
        return 30;
      case ReminderFrequency.custom:
        return 7;
    }
  }
}

/// Difficulty level for plant types
enum Difficulty {
  easy,
  medium,
  hard;

  String get displayName {
    switch (this) {
      case Difficulty.easy:
        return 'Facile';
      case Difficulty.medium:
        return 'Media';
      case Difficulty.hard:
        return 'Difficile';
    }
  }

  IconData get icon {
    switch (this) {
      case Difficulty.easy:
        return Icons.sentiment_satisfied;
      case Difficulty.medium:
        return Icons.sentiment_neutral;
      case Difficulty.hard:
        return Icons.sentiment_dissatisfied;
    }
  }
}

/// Humidity level
enum HumidityLevel {
  low,
  medium,
  high;

  String get displayName {
    switch (this) {
      case HumidityLevel.low:
        return 'Bassa';
      case HumidityLevel.medium:
        return 'Media';
      case HumidityLevel.high:
        return 'Alta';
    }
  }
}

/// Sort options for plant list
enum PlantSortOption {
  name,
  lastWatered,
  recentlyAdded;

  String get displayName {
    switch (this) {
      case PlantSortOption.name:
        return 'Nome';
      case PlantSortOption.lastWatered:
        return 'Ultima Annaffiatura';
      case PlantSortOption.recentlyAdded:
        return 'Aggiunte Recentemente';
    }
  }
}

/// Theme mode
enum AppThemeMode {
  system,
  light,
  dark;

  String get displayName {
    switch (this) {
      case AppThemeMode.system:
        return 'Sistema';
      case AppThemeMode.light:
        return 'Chiaro';
      case AppThemeMode.dark:
        return 'Scuro';
    }
  }
}
