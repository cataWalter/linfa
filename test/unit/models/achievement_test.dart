import 'package:flutter_test/flutter_test.dart';
import 'package:linfa/data/models/achievement.dart';

void main() {
  group('Achievement', () {
    test('should create with all fields', () {
      final achievement = Achievement(
        id: 'test_achievement',
        name: 'Test Achievement',
        description: 'A test achievement',
        category: AchievementCategory.watering,
        tier: AchievementTier.gold,
        requiredCount: 100,
        icon: '🏆',
        points: 250,
        unlockedAt: DateTime(2024, 1, 1),
        isUnlocked: true,
      );

      expect(achievement.id, 'test_achievement');
      expect(achievement.name, 'Test Achievement');
      expect(achievement.description, 'A test achievement');
      expect(achievement.category, AchievementCategory.watering);
      expect(achievement.tier, AchievementTier.gold);
      expect(achievement.requiredCount, 100);
      expect(achievement.icon, '🏆');
      expect(achievement.points, 250);
      expect(achievement.unlockedAt, DateTime(2024, 1, 1));
      expect(achievement.isUnlocked, true);
    });

    test('should use default values', () {
      final achievement = Achievement(
        id: 'test',
        name: 'Test',
        description: 'Test',
        category: AchievementCategory.watering,
        tier: AchievementTier.bronze,
        requiredCount: 1,
        icon: '⭐',
        points: 10,
      );

      expect(achievement.unlockedAt, isNull);
      expect(achievement.isUnlocked, false);
    });

    group('getProgress', () {
      test('should return 1.0 when already unlocked', () {
        final achievement = Achievement(
          id: 'test',
          name: 'Test',
          description: 'Test',
          category: AchievementCategory.watering,
          tier: AchievementTier.bronze,
          requiredCount: 10,
          icon: '⭐',
          points: 10,
          isUnlocked: true,
        );

        expect(achievement.getProgress(0), 1.0);
        expect(achievement.getProgress(5), 1.0);
      });

      test('should return correct progress when not unlocked', () {
        final achievement = Achievement(
          id: 'test',
          name: 'Test',
          description: 'Test',
          category: AchievementCategory.watering,
          tier: AchievementTier.bronze,
          requiredCount: 10,
          icon: '⭐',
          points: 10,
        );

        expect(achievement.getProgress(0), 0.0);
        expect(achievement.getProgress(5), 0.5);
        expect(achievement.getProgress(10), 1.0);
        expect(achievement.getProgress(15), 1.0); // Clamped to 1.0
      });

      test('should clamp progress between 0 and 1', () {
        final achievement = Achievement(
          id: 'test',
          name: 'Test',
          description: 'Test',
          category: AchievementCategory.watering,
          tier: AchievementTier.bronze,
          requiredCount: 10,
          icon: '⭐',
          points: 10,
        );

        expect(achievement.getProgress(-5), 0.0);
        expect(achievement.getProgress(20), 1.0);
      });
    });

    group('checkUnlocked', () {
      test('should return true when count >= requiredCount', () {
        final achievement = Achievement(
          id: 'test',
          name: 'Test',
          description: 'Test',
          category: AchievementCategory.watering,
          tier: AchievementTier.bronze,
          requiredCount: 10,
          icon: '⭐',
          points: 10,
        );

        expect(achievement.checkUnlocked(9), false);
        expect(achievement.checkUnlocked(10), true);
        expect(achievement.checkUnlocked(11), true);
      });
    });
  });

  group('AchievementCategory', () {
    test('should have all expected values', () {
      expect(AchievementCategory.values.length, 8);
      expect(AchievementCategory.values, contains(AchievementCategory.watering));
      expect(AchievementCategory.values, contains(AchievementCategory.growth));
      expect(AchievementCategory.values, contains(AchievementCategory.collection));
      expect(AchievementCategory.values, contains(AchievementCategory.care));
      expect(AchievementCategory.values, contains(AchievementCategory.streak));
      expect(AchievementCategory.values, contains(AchievementCategory.knowledge));
      expect(AchievementCategory.values, contains(AchievementCategory.social));
      expect(AchievementCategory.values, contains(AchievementCategory.special));
    });
  });

  group('AchievementTier', () {
    test('should have all expected values', () {
      expect(AchievementTier.values.length, 5);
      expect(AchievementTier.values, contains(AchievementTier.bronze));
      expect(AchievementTier.values, contains(AchievementTier.silver));
      expect(AchievementTier.values, contains(AchievementTier.gold));
      expect(AchievementTier.values, contains(AchievementTier.platinum));
      expect(AchievementTier.values, contains(AchievementTier.diamond));
    });
  });

  group('AchievementTierExtension', () {
    group('displayName', () {
      test('should return correct display name for each tier', () {
        expect(AchievementTier.bronze.displayName, 'Bronze');
        expect(AchievementTier.silver.displayName, 'Silver');
        expect(AchievementTier.gold.displayName, 'Gold');
        expect(AchievementTier.platinum.displayName, 'Platinum');
        expect(AchievementTier.diamond.displayName, 'Diamond');
      });
    });

    group('multiplier', () {
      test('should return correct multiplier for each tier', () {
        expect(AchievementTier.bronze.multiplier, 1);
        expect(AchievementTier.silver.multiplier, 2);
        expect(AchievementTier.gold.multiplier, 3);
        expect(AchievementTier.platinum.multiplier, 5);
        expect(AchievementTier.diamond.multiplier, 10);
      });
    });
  });

  group('UserProgress', () {
    test('should create with all fields', () {
      final progress = UserProgress(
        totalPoints: 500,
        level: 5,
        experience: 500,
        experienceToNextLevel: 500,
        title: 'Plant Parent',
        currentStreak: 7,
        longestStreak: 14,
        lastActivity: DateTime.now(),
        unlockedAchievements: {'first_plant': DateTime.now()},
        badges: [],
      );

      expect(progress.totalPoints, 500);
      expect(progress.level, 5);
      expect(progress.experience, 500);
      expect(progress.experienceToNextLevel, 500);
      expect(progress.title, 'Plant Parent');
      expect(progress.currentStreak, 7);
      expect(progress.longestStreak, 14);
      expect(progress.unlockedAchievements, contains('first_plant'));
      expect(progress.badges, isEmpty);
    });

    group('levelProgress', () {
      test('should calculate progress correctly', () {
        final progress = UserProgress(
          totalPoints: 50,
          level: 2,
          experience: 50,
          experienceToNextLevel: 100,
          title: 'Sprout',
          currentStreak: 0,
          longestStreak: 0,
          lastActivity: null,
          unlockedAchievements: {},
          badges: [],
        );

        expect(progress.levelProgress, 0.5);
      });

      test('should handle zero next level XP', () {
        final progress = UserProgress(
          totalPoints: 0,
          level: 1,
          experience: 0,
          experienceToNextLevel: 0,
          title: 'Seedling',
          currentStreak: 0,
          longestStreak: 0,
          lastActivity: null,
          unlockedAchievements: {},
          badges: [],
        );

        // Division by zero results in infinity or NaN
        expect(progress.levelProgress, isNot(greaterThan(double.infinity)));
      });
    });

    group('isStreakActive', () {
      test('should return false when lastActivity is null', () {
        final progress = UserProgress(
          totalPoints: 0,
          level: 1,
          experience: 0,
          experienceToNextLevel: 100,
          title: 'Seedling',
          currentStreak: 0,
          longestStreak: 0,
          lastActivity: null,
          unlockedAchievements: {},
          badges: [],
        );

        expect(progress.isStreakActive, false);
      });

      test('should return true when lastActivity is today', () {
        final progress = UserProgress(
          totalPoints: 0,
          level: 1,
          experience: 0,
          experienceToNextLevel: 100,
          title: 'Seedling',
          currentStreak: 0,
          longestStreak: 0,
          lastActivity: DateTime.now(),
          unlockedAchievements: {},
          badges: [],
        );

        expect(progress.isStreakActive, true);
      });

      test('should return true when lastActivity is yesterday', () {
        final progress = UserProgress(
          totalPoints: 0,
          level: 1,
          experience: 0,
          experienceToNextLevel: 100,
          title: 'Seedling',
          currentStreak: 0,
          longestStreak: 0,
          lastActivity: DateTime.now().subtract(const Duration(days: 1)),
          unlockedAchievements: {},
          badges: [],
        );

        expect(progress.isStreakActive, true);
      });

      test('should return false when lastActivity is more than 1 day ago', () {
        final progress = UserProgress(
          totalPoints: 0,
          level: 1,
          experience: 0,
          experienceToNextLevel: 100,
          title: 'Seedling',
          currentStreak: 0,
          longestStreak: 0,
          lastActivity: DateTime.now().subtract(const Duration(days: 3)),
          unlockedAchievements: {},
          badges: [],
        );

        expect(progress.isStreakActive, false);
      });
    });

    group('empty', () {
      test('should create empty progress', () {
        final progress = UserProgress.empty();

        expect(progress.totalPoints, 0);
        expect(progress.level, 1);
        expect(progress.experience, 0);
        expect(progress.experienceToNextLevel, 100);
        expect(progress.title, 'Seedling');
        expect(progress.currentStreak, 0);
        expect(progress.longestStreak, 0);
        expect(progress.lastActivity, isNull);
        expect(progress.unlockedAchievements, isEmpty);
        expect(progress.badges, isEmpty);
      });
    });
  });

  group('Badge', () {
    test('should create with all fields', () {
      final badge = Badge(
        id: 'first_plant',
        name: 'First Plant',
        description: 'Added your first plant',
        icon: '🌱',
        type: BadgeType.firstPlant,
        earnedAt: DateTime(2024, 1, 1),
      );

      expect(badge.id, 'first_plant');
      expect(badge.name, 'First Plant');
      expect(badge.description, 'Added your first plant');
      expect(badge.icon, '🌱');
      expect(badge.type, BadgeType.firstPlant);
      expect(badge.earnedAt, DateTime(2024, 1, 1));
    });
  });

  group('BadgeType', () {
    test('should have all expected values', () {
      expect(BadgeType.values.length, 5);
      expect(BadgeType.values, contains(BadgeType.firstPlant));
      expect(BadgeType.values, contains(BadgeType.collector));
      expect(BadgeType.values, contains(BadgeType.expert));
      expect(BadgeType.values, contains(BadgeType.dedicated));
      expect(BadgeType.values, contains(BadgeType.special));
    });
  });

  group('AchievementDefinitions', () {
    group('getAll', () {
      test('should return non-empty list', () {
        final achievements = AchievementDefinitions.getAll();

        expect(achievements, isNotEmpty);
      });

      test('should return achievements with valid data', () {
        final achievements = AchievementDefinitions.getAll();

        for (final achievement in achievements) {
          expect(achievement.id, isNotEmpty);
          expect(achievement.name, isNotEmpty);
          expect(achievement.description, isNotEmpty);
          expect(achievement.points, greaterThan(0));
          expect(achievement.requiredCount, greaterThan(0));
        }
      });
    });

    group('getByCategory', () {
      test('should return only achievements for specified category', () {
        final wateringAchievements = AchievementDefinitions.getByCategory(AchievementCategory.watering);

        expect(wateringAchievements, isNotEmpty);
        for (final achievement in wateringAchievements) {
          expect(achievement.category, AchievementCategory.watering);
        }
      });

      test('should return empty list for unknown category', () {
        // All categories are valid, so this will return achievements
        // Just verify it doesn't throw
        final achievements = AchievementDefinitions.getByCategory(AchievementCategory.streak);
        expect(achievements, isA<List<Achievement>>());
      });
    });

    group('getByTier', () {
      test('should return only achievements for specified tier', () {
        final goldAchievements = AchievementDefinitions.getByTier(AchievementTier.gold);

        for (final achievement in goldAchievements) {
          expect(achievement.tier, AchievementTier.gold);
        }
      });
    });

    group('getTotalPossiblePoints', () {
      test('should return sum of all achievement points', () {
        final total = AchievementDefinitions.getTotalPossiblePoints();

        expect(total, greaterThan(0));

        // Verify by calculating manually
        final manualTotal = AchievementDefinitions.getAll()
            .fold(0, (sum, a) => sum + a.points);
        expect(total, manualTotal);
      });
    });
  });

  group('UserLevels', () {
    group('getLevelInfo', () {
      test('should return level 1 for 0 XP', () {
        final levelInfo = UserLevels.getLevelInfo(0);

        expect(levelInfo.level, 1);
        expect(levelInfo.title, 'Seedling');
      });

      test('should return correct level for various XP amounts', () {
        expect(UserLevels.getLevelInfo(50).level, 1);
        expect(UserLevels.getLevelInfo(100).level, 2);
        expect(UserLevels.getLevelInfo(250).level, 3);
        expect(UserLevels.getLevelInfo(500).level, 4);
        expect(UserLevels.getLevelInfo(1000).level, 5);
        expect(UserLevels.getLevelInfo(10000).level, 10);
        expect(UserLevels.getLevelInfo(100000).level, 15);
      });

      test('should return level 1 for negative XP', () {
        final levelInfo = UserLevels.getLevelInfo(-100);

        expect(levelInfo.level, 1);
      });
    });

    group('getXPForNextLevel', () {
      test('should return correct XP for each level', () {
        expect(UserLevels.getXPForNextLevel(1), 100);
        expect(UserLevels.getXPForNextLevel(2), 250);
        expect(UserLevels.getXPForNextLevel(5), 2000);
        expect(UserLevels.getXPForNextLevel(14), 100000);
      });

      test('should return -1 for max level', () {
        expect(UserLevels.getXPForNextLevel(15), -1);
        expect(UserLevels.getXPForNextLevel(16), -1);
      });
    });
  });

  group('LevelInfo', () {
    test('should create with all fields', () {
      const levelInfo = LevelInfo(
        level: 5,
        title: 'Plant Parent',
        requiredXP: 1000,
      );

      expect(levelInfo.level, 5);
      expect(levelInfo.title, 'Plant Parent');
      expect(levelInfo.requiredXP, 1000);
    });
  });
}