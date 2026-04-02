import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/strings.dart';
import '../../core/constants/routes.dart';
import '../../core/theme/typography.dart';
import '../../core/utils/date.dart';
import '../../shared/providers/reminder_provider.dart';
import '../../shared/widgets/empty_state.dart';

/// Reminders list screen
class RemindersScreen extends ConsumerWidget {
  const RemindersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final remindersAsync = ref.watch(remindersProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.reminders),
      ),
      body: remindersAsync.when(
        data: (reminders) {
          if (reminders.isEmpty) {
            return EmptyState(
              icon: Icons.notifications_none,
              title: AppStrings.noReminders,
              message: 'Aggiungi un promemoria per non dimenticare le cure',
              actionLabel: AppStrings.addReminder,
              onAction: () {
                context.push(AppRoutes.addReminder);
              },
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: reminders.length,
            itemBuilder: (context, index) {
              final reminder = reminders[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: _getTypeColor(reminder.type).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      _getTypeIcon(reminder.type),
                      color: _getTypeColor(reminder.type),
                      size: 24,
                    ),
                  ),
                  title: Text(
                    reminder.typeDisplayName,
                    style: LinfaTypography.getTitleSmall(),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (reminder.plant.value != null)
                        Text(reminder.plant.value!.name),
                      Text('Ogni ${reminder.frequencyDays} giorni'),
                    ],
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        reminder.nextScheduled != null
                            ? LinfaDateUtils.getReminderDueDate(reminder.nextScheduled!)
                            : '--',
                        style: LinfaTypography.getLabelSmall().copyWith(
                          color: reminder.isOverdue
                              ? LinfaColors.danger
                              : LinfaColors.textSecondaryLight,
                        ),
                      ),
                      Switch(
                        value: reminder.isEnabled,
                        onChanged: (_) {
                          ref.read(remindersProvider.notifier).toggleEnabled(reminder.id);
                        },
                      ),
                    ],
                  ),
                  onTap: () {
                    // Navigate to edit reminder
                  },
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Errore: $e')),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          context.push(AppRoutes.addReminder);
        },
        icon: const Icon(Icons.add),
        label: const Text(AppStrings.addReminder),
      ),
    );
  }

  Color _getTypeColor(String type) {
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

  IconData _getTypeIcon(String type) {
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
}
