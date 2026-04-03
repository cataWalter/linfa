import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../data/models/achievement.dart';
import '../../data/models/plant.dart';

/// Statistics tracking model
class PlantStats {
  final int totalWaterings;
  final int totalFertilizations;
  final int totalGrowthEntries;
  final int totalRemindersCompleted;
  final Map<String, int> careTypesCompleted;
  final Set<String> uniqueSpecies;
  final DateTime? firstPlantDate;
  final int plantsEverOwned;
  final int plantsCurrentlyOwned;

  PlantStats({
    required this.totalWaterings,
    required this.totalFertilizations,
    required this.totalGrowthEntries,
    required this.totalRemindersCompleted,
    required this.careTypesCompleted,
    required this.uniqueSpecies,
    this.firstPlantDate,
    required this.plantsEverOwned,
    required this.plantsCurrentlyOwned,
  });

  factory PlantStats.empty() {
    return PlantStats(
      totalWaterings: 0,
      totalFertilizations: 0,
      totalGrowthEntries: 0,
      totalRemindersCompleted: 0,
      careTypesCompleted: {},
      uniqueSpecies: {},
      plantsEverOwned: 0,
      plantsCurrentlyOwned: 0,
    );
  }
}

/// Gamification notifier
class GamificationNotifier extends StateNotifier<UserProgress> {
  GamificationNotifier() : super(UserProgress.empty()) {
    _init();
  }

  late Box _statsBox;
  PlantStats _stats = PlantStats.empty();

  static const String _boxName = 'gamification_stats';
  static const String _achievementsKey = 'unlocked_achievements';
  static const String _pointsKey = 'total_points';
  static const String _streakKey = 'current_streak';
  static const String _longestStreakKey = 'longest_streak';
  static const String _lastActivityKey = 'last_activity';
  static const String _statsKey = 'plant_stats';

  Future<void> _init() async {
    _statsBox = await Hive.openBox(_boxName);
    await _loadProgress();
  }

  Future<void> _loadProgress() async {
    final unlockedAchievements = Map<String, DateTime>.from(
      (_statsBox.get(_achievementsKey, defaultValue: {}) as Map?)
              ?.map((key, value) => MapEntry(key, DateTime.parse(value))) ??
          {},
    );

    final totalPoints = _statsBox.get(_pointsKey, defaultValue: 0) as int;
    final currentStreak = _statsBox.get(_streakKey, defaultValue: 0) as int;
    final longestStreak =
        _statsBox.get(_longestStreakKey, defaultValue: 0) as int;
    final lastActivityStr = _statsBox.get(_lastActivityKey) as String?;

    final levelInfo = UserLevels.getLevelInfo(totalPoints);

    state = UserProgress(
      totalPoints: totalPoints,
      level: levelInfo.level,
      experience: totalPoints,
      experienceToNextLevel: UserLevels.getXPForNextLevel(levelInfo.level),
      title: levelInfo.title,
      currentStreak: currentStreak,
      longestStreak: longestStreak,
      lastActivity:
          lastActivityStr != null ? DateTime.parse(lastActivityStr) : null,
      unlockedAchievements: unlockedAchievements,
      badges: [],
    );
  }

  /// Record a watering action
  Future<void> recordWatering() async {
    _stats = PlantStats(
      totalWaterings: _stats.totalWaterings + 1,
      totalFertilizations: _stats.totalFertilizations,
      totalGrowthEntries: _stats.totalGrowthEntries,
      totalRemindersCompleted: _stats.totalRemindersCompleted,
      careTypesCompleted: {
        ..._stats.careTypesCompleted,
        'watering': (_stats.careTypesCompleted['watering'] ?? 0) + 1,
      },
      uniqueSpecies: _stats.uniqueSpecies,
      plantsEverOwned: _stats.plantsEverOwned,
      plantsCurrentlyOwned: _stats.plantsCurrentlyOwned,
    );

    await _addPoints(10);
    await _updateStreak();
    await _checkAchievements();
  }

  /// Record a fertilizing action
  Future<void> recordFertilizing() async {
    _stats = PlantStats(
      totalWaterings: _stats.totalWaterings,
      totalFertilizations: _stats.totalFertilizations + 1,
      totalGrowthEntries: _stats.totalGrowthEntries,
      totalRemindersCompleted: _stats.totalRemindersCompleted,
      careTypesCompleted: {
        ..._stats.careTypesCompleted,
        'fertilizing': (_stats.careTypesCompleted['fertilizing'] ?? 0) + 1,
      },
      uniqueSpecies: _stats.uniqueSpecies,
      plantsEverOwned: _stats.plantsEverOwned,
      plantsCurrentlyOwned: _stats.plantsCurrentlyOwned,
    );

    await _addPoints(15);
    await _updateStreak();
    await _checkAchievements();
  }

  /// Record a growth entry
  Future<void> recordGrowthEntry() async {
    _stats = PlantStats(
      totalWaterings: _stats.totalWaterings,
      totalFertilizations: _stats.totalFertilizations,
      totalGrowthEntries: _stats.totalGrowthEntries + 1,
      totalRemindersCompleted: _stats.totalRemindersCompleted,
      careTypesCompleted: {
        ..._stats.careTypesCompleted,
        'growth': (_stats.careTypesCompleted['growth'] ?? 0) + 1,
      },
      uniqueSpecies: _stats.uniqueSpecies,
      plantsEverOwned: _stats.plantsEverOwned,
      plantsCurrentlyOwned: _stats.plantsCurrentlyOwned,
    );

    await _addPoints(20);
    await _updateStreak();
    await _checkAchievements();
  }

  /// Record adding a new plant
  Future<void> recordNewPlant(Plant plant) async {
    _stats = PlantStats(
      totalWaterings: _stats.totalWaterings,
      totalFertilizations: _stats.totalFertilizations,
      totalGrowthEntries: _stats.totalGrowthEntries,
      totalRemindersCompleted: _stats.totalRemindersCompleted,
      careTypesCompleted: Map.from(_stats.careTypesCompleted),
      uniqueSpecies: {
        ..._stats.uniqueSpecies,
        if (plant.species != null) plant.species!,
      },
      plantsEverOwned: _stats.plantsEverOwned + 1,
      plantsCurrentlyOwned: _stats.plantsCurrentlyOwned + 1,
      firstPlantDate: _stats.firstPlantDate ?? DateTime.now(),
    );

    await _addPoints(25);
    await _updateStreak();
    await _checkAchievements();
  }

  /// Add points and update level
  Future<void> _addPoints(int points) async {
    final newTotal = state.totalPoints + points;
    final levelInfo = UserLevels.getLevelInfo(newTotal);
    final nextLevelXP = UserLevels.getXPForNextLevel(levelInfo.level);

    state = UserProgress(
      totalPoints: newTotal,
      level: levelInfo.level,
      experience: newTotal,
      experienceToNextLevel: nextLevelXP > 0 ? nextLevelXP - newTotal : 0,
      title: levelInfo.title,
      currentStreak: state.currentStreak,
      longestStreak: state.longestStreak,
      lastActivity: state.lastActivity,
      unlockedAchievements: state.unlockedAchievements,
      badges: state.badges,
    );

    await _statsBox.put(_pointsKey, newTotal);
  }

  /// Update streak
  Future<void> _updateStreak() async {
    final now = DateTime.now();
    final lastActivity = state.lastActivity;

    int newStreak;
    if (lastActivity == null) {
      newStreak = 1;
    } else {
      final daysDiff = now.difference(lastActivity).inDays;
      if (daysDiff == 0) {
        newStreak = state.currentStreak; // Same day, no change
      } else if (daysDiff == 1) {
        newStreak = state.currentStreak + 1; // Consecutive day
      } else {
        newStreak = 1; // Streak broken
      }
    }

    final newLongestStreak =
        newStreak > state.longestStreak ? newStreak : state.longestStreak;

    state = UserProgress(
      totalPoints: state.totalPoints,
      level: state.level,
      experience: state.experience,
      experienceToNextLevel: state.experienceToNextLevel,
      title: state.title,
      currentStreak: newStreak,
      longestStreak: newLongestStreak,
      lastActivity: now,
      unlockedAchievements: state.unlockedAchievements,
      badges: state.badges,
    );

    await _statsBox.put(_streakKey, newStreak);
    await _statsBox.put(_longestStreakKey, newLongestStreak);
    await _statsBox.put(_lastActivityKey, now.toIso8601String());
  }

  /// Check and unlock achievements
  Future<List<Achievement>> _checkAchievements() async {
    final newlyUnlocked = <Achievement>[];
    final allAchievements = AchievementDefinitions.getAll();

    for (final achievement in allAchievements) {
      if (state.unlockedAchievements.containsKey(achievement.id)) continue;

      int currentCount = 0;
      switch (achievement.category) {
        case AchievementCategory.watering:
          currentCount = _stats.totalWaterings;
          break;
        case AchievementCategory.growth:
          currentCount = _stats.totalGrowthEntries;
          break;
        case AchievementCategory.collection:
          currentCount = _stats.plantsCurrentlyOwned;
          break;
        case AchievementCategory.streak:
          currentCount = state.currentStreak;
          break;
        case AchievementCategory.knowledge:
          currentCount = _stats.uniqueSpecies.length;
          break;
        case AchievementCategory.care:
          if (achievement.id == 'all_care_types') {
            currentCount = _stats.careTypesCompleted.length >= 4 ? 1 : 0;
          } else {
            currentCount = _stats.totalRemindersCompleted;
          }
          break;
        case AchievementCategory.social:
        case AchievementCategory.special:
          if (achievement.id == 'survivor' && _stats.firstPlantDate != null) {
            currentCount =
                DateTime.now().difference(_stats.firstPlantDate!).inDays;
          }
          break;
      }

      if (achievement.checkUnlocked(currentCount)) {
        newlyUnlocked.add(achievement);
        state.unlockedAchievements[achievement.id] = DateTime.now();

        // Award bonus points for achievement
        await _addPoints(achievement.points);
      }
    }

    await _statsBox.put(
      _achievementsKey,
      state.unlockedAchievements
          .map((key, value) => MapEntry(key, value.toIso8601String())),
    );

    return newlyUnlocked;
  }

  /// Get current stats
  PlantStats get stats => _stats;

  /// Get all achievements with progress
  List<Map<String, dynamic>> getAchievementsWithProgress() {
    return AchievementDefinitions.getAll().map((achievement) {
      int currentCount = 0;
      switch (achievement.category) {
        case AchievementCategory.watering:
          currentCount = _stats.totalWaterings;
          break;
        case AchievementCategory.growth:
          currentCount = _stats.totalGrowthEntries;
          break;
        case AchievementCategory.collection:
          currentCount = _stats.plantsCurrentlyOwned;
          break;
        case AchievementCategory.streak:
          currentCount = state.currentStreak;
          break;
        case AchievementCategory.knowledge:
          currentCount = _stats.uniqueSpecies.length;
          break;
        case AchievementCategory.care:
          currentCount = _stats.totalRemindersCompleted;
          break;
        default:
          currentCount = 0;
      }

      return {
        'achievement': achievement,
        'progress': achievement.getProgress(currentCount),
        'currentCount': currentCount,
        'isUnlocked': state.unlockedAchievements.containsKey(achievement.id),
      };
    }).toList()
      ..sort((a, b) {
        final aUnlocked = a['isUnlocked'] as bool;
        final bUnlocked = b['isUnlocked'] as bool;
        if (aUnlocked != bUnlocked) return bUnlocked.compareTo(aUnlocked);
        return (b['progress'] as num).compareTo(a['progress'] as num);
      });
  }

  /// Reset all gamification data (for testing)
  Future<void> reset() async {
    await _statsBox.clear();
    _stats = PlantStats.empty();
    state = UserProgress.empty();
  }
}

final gamificationProvider =
    StateNotifierProvider<GamificationNotifier, UserProgress>((ref) {
  return GamificationNotifier();
});

final achievementsProvider =
    FutureProvider<List<Map<String, dynamic>>>((ref) async {
  // This will be populated by the gamification provider
  return [];
});