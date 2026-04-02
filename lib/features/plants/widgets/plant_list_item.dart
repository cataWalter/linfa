import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/routes.dart';
import '../../../core/theme/typography.dart';
import '../../../core/utils/date.dart';
import '../../../data/models/plant.dart';

/// Plant list item widget
class PlantListItem extends StatelessWidget {
  const PlantListItem({super.key, required this.plant});

  final Plant plant;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: plant.photoPath != null && File(plant.photoPath!).existsSync()
              ? Image.file(
                  File(plant.photoPath!),
                  width: 56,
                  height: 56,
                  fit: BoxFit.cover,
                )
              : Container(
                  width: 56,
                  height: 56,
                  color: LinfaColors.primary.withOpacity(0.1),
                  child: Icon(
                    Icons.eco_outlined,
                    color: LinfaColors.primary,
                    size: 28,
                  ),
                ),
        ),
        title: Text(
          plant.name,
          style: LinfaTypography.getTitleSmall(),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (plant.species != null)
              Text(
                plant.species!,
                style: LinfaTypography.getBodySmall().copyWith(
                  color: LinfaColors.textSecondaryLight,
                ),
              ),
            if (plant.room != null)
              Text(
                plant.room!,
                style: LinfaTypography.getBodySmall().copyWith(
                  color: LinfaColors.textSecondaryLight,
                ),
              ),
          ],
        ),
        trailing: plant.lastWatered != null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.water_drop,
                    size: 18,
                    color: _getWateringColor(plant.lastWatered!),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    LinfaDateUtils.getRelativeTime(plant.lastWatered!),
                    style: LinfaTypography.getLabelSmall().copyWith(
                      color: LinfaColors.textSecondaryLight,
                    ),
                  ),
                ],
              )
            : const Icon(Icons.chevron_right),
        onTap: () {
          context.push('${AppRoutes.plantDetail}?id=${plant.id}');
        },
      ),
    );
  }

  Color _getWateringColor(DateTime lastWatered) {
    final days = LinfaDateUtils.daysSince(lastWatered);
    if (days <= 3) return LinfaColors.healthy;
    if (days <= 7) return LinfaColors.warning;
    return LinfaColors.danger;
  }
}
