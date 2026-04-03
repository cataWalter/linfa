import 'package:flutter/material.dart';
import '../../../core/constants/colors.dart';
import '../../../core/theme/typography.dart';
import '../../../core/utils/date.dart';
import '../../../data/models/reminder.dart';

/// Upcoming reminders widget for home screen
class UpcomingRemindersWidget extends StatelessWidget {
  const UpcomingRemindersWidget({super.key, required this.reminders});

  final List<Reminder> reminders;

  @override
  Widget build(BuildContext context) {
    if (reminders.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(Icons.check_circle, color: LinfaColors.healthy, size: 20),
            const SizedBox(width: 8),
            Text(
              'Nessun promemoria imminente',
              style: LinfaTypography.getBodyMedium().copyWith(
                color: LinfaColors.textSecondaryLight,
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      children: reminders.take(3).map((reminder) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(12),
              border: reminder.isOverdue
                  ? Border.all(color: LinfaColors.danger.withOpacity(0.5))
                  : null,
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _getTypeColor(reminder.type).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    _getTypeIcon(reminder.type),
                    color: _getTypeColor(reminder.type),
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Text(
                         reminder.typeDisplayName,
                         style: LinfaTypography.getTitleSmall(),
                         maxLines: 1,
                         overflow: TextOverflow.ellipsis,
                       ),
                      if (reminder.plant.value != null)
                         Text(
                           reminder.plant.value!.name,
                           style: LinfaTypography.getBodySmall().copyWith(
                             color: LinfaColors.textSecondaryLight,
                           ),
                           maxLines: 1,
                           overflow: TextOverflow.ellipsis,
                         ),
                    ],
                  ),
                ),
                Text(
                  reminder.isOverdue
                      ? 'Scaduto'
                      : LinfaDateUtils.getReminderDueDate(reminder.nextScheduled!),
                  style: LinfaTypography.getLabelSmall().copyWith(
                    color: reminder.isOverdue
                        ? LinfaColors.danger
                        : LinfaColors.textSecondaryLight,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
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
