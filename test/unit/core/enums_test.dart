import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:linfa/core/constants/enums.dart';

void main() {
  group('LightCondition', () {
    group('displayName', () {
      test('should return Diretta for direct', () {
        expect(LightCondition.direct.displayName, 'Diretta');
      });

      test('should return Indiretta Brillante for indirectBright', () {
        expect(
            LightCondition.indirectBright.displayName, 'Indiretta Brillante');
      });

      test('should return Indiretta for indirect', () {
        expect(LightCondition.indirect.displayName, 'Indiretta');
      });

      test('should return Bassa for low', () {
        expect(LightCondition.low.displayName, 'Bassa');
      });
    });

    group('icon', () {
      test('should return wb_sunny for direct', () {
        expect(LightCondition.direct.icon, Icons.wb_sunny);
      });

      test('should return wb_sunny_outlined for indirectBright', () {
        expect(LightCondition.indirectBright.icon, Icons.wb_sunny_outlined);
      });

      test('should return cloud for indirect', () {
        expect(LightCondition.indirect.icon, Icons.cloud);
      });

      test('should return nights_stay for low', () {
        expect(LightCondition.low.icon, Icons.nights_stay);
      });
    });

    test('should have 4 values', () {
      expect(LightCondition.values.length, 4);
    });
  });

  group('PlantStatus', () {
    group('displayName', () {
      test('should return Sana for healthy', () {
        expect(PlantStatus.healthy.displayName, 'Sana');
      });

      test('should return Stressata for stressed', () {
        expect(PlantStatus.stressed.displayName, 'Stressata');
      });

      test('should return Dormiente for dormant', () {
        expect(PlantStatus.dormant.displayName, 'Dormiente');
      });

      test('should return In Recupero for recovering', () {
        expect(PlantStatus.recovering.displayName, 'In Recupero');
      });
    });

    group('icon', () {
      test('should return emoji_emotions for healthy', () {
        expect(PlantStatus.healthy.icon, Icons.emoji_emotions);
      });

      test('should return sentiment_dissatisfied for stressed', () {
        expect(PlantStatus.stressed.icon, Icons.sentiment_dissatisfied);
      });

      test('should return bedtime for dormant', () {
        expect(PlantStatus.dormant.icon, Icons.bedtime);
      });

      test('should return healing for recovering', () {
        expect(PlantStatus.recovering.icon, Icons.healing);
      });
    });

    test('should have 4 values', () {
      expect(PlantStatus.values.length, 4);
    });
  });

  group('ReminderType', () {
    group('displayName', () {
      test('should return Annaffiare for watering', () {
        expect(ReminderType.watering.displayName, 'Annaffiare');
      });

      test('should return Concimare for fertilizing', () {
        expect(ReminderType.fertilizing.displayName, 'Concimare');
      });

      test('should return Rinvasare for repotting', () {
        expect(ReminderType.repotting.displayName, 'Rinvasare');
      });

      test('should return Pulire Foglie for cleaning', () {
        expect(ReminderType.cleaning.displayName, 'Pulire Foglie');
      });

      test('should return Potare for pruning', () {
        expect(ReminderType.pruning.displayName, 'Potare');
      });

      test('should return Nebulizzare for misting', () {
        expect(ReminderType.misting.displayName, 'Nebulizzare');
      });
    });

    group('icon', () {
      test('should return water_drop for watering', () {
        expect(ReminderType.watering.icon, Icons.water_drop);
      });

      test('should return science for fertilizing', () {
        expect(ReminderType.fertilizing.icon, Icons.science);
      });

      test('should return square_foot for repotting', () {
        expect(ReminderType.repotting.icon, Icons.square_foot);
      });

      test('should return cleaning_services for cleaning', () {
        expect(ReminderType.cleaning.icon, Icons.cleaning_services);
      });

      test('should return content_cut for pruning', () {
        expect(ReminderType.pruning.icon, Icons.content_cut);
      });

      test('should return air for misting', () {
        expect(ReminderType.misting.icon, Icons.air);
      });
    });

    test('should have 6 values', () {
      expect(ReminderType.values.length, 6);
    });
  });

  group('ReminderFrequency', () {
    group('displayName', () {
      test('should return Ogni giorno for daily', () {
        expect(ReminderFrequency.daily.displayName, 'Ogni giorno');
      });

      test('should return Ogni settimana for weekly', () {
        expect(ReminderFrequency.weekly.displayName, 'Ogni settimana');
      });

      test('should return Ogni 2 settimane for biweekly', () {
        expect(ReminderFrequency.biweekly.displayName, 'Ogni 2 settimane');
      });

      test('should return Ogni mese for monthly', () {
        expect(ReminderFrequency.monthly.displayName, 'Ogni mese');
      });

      test('should return Personalizzato for custom', () {
        expect(ReminderFrequency.custom.displayName, 'Personalizzato');
      });
    });

    group('days', () {
      test('should return 1 for daily', () {
        expect(ReminderFrequency.daily.days, 1);
      });

      test('should return 7 for weekly', () {
        expect(ReminderFrequency.weekly.days, 7);
      });

      test('should return 14 for biweekly', () {
        expect(ReminderFrequency.biweekly.days, 14);
      });

      test('should return 30 for monthly', () {
        expect(ReminderFrequency.monthly.days, 30);
      });

      test('should return 7 for custom', () {
        expect(ReminderFrequency.custom.days, 7);
      });
    });

    test('should have 5 values', () {
      expect(ReminderFrequency.values.length, 5);
    });
  });

  group('Difficulty', () {
    group('displayName', () {
      test('should return Facile for easy', () {
        expect(Difficulty.easy.displayName, 'Facile');
      });

      test('should return Media for medium', () {
        expect(Difficulty.medium.displayName, 'Media');
      });

      test('should return Difficile for hard', () {
        expect(Difficulty.hard.displayName, 'Difficile');
      });
    });

    group('icon', () {
      test('should return sentiment_satisfied for easy', () {
        expect(Difficulty.easy.icon, Icons.sentiment_satisfied);
      });

      test('should return sentiment_neutral for medium', () {
        expect(Difficulty.medium.icon, Icons.sentiment_neutral);
      });

      test('should return sentiment_dissatisfied for hard', () {
        expect(Difficulty.hard.icon, Icons.sentiment_dissatisfied);
      });
    });

    test('should have 3 values', () {
      expect(Difficulty.values.length, 3);
    });
  });

  group('HumidityLevel', () {
    group('displayName', () {
      test('should return Bassa for low', () {
        expect(HumidityLevel.low.displayName, 'Bassa');
      });

      test('should return Media for medium', () {
        expect(HumidityLevel.medium.displayName, 'Media');
      });

      test('should return Alta for high', () {
        expect(HumidityLevel.high.displayName, 'Alta');
      });
    });

    test('should have 3 values', () {
      expect(HumidityLevel.values.length, 3);
    });
  });

  group('PlantSortOption', () {
    group('displayName', () {
      test('should return Nome for name', () {
        expect(PlantSortOption.name.displayName, 'Nome');
      });

      test('should return Ultima Annaffiatura for lastWatered', () {
        expect(PlantSortOption.lastWatered.displayName, 'Ultima Annaffiatura');
      });

      test('should return Aggiunte Recentemente for recentlyAdded', () {
        expect(
            PlantSortOption.recentlyAdded.displayName, 'Aggiunte Recentemente');
      });
    });

    test('should have 3 values', () {
      expect(PlantSortOption.values.length, 3);
    });
  });

  group('AppThemeMode', () {
    group('displayName', () {
      test('should return Sistema for system', () {
        expect(AppThemeMode.system.displayName, 'Sistema');
      });

      test('should return Chiaro for light', () {
        expect(AppThemeMode.light.displayName, 'Chiaro');
      });

      test('should return Scuro for dark', () {
        expect(AppThemeMode.dark.displayName, 'Scuro');
      });
    });

    test('should have 3 values', () {
      expect(AppThemeMode.values.length, 3);
    });
  });
}
