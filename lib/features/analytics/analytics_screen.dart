import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/strings.dart';
import '../../core/theme/typography.dart';
import '../../shared/providers/plant_provider.dart';
import '../../shared/providers/gamification_provider.dart';
import '../../core/services/weather_service.dart';
import 'dart:math' as math;

/// Advanced Analytics Screen with comprehensive plant care insights
class AnalyticsScreen extends ConsumerStatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  ConsumerState<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends ConsumerState<AnalyticsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Header
          SliverToBoxAdapter(
            child: _buildHeader(context),
          ),

          // Tab Bar
          SliverToBoxAdapter(
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              tabs: const [
                Tab(text: 'Overview'),
                Tab(text: 'Care Stats'),
                Tab(text: 'Achievements'),
                Tab(text: 'Trends'),
              ],
            ),
          ),

          // Tab Content
          SliverFillRemaining(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildOverviewTab(context),
                _buildCareStatsTab(context),
                _buildAchievementsTab(context),
                _buildTrendsTab(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final userProgress = ref.watch(gamificationProvider);

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 60, 20, 24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.primaryContainer,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(Icons.analytics, color: Colors.white, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Analytics',
                      style: LinfaTypography.getHeadlineSmall().copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      userProgress.title,
                      style: LinfaTypography.getBodyMedium().copyWith(
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildLevelProgressBar(context, userProgress),
        ],
      ),
    );
  }

  Widget _buildLevelProgressBar(BuildContext context, UserProgress progress) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Level ${progress.level}',
              style: LinfaTypography.getLabelMedium().copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '${progress.totalPoints} XP',
              style: LinfaTypography.getLabelMedium().copyWith(
                color: Colors.white.withOpacity(0.9),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: progress.levelProgress,
            backgroundColor: Colors.white.withOpacity(0.3),
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
            minHeight: 8,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '${progress.experienceToNextLevel} XP to next level',
          style: LinfaTypography.getLabelSmall().copyWith(
            color: Colors.white.withOpacity(0.7),
          ),
        ),
      ],
    );
  }

  Widget _buildOverviewTab(BuildContext context) {
    final userProgress = ref.watch(gamificationProvider);
    final plantsAsync = ref.watch(plantsProvider);
    final plants = plantsAsync.valueOrNull ?? [];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Stats Grid
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 1.2,
            children: [
              _StatCard(
                icon: Icons.eco,
                label: 'Total Plants',
                value: plants.length.toString(),
                color: LinfaColors.primary,
              ),
              _StatCard(
                icon: Icons.local_fire_department,
                label: 'Current Streak',
                value: '${userProgress.currentStreak} days',
                color: LinfaColors.warning,
              ),
              _StatCard(
                icon: Icons.emoji_events,
                label: 'Achievements',
                value: userProgress.unlockedAchievements.length.toString(),
                color: LinfaColors.accent,
                subtitle: '/${AchievementDefinitions.getAll().length}',
              ),
              _StatCard(
                icon: Icons.calendar_today,
                label: 'Longest Streak',
                value: '${userProgress.longestStreak} days',
                color: LinfaColors.healthy,
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Weather Recommendations
          _buildWeatherSection(context),

          const SizedBox(height: 24),

          // Quick Stats
          _buildQuickStatsSection(context, plants),
        ],
      ),
    );
  }

  Widget _buildWeatherSection(BuildContext context) {
    return FutureBuilder<List<WeatherCareRecommendation>>(
      future: WeatherService.instance.getCareRecommendations(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const _LoadingCard();
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const SizedBox.shrink();
        }

        final recommendations = snapshot.data!;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Weather Insights',
              style: LinfaTypography.getTitleLarge(),
            ),
            const SizedBox(height: 12),
            ...recommendations.take(3).map((rec) => _WeatherCard(
                  title: rec.title,
                  description: rec.description,
                  type: rec.type,
                )),
          ],
        );
      },
    );
  }

  Widget _buildQuickStatsSection(BuildContext context, List<dynamic> plants) {
    final gamification = ref.watch(gamificationProvider);
    final stats = gamification.notifier.stats;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Care Activity',
          style: LinfaTypography.getTitleLarge(),
        ),
        const SizedBox(height: 12),
        _buildStatRow('Total Waterings', stats.totalWaterings, LinfaColors.watering),
        _buildStatRow('Total Growth Entries', stats.totalGrowthEntries, LinfaColors.primary),
        _buildStatRow('Unique Species', stats.uniqueSpecies.length, LinfaColors.accent),
      ],
    );
  }

  Widget _buildStatRow(String label, int value, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 40,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              label,
              style: LinfaTypography.getBodyLarge(),
            ),
          ),
          Text(
            value.toString(),
            style: LinfaTypography.getTitleLarge().copyWith(color: color),
          ),
        ],
      ),
    );
  }

  Widget _buildCareStatsTab(BuildContext context) {
    final gamification = ref.watch(gamificationProvider);
    final stats = gamification.notifier.stats;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCareTypeCard(
            context,
            'Watering',
            stats.totalWaterings,
            Icons.water_drop,
            LinfaColors.watering,
            'times',
          ),
          const SizedBox(height: 16),
          _buildCareTypeCard(
            context,
            'Fertilizing',
            stats.totalFertilizations,
            Icons.yard,
            LinfaColors.fertilizing,
            'times',
          ),
          const SizedBox(height: 16),
          _buildCareTypeCard(
            context,
            'Growth Tracking',
            stats.totalGrowthEntries,
            Icons.photo_camera,
            LinfaColors.primary,
            'entries',
          ),
          const SizedBox(height: 24),

          // Care Distribution Chart
          Text(
            'Care Distribution',
            style: LinfaTypography.getTitleLarge(),
          ),
          const SizedBox(height: 16),
          _buildCareDistributionChart(stats),
        ],
      ),
    );
  }

  Widget _buildCareTypeCard(
    BuildContext context,
    String title,
    int count,
    IconData icon,
    Color color,
    String unit,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: color, size: 32),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: LinfaTypography.getTitleMedium(),
                ),
                const SizedBox(height: 4),
                Text(
                  '$count $unit',
                  style: LinfaTypography.getDisplaySmall().copyWith(
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn().slideX(begin: -0.1);
  }

  Widget _buildCareDistributionChart(PlantStats stats) {
    final total = stats.totalWaterings +
        stats.totalFertilizations +
        stats.totalGrowthEntries +
        1; // Avoid division by zero

    final waterPercent = stats.totalWaterings / total;
    final fertilizerPercent = stats.totalFertilizations / total;
    final growthPercent = stats.totalGrowthEntries / total;

    return Column(
      children: [
        _buildChartSegment('Watering', waterPercent, LinfaColors.watering),
        const SizedBox(height: 8),
        _buildChartSegment('Fertilizing', fertilizerPercent, LinfaColors.fertilizing),
        const SizedBox(height: 8),
        _buildChartSegment('Growth Tracking', growthPercent, LinfaColors.primary),
      ],
    );
  }

  Widget _buildChartSegment(String label, double percent, Color color) {
    return Row(
      children: [
        SizedBox(
          width: 100,
          child: Text(label, style: LinfaTypography.getLabelMedium()),
        ),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: math.min(percent * 2, 1.0),
              backgroundColor: color.withOpacity(0.2),
              valueColor: AlwaysStoppedAnimation<Color>(color),
              minHeight: 20,
            ),
          ),
        ),
        const SizedBox(width: 12),
        SizedBox(
          width: 50,
          child: Text(
            '${(percent * 100).toInt()}%',
            style: LinfaTypography.getLabelMedium().copyWith(color: color),
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }

  Widget _buildAchievementsTab(BuildContext context) {
    final gamification = ref.watch(gamificationProvider);
    final achievements = gamification.notifier.getAchievementsWithProgress();

    // Group by category
    final categories = AchievementCategory.values;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Summary
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  LinfaColors.primary,
                  LinfaColors.primaryLight,
                ],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                const Icon(Icons.emoji_events, color: Colors.white, size: 40),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${achievements.where((a) => a['isUnlocked'] as bool).length} / ${AchievementDefinitions.getAll().length}',
                        style: LinfaTypography.getDisplaySmall().copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Achievements Unlocked',
                        style: LinfaTypography.getBodyMedium().copyWith(
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Achievements by category
          ...categories.map((category) {
            final categoryAchievements = achievements
                .where((a) => (a['achievement'] as Achievement).category == category)
                .toList();

            if (categoryAchievements.isEmpty) return const SizedBox.shrink();

            return Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _getCategoryName(category),
                    style: LinfaTypography.getTitleMedium(),
                  ),
                  const SizedBox(height: 12),
                  ...categoryAchievements.map((data) => _AchievementCard(
                        achievement: data['achievement'] as Achievement,
                        progress: data['progress'] as double,
                        isUnlocked: data['isUnlocked'] as bool,
                        currentCount: data['currentCount'] as int,
                      )),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  String _getCategoryName(AchievementCategory category) {
    switch (category) {
      case AchievementCategory.watering:
        return '💧 Watering';
      case AchievementCategory.growth:
        return '📈 Growth';
      case AchievementCategory.collection:
        return '🌿 Collection';
      case AchievementCategory.care:
        return '✨ Care';
      case AchievementCategory.streak:
        return '🔥 Streaks';
      case AchievementCategory.knowledge:
        return '📚 Knowledge';
      case AchievementCategory.social:
        return '🤝 Social';
      case AchievementCategory.special:
        return '🌟 Special';
    }
  }

  Widget _buildTrendsTab(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Placeholder for future trend analysis
          Container(
            padding: const EdgeInsets.all(40),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.show_chart,
                  size: 64,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(height: 16),
                Text(
                  'Trends Coming Soon',
                  style: LinfaTypography.getTitleLarge(),
                ),
                const SizedBox(height: 8),
                Text(
                  'Track your plant care patterns over time',
                  style: LinfaTypography.getBodyMedium().copyWith(
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;
  final String? subtitle;

  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 12),
          Text(
            value,
            style: LinfaTypography.getDisplaySmall().copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Expanded(
                child: Text(
                  label,
                  style: LinfaTypography.getLabelSmall().copyWith(
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                  ),
                ),
              ),
              if (subtitle != null)
                Text(
                  subtitle!,
                  style: LinfaTypography.getLabelSmall().copyWith(
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.4),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _WeatherCard extends StatelessWidget {
  final String title;
  final String description;
  final RecommendationType type;

  const _WeatherCard({
    required this.title,
    required this.description,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    final color = _getTypeColor();

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(_getTypeIcon(), color: color, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: LinfaTypography.getLabelLarge().copyWith(
                    color: color,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: LinfaTypography.getBodySmall().copyWith(
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getTypeColor() {
    switch (type) {
      case RecommendationType.watering:
        return LinfaColors.watering;
      case RecommendationType.humidity:
        return LinfaColors.accent;
      case RecommendationType.light:
        return Colors.amber;
      case RecommendationType.temperature:
        return Colors.orange;
      case RecommendationType.protection:
        return LinfaColors.danger;
      case RecommendationType.fertilizing:
        return LinfaColors.fertilizing;
    }
  }

  IconData _getTypeIcon() {
    switch (type) {
      case RecommendationType.watering:
        return Icons.water_drop;
      case RecommendationType.humidity:
        return Icons.air;
      case RecommendationType.light:
        return Icons.light_mode;
      case RecommendationType.temperature:
        return Icons.thermostat;
      case RecommendationType.protection:
        return Icons.shield;
      case RecommendationType.fertilizing:
        return Icons.yard;
    }
  }
}

class _AchievementCard extends StatelessWidget {
  final Achievement achievement;
  final double progress;
  final bool isUnlocked;
  final int currentCount;

  const _AchievementCard({
    required this.achievement,
    required this.progress,
    required this.isUnlocked,
    required this.currentCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isUnlocked
            ? _getTierColor().withOpacity(0.1)
            : Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isUnlocked ? _getTierColor().withOpacity(0.3) : Colors.transparent,
        ),
      ),
      child: Row(
        children: [
          Text(
            achievement.icon,
            style: const TextStyle(fontSize: 32),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      achievement.name,
                      style: LinfaTypography.getLabelLarge().copyWith(
                        color: isUnlocked ? _getTierColor() : null,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (isUnlocked) ...[
                      const SizedBox(width: 8),
                      const Icon(Icons.check_circle, size: 16, color: LinfaColors.healthy),
                    ],
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  achievement.description,
                  style: LinfaTypography.getBodySmall().copyWith(
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                  ),
                ),
                if (!isUnlocked) ...[
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: progress,
                      backgroundColor: _getTierColor().withOpacity(0.2),
                      valueColor: AlwaysStoppedAnimation<Color>(_getTierColor()),
                      minHeight: 6,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$currentCount / ${achievement.requiredCount}',
                    style: LinfaTypography.getLabelSmall().copyWith(
                      color: _getTierColor(),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getTierColor() {
    switch (achievement.tier) {
      case AchievementTier.bronze:
        return const Color(0xFFCD7F32);
      case AchievementTier.silver:
        return const Color(0xFFC0C0C0);
      case AchievementTier.gold:
        return const Color(0xFFFFD700);
      case AchievementTier.platinum:
        return const Color(0xFFE5E4E2);
      case AchievementTier.diamond:
        return const Color(0xFFB9F2FF);
    }
  }
}

class _LoadingCard extends StatelessWidget {
  const _LoadingCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Center(child: CircularProgressIndicator()),
    );
  }
}