/// Achievement model for gamification
class Achievement {
  final String id;
  final String name;
  final String description;
  final AchievementCategory category;
  final AchievementTier tier;
  final int requiredCount;
  final String icon;
  final int points;
  final DateTime? unlockedAt;
  final bool isUnlocked;

  Achievement({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.tier,
    required this.requiredCount,
    required this.icon,
    required this.points,
    this.unlockedAt,
    this.isUnlocked = false,
  });

  /// Get progress towards achievement (0.0 to 1.0)
  double getProgress(int currentCount) {
    if (isUnlocked) return 1.0;
    return (currentCount / requiredCount).clamp(0.0, 1.0);
  }

  /// Check if achievement is unlocked based on count
  bool checkUnlocked(int currentCount) {
    return currentCount >= requiredCount;
  }
}

enum AchievementCategory {
  watering,
  growth,
  collection,
  care,
  streak,
  knowledge,
  social,
  special,
}

enum AchievementTier {
  bronze,
  silver,
  gold,
  platinum,
  diamond,
}

extension AchievementTierExtension on AchievementTier {
  String get displayName {
    switch (this) {
      case AchievementTier.bronze:
        return 'Bronze';
      case AchievementTier.silver:
        return 'Silver';
      case AchievementTier.gold:
        return 'Gold';
      case AchievementTier.platinum:
        return 'Platinum';
      case AchievementTier.diamond:
        return 'Diamond';
    }
  }

  int get multiplier {
    switch (this) {
      case AchievementTier.bronze:
        return 1;
      case AchievementTier.silver:
        return 2;
      case AchievementTier.gold:
        return 3;
      case AchievementTier.platinum:
        return 5;
      case AchievementTier.diamond:
        return 10;
    }
  }
}

/// User progress and stats for gamification
class UserProgress {
  final int totalPoints;
  final int level;
  final int experience;
  final int experienceToNextLevel;
  final String title;
  final int currentStreak;
  final int longestStreak;
  final DateTime? lastActivity;
  final Map<String, DateTime> unlockedAchievements;
  final List<Badge> badges;

  UserProgress({
    required this.totalPoints,
    required this.level,
    required this.experience,
    required this.experienceToNextLevel,
    required this.title,
    required this.currentStreak,
    required this.longestStreak,
    required this.lastActivity,
    required this.unlockedAchievements,
    required this.badges,
  });

  double get levelProgress => experience / experienceToNextLevel;

  bool get isStreakActive {
    if (lastActivity == null) return false;
    return DateTime.now().difference(lastActivity!).inDays <= 1;
  }

  factory UserProgress.empty() {
    return UserProgress(
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
  }
}

/// Badge model
class Badge {
  final String id;
  final String name;
  final String description;
  final String icon;
  final BadgeType type;
  final DateTime earnedAt;

  Badge({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    required this.type,
    required this.earnedAt,
  });
}

enum BadgeType {
  firstPlant,
  collector,
  expert,
  dedicated,
  special,
}

/// Predefined achievements
class AchievementDefinitions {
  AchievementDefinitions._();

  static List<Achievement> getAll() => [
        // Watering achievements
        Achievement(
          id: 'water_first',
          name: 'First Sip',
          description: 'Water your first plant',
          category: AchievementCategory.watering,
          tier: AchievementTier.bronze,
          requiredCount: 1,
          icon: '💧',
          points: 10,
        ),
        Achievement(
          id: 'water_10',
          name: 'Hydration Station',
          description: 'Water plants 10 times',
          category: AchievementCategory.watering,
          tier: AchievementTier.bronze,
          requiredCount: 10,
          icon: '🚿',
          points: 25,
        ),
        Achievement(
          id: 'water_50',
          name: 'Plant Hydrator',
          description: 'Water plants 50 times',
          category: AchievementCategory.watering,
          tier: AchievementTier.silver,
          requiredCount: 50,
          icon: '🌊',
          points: 100,
        ),
        Achievement(
          id: 'water_100',
          name: 'Water Master',
          description: 'Water plants 100 times',
          category: AchievementCategory.watering,
          tier: AchievementTier.gold,
          requiredCount: 100,
          icon: '👑',
          points: 250,
        ),
        Achievement(
          id: 'water_500',
          name: 'Rain Maker',
          description: 'Water plants 500 times',
          category: AchievementCategory.watering,
          tier: AchievementTier.platinum,
          requiredCount: 500,
          icon: '🌧️',
          points: 1000,
        ),

        // Collection achievements
        Achievement(
          id: 'first_plant',
          name: 'New Parent',
          description: 'Add your first plant',
          category: AchievementCategory.collection,
          tier: AchievementTier.bronze,
          requiredCount: 1,
          icon: '🌱',
          points: 20,
        ),
        Achievement(
          id: 'collector_5',
          name: 'Plant Collector',
          description: 'Own 5 plants',
          category: AchievementCategory.collection,
          tier: AchievementTier.bronze,
          requiredCount: 5,
          icon: '🪴',
          points: 50,
        ),
        Achievement(
          id: 'collector_10',
          name: 'Urban Jungle',
          description: 'Own 10 plants',
          category: AchievementCategory.collection,
          tier: AchievementTier.silver,
          requiredCount: 10,
          icon: '🌿',
          points: 100,
        ),
        Achievement(
          id: 'collector_25',
          name: 'Plant Paradise',
          description: 'Own 25 plants',
          category: AchievementCategory.collection,
          tier: AchievementTier.gold,
          requiredCount: 25,
          icon: '🌳',
          points: 250,
        ),
        Achievement(
          id: 'collector_50',
          name: 'Botanical Garden',
          description: 'Own 50 plants',
          category: AchievementCategory.collection,
          tier: AchievementTier.platinum,
          requiredCount: 50,
          icon: '🏞️',
          points: 500,
        ),

        // Streak achievements
        Achievement(
          id: 'streak_3',
          name: 'Getting Started',
          description: '3 day care streak',
          category: AchievementCategory.streak,
          tier: AchievementTier.bronze,
          requiredCount: 3,
          icon: '🔥',
          points: 30,
        ),
        Achievement(
          id: 'streak_7',
          name: 'Dedicated Parent',
          description: '7 day care streak',
          category: AchievementCategory.streak,
          tier: AchievementTier.silver,
          requiredCount: 7,
          icon: '⭐',
          points: 75,
        ),
        Achievement(
          id: 'streak_30',
          name: 'Monthly Master',
          description: '30 day care streak',
          category: AchievementCategory.streak,
          tier: AchievementTier.gold,
          requiredCount: 30,
          icon: '🏆',
          points: 300,
        ),
        Achievement(
          id: 'streak_100',
          name: 'Unstoppable',
          description: '100 day care streak',
          category: AchievementCategory.streak,
          tier: AchievementTier.diamond,
          requiredCount: 100,
          icon: '💎',
          points: 1000,
        ),

        // Care achievements
        Achievement(
          id: 'growth_tracker',
          name: 'Growth Tracker',
          description: 'Record 10 growth entries',
          category: AchievementCategory.care,
          tier: AchievementTier.bronze,
          requiredCount: 10,
          icon: '📸',
          points: 25,
        ),
        Achievement(
          id: 'growth_50',
          name: 'Time Lapse',
          description: 'Record 50 growth entries',
          category: AchievementCategory.care,
          tier: AchievementTier.silver,
          requiredCount: 50,
          icon: '🎬',
          points: 100,
        ),
        Achievement(
          id: 'all_care_types',
          name: 'Complete Care',
          description: 'Perform all types of care tasks',
          category: AchievementCategory.care,
          tier: AchievementTier.silver,
          requiredCount: 1,
          icon: '✨',
          points: 150,
        ),

        // Knowledge achievements
        Achievement(
          id: 'species_3',
          name: 'Plant Student',
          description: 'Learn about 3 different plant species',
          category: AchievementCategory.knowledge,
          tier: AchievementTier.bronze,
          requiredCount: 3,
          icon: '📚',
          points: 30,
        ),
        Achievement(
          id: 'species_10',
          name: 'Plant Scholar',
          description: 'Learn about 10 different plant species',
          category: AchievementCategory.knowledge,
          tier: AchievementTier.silver,
          requiredCount: 10,
          icon: '🎓',
          points: 100,
        ),
        Achievement(
          id: 'species_25',
          name: 'Botanist',
          description: 'Learn about 25 different plant species',
          category: AchievementCategory.knowledge,
          tier: AchievementTier.gold,
          requiredCount: 25,
          icon: '🔬',
          points: 250,
        ),

        // Special achievements
        Achievement(
          id: 'perfect_week',
          name: 'Perfect Week',
          description: 'Complete all care tasks for 7 days straight',
          category: AchievementCategory.special,
          tier: AchievementTier.gold,
          requiredCount: 1,
          icon: '🌟',
          points: 500,
        ),
        Achievement(
          id: 'survivor',
          name: 'Survivor',
          description: 'Keep a plant alive for 1 year',
          category: AchievementCategory.special,
          tier: AchievementTier.diamond,
          requiredCount: 365,
          icon: '🎉',
          points: 1000,
        ),
        Achievement(
          id: 'propagation_master',
          name: 'Propagation Master',
          description: 'Successfully propagate 5 plants',
          category: AchievementCategory.special,
          tier: AchievementTier.gold,
          requiredCount: 5,
          icon: '🌿',
          points: 200,
        ),
      ];

  static List<Achievement> getByCategory(AchievementCategory category) {
    return getAll().where((a) => a.category == category).toList();
  }

  static List<Achievement> getByTier(AchievementTier tier) {
    return getAll().where((a) => a.tier == tier).toList();
  }

  static int getTotalPossiblePoints() {
    return getAll().fold(0, (sum, a) => sum + a.points);
  }
}

/// User levels and titles
class UserLevels {
  static const levels = [
    LevelInfo(level: 1, title: 'Seedling', requiredXP: 0),
    LevelInfo(level: 2, title: 'Sprout', requiredXP: 100),
    LevelInfo(level: 3, title: 'Sapling', requiredXP: 250),
    LevelInfo(level: 4, title: 'Gardener', requiredXP: 500),
    LevelInfo(level: 5, title: 'Plant Parent', requiredXP: 1000),
    LevelInfo(level: 6, title: 'Green Thumb', requiredXP: 2000),
    LevelInfo(level: 7, title: 'Plant Expert', requiredXP: 3500),
    LevelInfo(level: 8, title: 'Master Gardener', requiredXP: 5000),
    LevelInfo(level: 9, title: 'Botanist', requiredXP: 7500),
    LevelInfo(level: 10, title: 'Plant Whisperer', requiredXP: 10000),
    LevelInfo(level: 11, title: 'Nature Guardian', requiredXP: 15000),
    LevelInfo(level: 12, title: 'Eco Warrior', requiredXP: 20000),
    LevelInfo(level: 13, title: 'Plant Legend', requiredXP: 30000),
    LevelInfo(level: 14, title: 'Garden Sage', requiredXP: 50000),
    LevelInfo(level: 15, title: 'Plant Deity', requiredXP: 100000),
  ];

  static LevelInfo getLevelInfo(int xp) {
    for (int i = levels.length - 1; i >= 0; i--) {
      if (xp >= levels[i].requiredXP) {
        return levels[i];
      }
    }
    return levels.first;
  }

  static int getXPForNextLevel(int currentLevel) {
    if (currentLevel >= levels.length) return -1;
    return levels[currentLevel].requiredXP;
  }
}

class LevelInfo {
  final int level;
  final String title;
  final int requiredXP;

  const LevelInfo({
    required this.level,
    required this.title,
    required this.requiredXP,
  });
}