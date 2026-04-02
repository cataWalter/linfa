import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:file_picker/file_picker.dart';
import 'package:share_plus/share_plus.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/strings.dart';
import '../../core/constants/enums.dart';
import '../../core/constants/routes.dart';
import '../../core/theme/typography.dart';
import '../../core/utils/export.dart';
import '../../shared/providers/theme_provider.dart';
import '../../shared/providers/notification_provider.dart';
import '../../shared/providers/plant_provider.dart';
import '../../shared/providers/reminder_provider.dart';
import '../../data/database/database.dart';

/// Settings screen with enhanced UI
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final notificationSettings = ref.watch(notificationProvider);
    final plantCountAsync = ref.watch(plantCountProvider);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Header
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.fromLTRB(20, 60, 20, 32),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.eco,
                            color: Colors.white, size: 28),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppStrings.appName,
                            style: LinfaTypography.getHeadlineSmall().copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'v1.0.0',
                            style: LinfaTypography.getBodySmall().copyWith(
                              color: Colors.white.withOpacity(0.8),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Stats section
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: plantCountAsync.when(
                data: (count) => _buildStatsRow(context, count),
                loading: () => const SizedBox(height: 80),
                error: (_, __) => const SizedBox.shrink(),
              ),
            ),
          ),

          // Settings sections
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Appearance section
                  _buildSectionHeader(context, 'Aspetto'),
                  _buildSettingsCard(
                    context,
                    leading: const Icon(Icons.palette_outlined),
                    title: AppStrings.theme,
                    subtitle: _getThemeModeSubtitle(themeMode),
                    trailing: DropdownButton<AppThemeMode>(
                      value: themeMode,
                      underline: const SizedBox.shrink(),
                      items: AppThemeMode.values.map((mode) {
                        return DropdownMenuItem(
                          value: mode,
                          child: Text(mode.displayName),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          ref.read(themeProvider.notifier).setTheme(value);
                        }
                      },
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Notifications section
                  _buildSectionHeader(context, AppStrings.notifications),
                  _buildSettingsCard(
                    context,
                    leading: const Icon(Icons.notifications_outlined),
                    title: AppStrings.notificationEnabled,
                    trailing: Switch(
                      value: notificationSettings.enabled,
                      onChanged: (_) {
                        ref.read(notificationProvider.notifier).toggleEnabled();
                      },
                    ),
                  ),
                  if (notificationSettings.enabled)
                    _buildSettingsCard(
                      context,
                      leading: const Icon(Icons.music_note),
                      title: AppStrings.notificationSound,
                      trailing: Switch(
                        value: notificationSettings.sound,
                        onChanged: (_) {
                          ref.read(notificationProvider.notifier).toggleSound();
                        },
                      ),
                    ),

                  const SizedBox(height: 16),

                  // Data Management section
                  _buildSectionHeader(context, AppStrings.dataManagement),
                  _buildSettingsCard(
                    context,
                    leading: const Icon(Icons.download_outlined),
                    title: AppStrings.exportData,
                    onTap: () => _exportData(context, ref),
                  ),
                  _buildSettingsCard(
                    context,
                    leading: const Icon(Icons.upload_outlined),
                    title: AppStrings.importData,
                    onTap: () => _importData(context, ref),
                  ),
                  _buildSettingsCard(
                    context,
                    leading: Icon(Icons.delete_sweep_outlined,
                        color: LinfaColors.danger),
                    title: AppStrings.clearData,
                    titleColor: LinfaColors.danger,
                    onTap: () => _showClearDataDialog(context, ref),
                  ),

                  // Storage info
                  FutureBuilder<String>(
                    future: ExportUtils.getStorageSize(),
                    builder: (context, snapshot) {
                      return _buildSettingsCard(
                        context,
                        leading: const Icon(Icons.storage_outlined),
                        title: 'Spazio di archiviazione',
                        subtitle:
                            snapshot.hasData ? snapshot.data! : 'Calcolo...',
                      );
                    },
                  ),

                  const SizedBox(height: 16),

                  // About section
                  _buildSectionHeader(context, AppStrings.about),
                  _buildSettingsCard(
                    context,
                    leading: const Icon(Icons.privacy_tip_outlined),
                    title: AppStrings.privacyPolicy,
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text(AppStrings.privacyPolicy),
                          content: const Text(AppStrings.privacyNote),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text(AppStrings.ok),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  _buildSettingsCard(
                    context,
                    leading: const Icon(Icons.code),
                    title: 'GitHub',
                    subtitle: 'Codice sorgente',
                    onTap: () {},
                  ),

                  const SizedBox(height: 32),

                  // Footer
                  Center(
                    child: Column(
                      children: [
                        Icon(
                          Icons.eco,
                          size: 32,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          AppStrings.appTagline,
                          style: LinfaTypography.getBodySmall().copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withOpacity(0.5),
                          ),
                        ),
                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: LinfaTypography.getLabelLarge().copyWith(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildSettingsCard(
    BuildContext context, {
    required Widget leading,
    required String title,
    String? subtitle,
    Widget? trailing,
    VoidCallback? onTap,
    Color? titleColor,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.1),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                IconTheme(
                  data: IconThemeData(
                    color:
                        titleColor ?? Theme.of(context).colorScheme.onSurface,
                    size: 24,
                  ),
                  child: leading,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: LinfaTypography.getBodyLarge().copyWith(
                          color: titleColor ??
                              Theme.of(context).colorScheme.onSurface,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      if (subtitle != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          subtitle,
                          style: LinfaTypography.getBodySmall().copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withOpacity(0.6),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                if (trailing != null) trailing,
                if (onTap != null && trailing == null)
                  Icon(
                    Icons.chevron_right,
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withOpacity(0.3),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatsRow(BuildContext context, int plantCount) {
    return Row(
      children: [
        Expanded(
          child: _StatCard(
            icon: Icons.eco,
            value: plantCount.toString(),
            label: AppStrings.totalPlants,
            color: LinfaColors.primary,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _StatCard(
            icon: Icons.favorite,
            value: '-',
            label: 'Preferite',
            color: Colors.pink,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _StatCard(
            icon: Icons.notifications_active,
            value: '-',
            label: 'Promemoria',
            color: LinfaColors.accent,
          ),
        ),
      ],
    );
  }

  String _getThemeModeSubtitle(AppThemeMode mode) {
    switch (mode) {
      case AppThemeMode.light:
        return 'Tema chiaro attivo';
      case AppThemeMode.dark:
        return 'Tema scuro attivo';
      case AppThemeMode.system:
        return 'Segue le impostazioni del sistema';
    }
  }

  Future<void> _exportData(BuildContext context, WidgetRef ref) async {
    try {
      final plants = await ref.read(plantRepositoryProvider).exportAllPlants();
      final reminders =
          await ref.read(reminderRepositoryProvider).exportAllReminders();

      final backupData = ExportUtils.createBackupData(
        plants: plants,
        reminders: reminders,
        growthEntries: [],
        settings: {},
      );

      await ExportUtils.exportAsJson(backupData);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(AppStrings.exportSuccess),
            behavior: SnackBarBehavior.floating,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${AppStrings.exportError}: $e'),
            backgroundColor: LinfaColors.danger,
            behavior: SnackBarBehavior.floating,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        );
      }
    }
  }

  Future<void> _importData(BuildContext context, WidgetRef ref) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['json'],
      );

      if (result != null && result.files.single.path != null) {
        final data = await ExportUtils.readJsonFile(result.files.single.path!);
        if (data != null) {
          final plants =
              (data['plants'] as List?)?.cast<Map<String, dynamic>>() ?? [];
          final reminders =
              (data['reminders'] as List?)?.cast<Map<String, dynamic>>() ?? [];

          await ref.read(plantRepositoryProvider).importPlants(plants);
          await ref.read(reminderRepositoryProvider).importReminders(reminders);

          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text(AppStrings.importSuccess),
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
            );
          }
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${AppStrings.importError}: $e'),
            backgroundColor: LinfaColors.danger,
            behavior: SnackBarBehavior.floating,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        );
      }
    }
  }

  void _showClearDataDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(AppStrings.clearData),
        content: const Text(AppStrings.clearDataConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(AppStrings.cancel),
          ),
          TextButton(
            onPressed: () async {
              await DatabaseService.instance.clearAll();
              if (context.mounted) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text(AppStrings.dataCleared),
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                );
              }
            },
            style: TextButton.styleFrom(foregroundColor: LinfaColors.danger),
            child: const Text(AppStrings.delete),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
  });

  final IconData icon;
  final String value;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: LinfaTypography.getDisplaySmall().copyWith(
              color: color,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label,
            style: LinfaTypography.getLabelSmall().copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
