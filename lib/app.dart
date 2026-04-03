import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'core/constants/enums.dart';
import 'core/constants/routes.dart';
import 'core/constants/strings.dart';
import 'core/theme/light.dart';
import 'core/theme/dark.dart';
import 'features/main_shell.dart';
import 'features/plants/add_plant_screen.dart';
import 'features/plants/plant_detail_screen.dart';
import 'features/plants/edit_plant_screen.dart';
import 'features/reminders/add_reminder_screen.dart';
import 'features/growth/growth_timeline_screen.dart';
import 'shared/providers/theme_provider.dart';

/// Main app widget
class LinfaApp extends ConsumerWidget {
  const LinfaApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      theme: getLightTheme(),
      darkTheme: getDarkTheme(),
      themeMode: switch (ref.watch(themeProvider)) {
        AppThemeMode.light => ThemeMode.light,
        AppThemeMode.dark => ThemeMode.dark,
        AppThemeMode.system => ThemeMode.system,
      },
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('it', 'IT'),
        Locale('en', 'US'),
      ],
      locale: const Locale('it', 'IT'),
      routerConfig: _router,
    );
  }

  // Router configuration
  static final GoRouter _router = GoRouter(
    initialLocation: AppRoutes.home,
    routes: [
      // Main shell with bottom navigation
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => const MainShell(),
      ),
      // Plant routes
      GoRoute(
        path: AppRoutes.addPlant,
        builder: (context, state) => const AddPlantScreen(),
      ),
      GoRoute(
        path: AppRoutes.plantDetail,
        builder: (context, state) {
          final id = int.parse(state.uri.queryParameters['id'] ?? '0');
          return PlantDetailScreen(plantId: id);
        },
      ),
      GoRoute(
        path: AppRoutes.editPlant,
        builder: (context, state) {
          final id = int.parse(state.uri.queryParameters['id'] ?? '0');
          return EditPlantScreen(plantId: id);
        },
      ),
      // Reminder routes
      GoRoute(
        path: AppRoutes.addReminder,
        builder: (context, state) {
          final plantId = state.uri.queryParameters['plantId'];
          return AddReminderScreen(
            plantId: plantId != null ? int.parse(plantId) : null,
          );
        },
      ),
      // Growth routes
      GoRoute(
        path: AppRoutes.growth,
        builder: (context, state) {
          final plantId =
              int.parse(state.uri.queryParameters['plantId'] ?? '0');
          final plantName = state.uri.queryParameters['name'] ?? '';
          return GrowthTimelineScreen(plantId: plantId, plantName: plantName);
        },
      ),
    ],
  );
}
