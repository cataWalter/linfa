import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/routes.dart';
import '../../../core/theme/typography.dart';
import '../../../core/utils/date.dart';
import '../../../data/models/plant.dart';

/// Plant card widget for home screen grid
class PlantCard extends StatelessWidget {
  const PlantCard({super.key, required this.plant});

  final Plant plant;

  /// Get health status color
  Color _getHealthStatusColor() {
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

  /// Get days since last watering with color indicator
  Widget? _getWateringIndicator() {
    if (plant.lastWatered == null) return null;
    final days = plant.daysSinceLastWatering ?? 0;
    Color color;
    IconData icon;
    if (days <= 3) {
      color = LinfaColors.healthy;
      icon = Icons.water_drop;
    } else if (days <= 5) {
      color = LinfaColors.warning;
      icon = Icons.water_drop_outlined;
    } else {
      color = LinfaColors.danger;
      icon = Icons.water_drop;
    }
    return Row(
      children: [
        Icon(icon, size: 14, color: color),
        const SizedBox(width: 4),
        Text(
          LinfaDateUtils.getRelativeTime(plant.lastWatered!),
          style: LinfaTypography.getLabelSmall().copyWith(color: color),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 2,
      shadowColor: isDark ? Colors.black26 : Colors.black12,
      child: InkWell(
        onTap: () {
          context.push('${AppRoutes.plantDetail}?id=${plant.id}');
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Photo with health indicator overlay
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  plant.photoPath != null && File(plant.photoPath!).existsSync()
                      ? Image.file(
                          File(plant.photoPath!),
                          fit: BoxFit.cover,
                          width: double.infinity,
                        )
                      : Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                _getHealthStatusColor().withOpacity(0.2),
                                _getHealthStatusColor().withOpacity(0.1),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: Icon(
                            Icons.eco_outlined,
                            size: 48,
                            color: _getHealthStatusColor(),
                          ),
                        ),
                  // Health status badge
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                      decoration: BoxDecoration(
                        color: _getHealthStatusColor(),
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            plant.isFavorite ? Icons.favorite : Icons.eco,
                            size: 10,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Favorite badge
                  if (plant.isFavorite)
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.pink,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.favorite,
                          size: 12,
                          color: Colors.white,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            // Info
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    plant.name,
                    style: LinfaTypography.getTitleSmall(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (plant.species != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      plant.species!,
                      style: LinfaTypography.getBodySmall().copyWith(
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                  const SizedBox(height: 8),
                  _getWateringIndicator() ??
                      Text(
                        'Mai annaffiata',
                        style: LinfaTypography.getLabelSmall().copyWith(
                          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.4),
                        ),
                      ),
                  if (plant.room != null) ...[
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.room_outlined,
                          size: 12,
                          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          plant.room!,
                          style: LinfaTypography.getLabelSmall().copyWith(
                            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
