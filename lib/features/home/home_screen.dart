import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/strings.dart';
import '../../core/constants/routes.dart';
import '../../core/theme/typography.dart';
import '../../core/utils/date.dart';
import '../../data/models/plant.dart';
import '../../shared/providers/plant_provider.dart';
import '../../shared/providers/reminder_provider.dart';
import '../../shared/widgets/empty_state.dart';
import 'widgets/plant_card.dart';
import 'widgets/upcoming_reminders.dart';

final plantHealthSummaryProvider =
    FutureProvider<Map<String, int>>((ref) async {
  final plantsAsync = ref.watch(plantsProvider);
  final plants = plantsAsync.valueOrNull ?? [];
  final summary = <String, int>{
    'healthy': 0,
    'needsAttention': 0,
    'critical': 0,
  };

  for (final plant in plants) {
    final daysSinceWater = plant.lastWatered != null
        ? DateTime.now().difference(plant.lastWatered!).inDays
        : 999;

    if (daysSinceWater > 14) {
      summary['critical'] = (summary['critical'] ?? 0) + 1;
    } else if (daysSinceWater > 7) {
      summary['needsAttention'] = (summary['needsAttention'] ?? 0) + 1;
    } else {
      summary['healthy'] = (summary['healthy'] ?? 0) + 1;
    }
  }

  return summary;
});

final plantRoomsProvider = FutureProvider<List<String>>((ref) async {
  final repository = ref.watch(plantRepositoryProvider);
  return repository.getAllRooms();
});

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with SingleTickerProviderStateMixin {
  bool _isRefreshing = false;

  Future<void> _onRefresh() async {
    if (_isRefreshing) return;
    setState(() => _isRefreshing = true);
    try {
      ref.invalidate(plantsProvider);
      ref.invalidate(upcomingRemindersProvider);
      ref.invalidate(plantCountProvider);
      ref.invalidate(plantsNeedingWaterProvider);
      ref.invalidate(plantHealthSummaryProvider);
      await Future.delayed(const Duration(milliseconds: 800));
    } finally {
      if (mounted) {
        setState(() => _isRefreshing = false);
      }
    }
  }

  void _showQuickWaterDialog(List<Plant> plants) {
    showDialog(
      context: context,
      builder: (context) => _QuickWaterAllDialog(plants: plants, ref: ref),
    );
  }

  void _showAnalytics() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const _AnalyticsBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final plantsAsync = ref.watch(plantsProvider);
    final upcomingAsync = ref.watch(upcomingRemindersProvider);
    final countAsync = ref.watch(plantCountProvider);
    final needsWaterAsync = ref.watch(plantsNeedingWaterProvider);
    final healthSummaryAsync = ref.watch(plantHealthSummaryProvider);

    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _onRefresh,
          color: LinfaColors.primary,
          backgroundColor: Theme.of(context).colorScheme.surface,
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            slivers: [
              SliverToBoxAdapter(
                child: _buildHeader(context, needsWaterAsync),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      countAsync.when(
                        data: (count) => _HealthSummaryCard(
                          totalPlants: count,
                          healthSummary: healthSummaryAsync.valueOrNull,
                        ),
                        loading: () => const _StatsCardSkeleton(),
                        error: (_, __) => const SizedBox.shrink(),
                      ),
                      const SizedBox(height: 16),
                      _buildQuickActions(
                          context, plantsAsync.valueOrNull ?? []),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppStrings.upcomingReminders,
                        style: LinfaTypography.getTitleLarge(),
                      ),
                      TextButton(
                        onPressed: () {
                          context.go(AppRoutes.home);
                        },
                        child: const Text('Vedi tutti'),
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: upcomingAsync.when(
                    data: (reminders) =>
                        UpcomingRemindersWidget(reminders: reminders),
                    loading: () => _buildRemindersSkeleton(),
                    error: (_, __) => const SizedBox.shrink(),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppStrings.myPlants,
                        style: LinfaTypography.getTitleLarge(),
                      ),
                      TextButton.icon(
                        onPressed: () => context.push(AppRoutes.addPlant),
                        icon: const Icon(Icons.add, size: 18),
                        label: const Text(AppStrings.add),
                      ),
                    ],
                  ),
                ),
              ),
              plantsAsync.when(
                data: (plants) {
                  if (plants.isEmpty) {
                    return SliverToBoxAdapter(
                      child: EmptyState(
                        icon: Icons.eco_outlined,
                        title: AppStrings.noPlants,
                        message: AppStrings.addFirstPlant,
                        actionLabel: AppStrings.addPlant,
                        onAction: () => context.push(AppRoutes.addPlant),
                      ),
                    );
                  }
                  return SliverPadding(
                    padding: const EdgeInsets.all(20),
                    sliver: SliverGrid(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 0.8,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final plant = plants[index];
                          return PlantCard(plant: plant)
                              .animate()
                              .fadeIn()
                              .scale(
                                begin: const Offset(0.95, 0.95),
                                duration: const Duration(milliseconds: 350),
                                delay: Duration(milliseconds: index * 80),
                                curve: Curves.easeOutCubic,
                              );
                        },
                        childCount: plants.length,
                      ),
                    ),
                  );
                },
                loading: () => const SliverToBoxAdapter(
                  child: Center(child: CircularProgressIndicator()),
                ),
                error: (e, _) => SliverToBoxAdapter(
                  child: Center(
                    child: Column(
                      children: [
                        const Icon(Icons.error_outline,
                            size: 48, color: LinfaColors.danger),
                        const SizedBox(height: 16),
                        Text('Errore: $e'),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: _onRefresh,
                          child: const Text(AppStrings.retry),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(height: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(
      BuildContext context, AsyncValue<List<Plant>> needsWaterAsync) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LinfaDateUtils.getGreeting(),
                      style: LinfaTypography.getDisplaySmall().copyWith(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ).animate().fadeIn(duration: 400.ms).slideX(begin: -0.1),
                    const SizedBox(height: 4),
                    Text(
                      AppStrings.appTagline,
                      style: LinfaTypography.getBodyMedium().copyWith(
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withOpacity(0.6),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ).animate().fadeIn(delay: 100.ms, duration: 400.ms),
                  ],
                ),
              ),
              Stack(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    child: IconButton(
                      icon: Icon(
                        Icons.notifications_outlined,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                      onPressed: () {
                        context.go(AppRoutes.home);
                      },
                    ),
                  ),
                  needsWaterAsync.when(
                    data: (plants) {
                      if (plants.isEmpty) return const SizedBox.shrink();
                      return Positioned(
                        right: 8,
                        top: 8,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: LinfaColors.danger,
                            shape: BoxShape.circle,
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 16,
                            minHeight: 16,
                          ),
                          child: Text(
                            plants.length > 9 ? '9+' : '${plants.length}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ).animate(onPlay: (c) => c.repeat(reverse: true)).scale(
                            begin: const Offset(1, 1),
                            end: const Offset(1.1, 1.1),
                            duration: 1.seconds),
                      );
                    },
                    loading: () => const SizedBox.shrink(),
                    error: (_, __) => const SizedBox.shrink(),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRemindersSkeleton() {
    return Column(
      children: List.generate(
        2,
        (index) => Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Container(
            height: 60,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context, List<Plant> plants) {
    final needsWater = plants.where((p) {
      if (p.lastWatered == null) return true;
      final days = DateTime.now().difference(p.lastWatered!).inDays;
      return days > 7;
    }).toList();

    return Row(
      children: [
        Expanded(
          child: _QuickActionCard(
            icon: Icons.add_circle_outline,
            label: 'Aggiungi',
            onTap: () => context.push(AppRoutes.addPlant),
            color: LinfaColors.primary,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _QuickActionCard(
            icon: Icons.water_drop_outlined,
            label: 'Annaffia Tutte',
            onTap: needsWater.isNotEmpty
                ? () => _showQuickWaterDialog(needsWater)
                : null,
            color: LinfaColors.watering,
            badge: needsWater.isNotEmpty ? '${needsWater.length}' : null,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _QuickActionCard(
            icon: Icons.analytics_outlined,
            label: 'Statistiche',
            onTap: () => _showAnalytics(),
            color: LinfaColors.accent,
          ),
        ),
      ],
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final Color color;
  final String? badge;

  const _QuickActionCard({
    required this.icon,
    required this.label,
    required this.onTap,
    required this.color,
    this.badge,
  });

  @override
  Widget build(BuildContext context) {
    final isEnabled = onTap != null;
    return Material(
      color: isEnabled
          ? color.withOpacity(0.1)
          : Theme.of(context)
              .colorScheme
              .surfaceContainerHighest
              .withOpacity(0.5),
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            children: [
              Stack(
                children: [
                  Icon(
                    icon,
                    color: isEnabled
                        ? color
                        : Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withOpacity(0.3),
                    size: 28,
                  ),
                  if (badge != null)
                    Positioned(
                      right: -6,
                      top: -6,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: color,
                          shape: BoxShape.circle,
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 16,
                          minHeight: 16,
                        ),
                        child: Text(
                          badge!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                label,
                style: LinfaTypography.getLabelMedium().copyWith(
                  color: isEnabled
                      ? color
                      : Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.3),
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatsCardSkeleton extends StatelessWidget {
  const _StatsCardSkeleton();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}

class _HealthSummaryCard extends StatelessWidget {
  final int totalPlants;
  final Map<String, int>? healthSummary;

  const _HealthSummaryCard({
    required this.totalPlants,
    this.healthSummary,
  });

  @override
  Widget build(BuildContext context) {
    final healthy = healthSummary?['healthy'] ?? 0;
    final needsAttention = healthSummary?['needsAttention'] ?? 0;
    final critical = healthSummary?['critical'] ?? 0;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.primaryContainer,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      totalPlants.toString(),
                      style: LinfaTypography.getDisplaySmall().copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      AppStrings.totalPlants,
                      style: LinfaTypography.getBodyMedium().copyWith(
                        color: Theme.of(context)
                            .colorScheme
                            .onPrimary
                            .withOpacity(0.9),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.eco,
                  color: Colors.white,
                  size: 32,
                ),
              ),
            ],
          ),
          if (healthSummary != null) ...[
            const SizedBox(height: 16),
            Row(
              children: [
                _HealthIndicator(
                  count: healthy,
                  label: 'Sane',
                  color: LinfaColors.healthy,
                ),
                const SizedBox(width: 12),
                _HealthIndicator(
                  count: needsAttention,
                  label: 'Attenzione',
                  color: LinfaColors.warning,
                ),
                const SizedBox(width: 12),
                _HealthIndicator(
                  count: critical,
                  label: 'Critiche',
                  color: LinfaColors.danger,
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _HealthIndicator extends StatelessWidget {
  final int count;
  final String label;
  final Color color;

  const _HealthIndicator({
    required this.count,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.15),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(
              count.toString(),
              style: LinfaTypography.getTitleLarge().copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              label,
              style: LinfaTypography.getLabelSmall().copyWith(
                color: Colors.white.withOpacity(0.8),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _AnalyticsBottomSheet extends ConsumerWidget {
  const _AnalyticsBottomSheet();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plantsAsync = ref.watch(plantsProvider);
    final plants = plantsAsync.valueOrNull ?? [];
    final remindersAsync = ref.watch(upcomingRemindersProvider);
    final reminders = remindersAsync.valueOrNull ?? [];
    final healthSummaryAsync = ref.watch(plantHealthSummaryProvider);
    final healthSummary = healthSummaryAsync.valueOrNull;
    final roomsAsync = ref.watch(plantRoomsProvider);
    final rooms = roomsAsync.valueOrNull ?? [];

    int wateredToday = 0;
    for (final plant in plants) {
      if (plant.lastWatered != null) {
        final now = DateTime.now();
        if (plant.lastWatered!.year == now.year &&
            plant.lastWatered!.month == now.month &&
            plant.lastWatered!.day == now.day) {
          wateredToday++;
        }
      }
    }

    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Statistiche Piante',
                  style: LinfaTypography.getTitleLarge(),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  _buildStatItem(
                    context,
                    'Piante Totali',
                    plants.length.toString(),
                    Icons.eco,
                    LinfaColors.primary,
                  ),
                  _buildStatItem(
                    context,
                    'Annaffiate Oggi',
                    wateredToday.toString(),
                    Icons.water_drop,
                    LinfaColors.watering,
                  ),
                  _buildStatItem(
                    context,
                    'Promemoria Attivi',
                    reminders.length.toString(),
                    Icons.notifications,
                    LinfaColors.accent,
                  ),
                  _buildStatItem(
                    context,
                    'Piante Sane',
                    (getHealthSummary(context)?['healthy'] ?? 0).toString(),
                    Icons.favorite,
                    LinfaColors.healthy,
                  ),
                  _buildStatItem(
                    context,
                    'Stanze',
                    ref
                            .watch(plantRoomsProvider)
                            .valueOrNull
                            ?.length
                            .toString() ??
                        '0',
                    Icons.room,
                    LinfaColors.fertilizing,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Map<String, int>? getHealthSummary(BuildContext context) {
    return ProviderScope.containerOf(context)
        .read(plantHealthSummaryProvider)
        .valueOrNull;
  }

  Widget _buildStatItem(
    BuildContext context,
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: LinfaTypography.getBodyMedium().copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withOpacity(0.6),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: LinfaTypography.getDisplaySmall().copyWith(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickWaterAllDialog extends StatelessWidget {
  final List<Plant> plants;
  final WidgetRef ref;

  const _QuickWaterAllDialog({required this.plants, required this.ref});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Annaffia tutte le piante'),
      content:
          Text('Vuoi registrare l\'annaffiatura per ${plants.length} piante?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(AppStrings.cancel),
        ),
        ElevatedButton(
          onPressed: () async {
            for (final plant in plants) {
              await ref.read(plantsProvider.notifier).recordWatering(plant.id);
            }
            if (context.mounted) {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${plants.length} piante annaffiate!'),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
              );
            }
          },
          child: const Text('Conferma'),
        ),
      ],
    );
  }
}
