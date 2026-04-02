import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/strings.dart';
import '../../core/constants/routes.dart';
import '../../core/theme/typography.dart';
import '../../core/utils/date.dart';
import '../../shared/providers/plant_provider.dart';
import '../../shared/providers/reminder_provider.dart';
import '../../shared/widgets/empty_state.dart';
import 'widgets/plant_card.dart';
import 'widgets/upcoming_reminders.dart';

/// Home screen - Dashboard with pull-to-refresh
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  Future<void> _onRefresh() async {
    // Refresh all providers
    ref.invalidate(plantsProvider);
    ref.invalidate(upcomingRemindersProvider);
    ref.invalidate(plantCountProvider);
    ref.invalidate(plantsNeedingWaterProvider);
    // Wait a bit for the providers to refresh
    await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  Widget build(BuildContext context) {
    final plantsAsync = ref.watch(plantsProvider);
    final upcomingAsync = ref.watch(upcomingRemindersProvider);
    final countAsync = ref.watch(plantCountProvider);
    final needsWaterAsync = ref.watch(plantsNeedingWaterProvider);

    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _onRefresh,
          color: LinfaColors.primary,
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
            slivers: [
              // Header
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                LinfaDateUtils.getGreeting(),
                                style: LinfaTypography.getDisplaySmall().copyWith(
                                  fontSize: 28,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                AppStrings.appTagline,
                                style: LinfaTypography.getBodyMedium().copyWith(
                                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                                ),
                              ),
                            ],
                          ),
                          // Notification bell with badge
                          Stack(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.notifications_outlined),
                                onPressed: () {
                                  // Navigate to reminders tab via parent
                                },
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
                                    ),
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
                ),
              ),

              // Stats cards
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: countAsync.when(
                    data: (count) => _buildStatsCard(context, count),
                    loading: () => const StatsCardSkeleton(),
                    error: (_, __) => const SizedBox.shrink(),
                  ),
                ),
              ),

              // Quick actions
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: _buildQuickActions(context),
                ),
              ),

              // Upcoming reminders
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppStrings.upcomingReminders,
                        style: LinfaTypography.getTitleLarge(),
                      ),
                      TextButton(
                        onPressed: () {
                          // Navigate to reminders tab
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
                    data: (reminders) => UpcomingRemindersWidget(reminders: reminders),
                    loading: () => _buildRemindersSkeleton(),
                    error: (_, __) => const SizedBox.shrink(),
                  ),
                ),
              ),

              // Plants section
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
                        onPressed: () {
                          context.push(AppRoutes.addPlant);
                        },
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
                        onAction: () {
                          context.push(AppRoutes.addPlant);
                        },
                      ),
                    );
                  }
                  return SliverPadding(
                    padding: const EdgeInsets.all(20),
                    sliver: SliverGrid(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 0.85,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final plant = plants[index];
                          return PlantCard(plant: plant).animate().fadeIn().slideY(
                            begin: 0.2,
                            duration: const Duration(milliseconds: 400),
                            delay: Duration(milliseconds: index * 100),
                          );
                        },
                        childCount: plants.length,
                      ),
                    ),
                  );
                },
                loading: () => const SliverToBoxAdapter(
                  child: Column(
                    children: [
                      PlantCardSkeleton(),
                      SizedBox(height: 16),
                      PlantCardSkeleton(),
                    ],
                  ),
                ),
                error: (e, _) => SliverToBoxAdapter(
                  child: Center(child: Text('Errore: $e')),
                ),
              ),
              // Bottom padding
              const SliverToBoxAdapter(
                child: SizedBox(height: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatsCard(BuildContext context, int plantCount) {
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
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  plantCount.toString(),
                  style: LinfaTypography.getDisplaySmall().copyWith(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontSize: 48,
                  ),
                ),
                Text(
                  AppStrings.totalPlants,
                  style: LinfaTypography.getBodyMedium().copyWith(
                    color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.9),
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

  Widget _buildQuickActions(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _QuickActionCard(
            icon: Icons.add_circle_outline,
            label: 'Aggiungi',
            onTap: () => context.push(AppRoutes.addPlant),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _QuickActionCard(
            icon: Icons.water_drop_outlined,
            label: 'Annaffia',
            onTap: () {
              // Quick water all plants
            },
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _QuickActionCard(
            icon: Icons.camera_alt_outlined,
            label: 'Foto',
            onTap: () {
              // Quick photo entry
            },
          ),
        ),
      ],
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _QuickActionCard({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            children: [
              Icon(icon, color: Theme.of(context).colorScheme.primary),
              const SizedBox(height: 8),
              Text(
                label,
                style: LinfaTypography.getLabelMedium().copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

