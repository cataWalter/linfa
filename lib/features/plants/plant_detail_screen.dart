import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/strings.dart';
import '../../core/constants/routes.dart';
import '../../core/constants/enums.dart';
import '../../core/utils/date.dart';
import '../../core/theme/typography.dart';
import '../../data/models/plant.dart';
import '../../shared/providers/plant_provider.dart';
import '../../shared/providers/reminder_provider.dart';

/// Plant detail screen with enhanced UI
class PlantDetailScreen extends ConsumerWidget {
  const PlantDetailScreen({super.key, required this.plantId});

  final int plantId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plantAsync = ref.watch(plantProvider(plantId));
    final remindersAsync = ref.watch(plantRemindersProvider(plantId));

    return Scaffold(
      body: plantAsync.when(
        data: (plant) {
          if (plant == null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline,
                      size: 64, color: LinfaColors.danger),
                  const SizedBox(height: 16),
                  Text('Pianta non trovata',
                      style: LinfaTypography.getTitleLarge()),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => context.go(AppRoutes.home),
                    child: const Text('Torna alla home'),
                  ),
                ],
              ),
            );
          }
          return CustomScrollView(
            slivers: [
              // Hero image with enhanced header
              SliverAppBar(
                expandedHeight: 350,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      plant.photoPath != null &&
                              File(plant.photoPath!).existsSync()
                          ? Image.file(File(plant.photoPath!),
                              fit: BoxFit.cover)
                          : Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    _getStatusColor(plant).withOpacity(0.3),
                                    _getStatusColor(plant).withOpacity(0.1),
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                              ),
                              child: Icon(
                                Icons.eco,
                                size: 80,
                                color: _getStatusColor(plant).withOpacity(0.5),
                              ),
                            ),
                      // Gradient overlay for better text readability
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 150,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.transparent,
                                Colors.black.withOpacity(0.7),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  title: Text(
                    plant.name,
                    style: LinfaTypography.getTitleLarge().copyWith(
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          blurRadius: 10,
                          color: Colors.black.withOpacity(0.5),
                        ),
                      ],
                    ),
                  ),
                ),
                leading: IconButton(
                  icon: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.3),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.arrow_back, color: Colors.white),
                  ),
                  onPressed: () => Navigator.of(context).maybePop(),
                ),
                actions: [
                  // Favorite button
                  IconButton(
                    icon: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.3),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        plant.isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: plant.isFavorite ? Colors.red : Colors.white,
                      ),
                    ),
                    onPressed: () {
                      ref.read(plantsProvider.notifier).toggleFavorite(plantId);
                    },
                  ),
                  PopupMenuButton<String>(
                    icon: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.3),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.more_vert, color: Colors.white),
                    ),
                    onSelected: (value) {
                      switch (value) {
                        case 'edit':
                          context.push('${AppRoutes.editPlant}?id=$plantId');
                          break;
                        case 'delete':
                          _showDeleteDialog(context, ref, plantId);
                          break;
                      }
                    },
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: 'edit',
                        child: Row(
                          children: [
                            Icon(Icons.edit, size: 20),
                            SizedBox(width: 12),
                            Text(AppStrings.edit),
                          ],
                        ),
                      ),
                      const PopupMenuItem(
                        value: 'delete',
                        child: Row(
                          children: [
                            Icon(Icons.delete,
                                size: 20, color: LinfaColors.danger),
                            SizedBox(width: 12),
                            Text(AppStrings.delete,
                                style: TextStyle(color: LinfaColors.danger)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              // Content
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Species and room info
                      if (plant.species != null)
                        Text(
                          plant.species!,
                          style: LinfaTypography.getBodyLarge().copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withOpacity(0.6),
                          ),
                        ),
                      if (plant.room != null) ...[
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(Icons.room_outlined,
                                size: 16,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurface
                                    .withOpacity(0.5)),
                            const SizedBox(width: 4),
                            Text(
                              plant.room!,
                              style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurface
                                    .withOpacity(0.6),
                              ),
                            ),
                          ],
                        ),
                      ],
                      const SizedBox(height: 24),

                      // Care statistics grid
                      _buildCareStatsGrid(context, plant),
                      const SizedBox(height: 24),

                      // Quick actions
                      _buildQuickActions(context, ref, plant),
                      const SizedBox(height: 24),

                      // Light condition card
                      _buildLightConditionCard(context, plant),
                      const SizedBox(height: 16),

                      // Notes card
                      if (plant.notes != null) ...[
                        _buildNotesCard(context, plant),
                        const SizedBox(height: 16),
                      ],

                      // Reminders section
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppStrings.reminders,
                            style: LinfaTypography.getTitleLarge(),
                          ),
                          TextButton.icon(
                            onPressed: () {
                              context.push(
                                  '${AppRoutes.addReminder}?plantId=$plantId');
                            },
                            icon: const Icon(Icons.add, size: 18),
                            label: const Text(AppStrings.add),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      remindersAsync.when(
                        data: (reminders) {
                          if (reminders.isEmpty) {
                            return Container(
                              padding: const EdgeInsets.all(24),
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .surfaceContainerHighest,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.notifications_none,
                                    size: 48,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface
                                        .withOpacity(0.4),
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    'Nessun promemoria impostato',
                                    style: LinfaTypography.getBodyMedium()
                                        .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface
                                          .withOpacity(0.6),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                          return Column(
                            children: reminders
                                .map((r) => _buildReminderCard(r))
                                .toList(),
                          );
                        },
                        loading: () =>
                            const Center(child: CircularProgressIndicator()),
                        error: (_, __) => const SizedBox.shrink(),
                      ),
                      const SizedBox(height: 24),

                      // Growth button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            context.push(
                                '${AppRoutes.growth}?plantId=$plantId&name=${plant.name}');
                          },
                          icon: const Icon(Icons.timeline),
                          label: const Text(AppStrings.growthTimeline),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
        loading: () => const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
        error: (e, _) => Scaffold(
          body: Center(child: Text('Errore: $e')),
        ),
      ),
    );
  }

  /// Get status color based on plant health
  Color _getStatusColor(Plant plant) {
    switch (plant.status?.toLowerCase()) {
      case 'sana':
      case 'healthy':
        return LinfaColors.healthy;
      case 'stressata':
      case 'stressed':
        return LinfaColors.warning;
      case 'dormiente':
      case 'dormant':
        return LinfaColors.dormant;
      case 'in recupero':
      case 'recovering':
        return LinfaColors.accent;
      default:
        return LinfaColors.primary;
    }
  }

  /// Build care statistics grid
  Widget _buildCareStatsGrid(BuildContext context, Plant plant) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Statistiche Cura',
            style: LinfaTypography.getTitleMedium(),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _CareStatItem(
                  icon: Icons.water_drop,
                  label: 'Ultima annaffiatura',
                  value: plant.lastWatered != null
                      ? LinfaDateUtils.getRelativeTime(plant.lastWatered!)
                      : 'Mai',
                  color: LinfaColors.watering,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _CareStatItem(
                  icon: Icons.science,
                  label: 'Ultima concimazione',
                  value: plant.lastFertilized != null
                      ? LinfaDateUtils.getRelativeTime(plant.lastFertilized!)
                      : 'Mai',
                  color: LinfaColors.fertilizing,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _CareStatItem(
                  icon: Icons.square_foot,
                  label: 'Ultimo rinvaso',
                  value: plant.lastRepotted != null
                      ? LinfaDateUtils.getRelativeTime(plant.lastRepotted!)
                      : 'Mai',
                  color: LinfaColors.repotting,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _CareStatItem(
                  icon: Icons.content_cut,
                  label: 'Ultima potatura',
                  value: plant.lastPruned != null
                      ? LinfaDateUtils.getRelativeTime(plant.lastPruned!)
                      : 'Mai',
                  color: LinfaColors.pruning,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context, WidgetRef ref, Plant plant) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Azioni Rapide',
          style: LinfaTypography.getTitleMedium(),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _QuickActionButton(
                icon: Icons.water_drop,
                label: 'Annaffia',
                color: LinfaColors.watering,
                onTap: () {
                  ref.read(plantsProvider.notifier).recordWatering(plant.id);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Annaffiatura registrata!'),
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _QuickActionButton(
                icon: Icons.science,
                label: 'Concima',
                color: LinfaColors.fertilizing,
                onTap: () {
                  ref.read(plantRepositoryProvider).recordFertilizing(plant.id);
                  ref.read(plantsProvider.notifier).loadPlants();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Concimazione registrata!'),
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _QuickActionButton(
                icon: Icons.water_drop_outlined,
                label: 'Nebulizza',
                color: LinfaColors.misting,
                onTap: () {
                  ref.read(plantRepositoryProvider).recordMisting(plant.id);
                  ref.read(plantsProvider.notifier).loadPlants();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Nebulizzazione registrata!'),
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLightConditionCard(BuildContext context, Plant plant) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: LinfaColors.accent.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child:
                const Icon(Icons.wb_sunny, color: LinfaColors.accent, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Condizione Luce',
                  style: LinfaTypography.getLabelMedium().copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withOpacity(0.6),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  LightCondition.values
                      .firstWhere(
                        (e) => e.name == plant.lightCondition,
                        orElse: () => LightCondition.indirect,
                      )
                      .displayName,
                  style: LinfaTypography.getTitleMedium(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotesCard(BuildContext context, Plant plant) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.note_outlined,
                  size: 20, color: Theme.of(context).colorScheme.primary),
              const SizedBox(width: 8),
              Text(
                'Note',
                style: LinfaTypography.getTitleSmall(),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            plant.notes!,
            style: LinfaTypography.getBodyMedium(),
          ),
        ],
      ),
    );
  }

  Widget _buildReminderCard(dynamic reminder) {
    final type = reminder.type?.toString() ?? '';
    final typeDisplayName =
        reminder.typeDisplayName?.toString() ?? 'Promemoria';
    final frequencyDays = reminder.frequencyDays ?? 0;
    final isOverdue = reminder.isOverdue == true;

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: _getReminderColor(type).withOpacity(0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            _getReminderIcon(type),
            color: _getReminderColor(type),
          ),
        ),
        title: Text(typeDisplayName),
        subtitle: Text('Ogni $frequencyDays giorni'),
        trailing: isOverdue
            ? const Icon(Icons.warning, color: LinfaColors.danger)
            : const Icon(Icons.check_circle, color: LinfaColors.healthy),
      ),
    );
  }

  IconData _getReminderIcon(String type) {
    switch (type) {
      case 'watering':
        return Icons.water_drop;
      case 'fertilizing':
        return Icons.science;
      case 'repotting':
        return Icons.square_foot;
      case 'cleaning':
        return Icons.cleaning_services;
      case 'pruning':
        return Icons.content_cut;
      case 'misting':
        return Icons.air;
      default:
        return Icons.notifications;
    }
  }

  Color _getReminderColor(String type) {
    switch (type) {
      case 'watering':
        return LinfaColors.watering;
      case 'fertilizing':
        return LinfaColors.fertilizing;
      case 'repotting':
        return LinfaColors.repotting;
      case 'cleaning':
        return LinfaColors.cleaning;
      case 'pruning':
        return LinfaColors.pruning;
      case 'misting':
        return LinfaColors.misting;
      default:
        return LinfaColors.primary;
    }
  }

  void _showDeleteDialog(BuildContext context, WidgetRef ref, int plantId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(AppStrings.deletePlant),
        content: const Text(AppStrings.deletePlantConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(AppStrings.cancel),
          ),
          TextButton(
            onPressed: () {
              ref.read(plantsProvider.notifier).deletePlant(plantId);
              Navigator.pop(context);
              context.pop();
            },
            style: TextButton.styleFrom(foregroundColor: LinfaColors.danger),
            child: const Text(AppStrings.delete),
          ),
        ],
      ),
    );
  }
}

class _CareStatItem extends StatelessWidget {
  const _CareStatItem({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 16, color: color),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                label,
                style: LinfaTypography.getLabelSmall().copyWith(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: LinfaTypography.getLabelMedium().copyWith(
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
      ],
    );
  }
}

class _QuickActionButton extends StatelessWidget {
  const _QuickActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color.withOpacity(0.1),
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            children: [
              Icon(icon, color: color, size: 28),
              const SizedBox(height: 8),
              Text(
                label,
                style: LinfaTypography.getLabelMedium().copyWith(color: color),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
