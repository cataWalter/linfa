import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/constants/colors.dart';
import '../../core/theme/typography.dart';

/// Empty state widget for when there's no data
class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
    required this.icon,
    required this.title,
    required this.message,
    this.actionLabel,
    this.onAction,
    this.illustrationColor,
  });

  final IconData icon;
  final String title;
  final String message;
  final String? actionLabel;
  final VoidCallback? onAction;
  final Color? illustrationColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = illustrationColor ?? theme.colorScheme.primary;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Decorated icon container
            Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
                border: Border.all(
                  color: color.withOpacity(0.2),
                  width: 2,
                ),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Decorative dots
                  Positioned(
                    top: 15,
                    right: 20,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.4),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    left: 25,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.3),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  // Main icon
                  Icon(
                    icon,
                    size: 64,
                    color: color,
                  ),
                ],
              ),
            ).animate().scale(
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeOutBack,
                ),
            const SizedBox(height: 24),
            Text(
              title,
              style: LinfaTypography.getHeadlineSmall().copyWith(
                color: theme.colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: LinfaTypography.getBodyMedium().copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.6),
              ),
              textAlign: TextAlign.center,
            ),
            if (actionLabel != null && onAction != null) ...[
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: onAction,
                icon: const Icon(Icons.add),
                label: Text(actionLabel!),
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                ),
              ).animate().fadeIn(delay: const Duration(milliseconds: 300)),
            ],
          ],
        ),
      ),
    );
  }
}

/// Skeleton loading widget
class SkeletonLoader extends StatelessWidget {
  const SkeletonLoader({
    super.key,
    this.width = double.infinity,
    this.height = 16,
    this.borderRadius = 8,
    this.shimmer = true,
  });

  final double width;
  final double height;
  final double borderRadius;
  final bool shimmer;

  @override
  Widget build(BuildContext context) {
    final container = Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    );

    if (shimmer) {
      return container
          .animate(
            onPlay: (controller) => controller.repeat(reverse: true),
          )
          .shimmer(
            duration: const Duration(milliseconds: 1500),
            color: Theme.of(context)
                .colorScheme
                .surfaceContainerHighest
                .withOpacity(0.5),
          );
    }

    return container;
  }
}

/// Card skeleton for plant cards
class PlantCardSkeleton extends StatelessWidget {
  const PlantCardSkeleton({super.key, this.shimmer = true});

  final bool shimmer;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 240, // Fixed height like a typical card
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Photo placeholder
            Container(
              height: 140, // Fixed height for photo area
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
            ),
            // Info skeleton
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SkeletonLoader(height: 16, width: 80, shimmer: shimmer),
                  const SizedBox(height: 8),
                  SkeletonLoader(height: 12, width: 60, shimmer: shimmer),
                  const SizedBox(height: 12),
                  SkeletonLoader(height: 10, width: 50, shimmer: shimmer),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Stats card skeleton
class StatsCardSkeleton extends StatelessWidget {
  const StatsCardSkeleton({super.key, this.shimmer = true});

  final bool shimmer;

  @override
  Widget build(BuildContext context) {
    final container = Container(
      height: 120,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(20),
      ),
    );

    if (shimmer) {
      return container
          .animate(
            onPlay: (controller) => controller.repeat(reverse: true),
          )
          .shimmer(
            duration: const Duration(milliseconds: 1500),
            color: Theme.of(context)
                .colorScheme
                .surfaceContainerHighest
                .withOpacity(0.5),
          );
    }

    return container;
  }
}
