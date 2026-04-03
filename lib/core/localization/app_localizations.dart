import 'package:flutter/material.dart';

/// Supported languages enum
enum AppLanguage {
  english('en', 'English', 'US'),
  italian('it', 'Italiano', 'IT'),
  spanish('es', 'Español', 'ES'),
  french('fr', 'Français', 'FR'),
  german('de', 'Deutsch', 'DE'),
  portuguese('pt', 'Português', 'BR'),
  dutch('nl', 'Nederlands', 'NL'),
  polish('pl', 'Polski', 'PL'),
  japanese('ja', '日本語', 'JP'),
  chinese('zh', '中文', 'CN');

  final String code;
  final String nativeName;
  final String countryCode;

  const AppLanguage(this.code, this.nativeName, this.countryCode);

  Locale get locale => Locale(code, countryCode);

  static AppLanguage fromLocale(Locale locale) {
    return values.firstWhere(
      (lang) => lang.code == locale.languageCode,
      orElse: () => AppLanguage.english,
    );
  }

  static List<AppLanguage> get availableLanguages => [
        AppLanguage.english,
        AppLanguage.italian,
      ];
}

/// Localization strings for the app
class AppLocalizations {
  final AppLanguage language;
  final Map<String, String> _strings;

  AppLocalizations({
    required this.language,
    required Map<String, String> strings,
  }) : _strings = strings;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  String get(String key, {Map<String, String>? args}) {
    String? value = _strings[key];
    if (value == null) {
      // Fallback to key
      return key;
    }
    if (args != null) {
      args.forEach((key, value) {
        value = value!.replaceAll('{$key}', args[key]!);
      });
    }
    return value;
  }

  // App Info
  String get appName => _strings['app_name'] ?? 'Linfa';
  String get appTagline => _strings['app_tagline'] ?? 'Your Plant Care Assistant';

  // Navigation
  String get home => _strings['home'] ?? 'Home';
  String get myPlants => _strings['my_plants'] ?? 'My Plants';
  String get reminders => _strings['reminders'] ?? 'Reminders';
  String get settings => _strings['settings'] ?? 'Settings';
  String get analytics => _strings['analytics'] ?? 'Analytics';
  String get growth => _strings['growth'] ?? 'Growth';

  // Home Screen
  String get goodMorning => _strings['good_morning'] ?? 'Good Morning';
  String get goodAfternoon => _strings['good_afternoon'] ?? 'Good Afternoon';
  String get goodEvening => _strings['good_evening'] ?? 'Good Evening';
  String get upcomingReminders => _strings['upcoming_reminders'] ?? 'Upcoming Reminders';
  String get noUpcomingReminders => _strings['no_upcoming_reminders'] ?? 'No upcoming reminders';
  String get plantsNeedingWater => _strings['plants_needing_water'] ?? 'Plants needing water';
  String get totalPlants => _strings['total_plants'] ?? 'Total Plants';
  String get quickActions => _strings['quick_actions'] ?? 'Quick Actions';

  // Plant Screen
  String get addPlant => _strings['add_plant'] ?? 'Add Plant';
  String get editPlant => _strings['edit_plant'] ?? 'Edit Plant';
  String get plantName => _strings['plant_name'] ?? 'Plant Name';
  String get plantNameHint => _strings['plant_name_hint'] ?? 'e.g., Monstera';
  String get species => _strings['species'] ?? 'Species';
  String get speciesHint => _strings['species_hint'] ?? 'Select or enter species';
  String get room => _strings['room'] ?? 'Room';
  String get roomHint => _strings['room_hint'] ?? 'e.g., Living Room, Kitchen';
  String get addRoom => _strings['add_room'] ?? 'Add Room';
  String get lightCondition => _strings['light_condition'] ?? 'Light Condition';
  String get lightDirect => _strings['light_direct'] ?? 'Direct';
  String get lightIndirect => _strings['light_indirect'] ?? 'Indirect';
  String get lightLow => _strings['light_low'] ?? 'Low';
  String get plantStatus => _strings['plant_status'] ?? 'Status';
  String get statusHealthy => _strings['status_healthy'] ?? 'Healthy';
  String get statusStressed => _strings['status_stressed'] ?? 'Stressed';
  String get statusDormant => _strings['status_dormant'] ?? 'Dormant';
  String get statusRecovering => _strings['status_recovering'] ?? 'Recovering';
  String get notes => _strings['notes'] ?? 'Notes';
  String get notesHint => _strings['notes_hint'] ?? 'Add notes about your plant...';
  String get deletePlant => _strings['delete_plant'] ?? 'Delete Plant';
  String get deletePlantConfirm => _strings['delete_plant_confirm'] ?? 'Are you sure you want to delete this plant? All associated data will be lost.';

  // Reminder Screen
  String get addReminder => _strings['add_reminder'] ?? 'Add Reminder';
  String get editReminder => _strings['edit_reminder'] ?? 'Edit Reminder';
  String get reminderType => _strings['reminder_type'] ?? 'Reminder Type';
  String get typeWatering => _strings['type_watering'] ?? 'Watering';
  String get typeFertilizing => _strings['type_fertilizing'] ?? 'Fertilizing';
  String get typeRepotting => _strings['type_repotting'] ?? 'Repotting';
  String get typeCleaning => _strings['type_cleaning'] ?? 'Cleaning Leaves';
  String get typePruning => _strings['type_pruning'] ?? 'Pruning';
  String get typeMisting => _strings['type_misting'] ?? 'Misting';
  String get reminderFrequency => _strings['reminder_frequency'] ?? 'Frequency';
  String get reminderTime => _strings['reminder_time'] ?? 'Time';
  String get reminderEnabled => _strings['reminder_enabled'] ?? 'Reminder Enabled';
  String get everyDay => _strings['every_day'] ?? 'Every day';
  String get everyWeek => _strings['every_week'] ?? 'Every week';
  String get every2Weeks => _strings['every_2_weeks'] ?? 'Every 2 weeks';
  String get everyMonth => _strings['every_month'] ?? 'Every month';
  String get deleteReminder => _strings['delete_reminder'] ?? 'Delete Reminder';
  String get deleteReminderConfirm => _strings['delete_reminder_confirm'] ?? 'Are you sure you want to delete this reminder?';
  String get nextReminder => _strings['next_reminder'] ?? 'Next reminder';
  String get overdue => _strings['overdue'] ?? 'Overdue';
  String get today => _strings['today'] ?? 'Today';
  String get tomorrow => _strings['tomorrow'] ?? 'Tomorrow';

  // Growth Screen
  String get addGrowthEntry => _strings['add_growth_entry'] ?? 'Add Growth Entry';
  String get growthPhoto => _strings['growth_photo'] ?? 'Growth Photo';
  String get growthNote => _strings['growth_note'] ?? 'Growth Note';
  String get height => _strings['height'] ?? 'Height';
  String get heightHint => _strings['height_hint'] ?? 'e.g., 30 cm';
  String get newLeaves => _strings['new_leaves'] ?? 'New Leaves';
  String get healthRating => _strings['health_rating'] ?? 'Health Rating';
  String get deleteEntry => _strings['delete_entry'] ?? 'Delete Entry';
  String get deleteEntryConfirm => _strings['delete_entry_confirm'] ?? 'Are you sure you want to delete this entry?';
  String get growthTimeline => _strings['growth_timeline'] ?? 'Growth Timeline';
  String get noGrowthEntries => _strings['no_growth_entries'] ?? 'No growth entries yet';
  String get addFirstPhoto => _strings['add_first_photo'] ?? 'Add your first photo!';

  // Settings Screen
  String get generalSettings => _strings['general_settings'] ?? 'General Settings';
  String get theme => _strings['theme'] ?? 'Theme';
  String get themeSystem => _strings['theme_system'] ?? 'System';
  String get themeLight => _strings['theme_light'] ?? 'Light';
  String get themeDark => _strings['theme_dark'] ?? 'Dark';
  String get languageLabel => _strings['language'] ?? 'Language';
  String get notifications => _strings['notifications'] ?? 'Notifications';
  String get notificationSound => _strings['notification_sound'] ?? 'Notification Sound';
  String get notificationEnabled => _strings['notification_enabled'] ?? 'Notifications Enabled';
  String get dataManagement => _strings['data_management'] ?? 'Data Management';
  String get exportData => _strings['export_data'] ?? 'Export Data';
  String get exportSuccess => _strings['export_success'] ?? 'Data exported successfully';
  String get exportError => _strings['export_error'] ?? 'Error during export';
  String get importData => _strings['import_data'] ?? 'Import Data';
  String get importSuccess => _strings['import_success'] ?? 'Data imported successfully';
  String get importError => _strings['import_error'] ?? 'Error during import';
  String get clearData => _strings['clear_data'] ?? 'Clear All Data';
  String get clearDataConfirm => _strings['clear_data_confirm'] ?? 'Are you sure? This action is irreversible.';
  String get dataCleared => _strings['data_cleared'] ?? 'Data cleared';
  String get about => _strings['about'] ?? 'About';
  String get version => _strings['version'] ?? 'Version';
  String get license => _strings['license'] ?? 'MIT License';
  String get github => _strings['github'] ?? 'GitHub';
  String get privacyPolicy => _strings['privacy_policy'] ?? 'Privacy Policy';
  String get privacyNote => _strings['privacy_note'] ?? 'All data stays on your device. No data is sent to external servers.';

  // Common
  String get save => _strings['save'] ?? 'Save';
  String get cancel => _strings['cancel'] ?? 'Cancel';
  String get delete => _strings['delete'] ?? 'Delete';
  String get edit => _strings['edit'] ?? 'Edit';
  String get add => _strings['add'] ?? 'Add';
  String get done => _strings['done'] ?? 'Done';
  String get ok => _strings['ok'] ?? 'OK';
  String get yes => _strings['yes'] ?? 'Yes';
  String get no => _strings['no'] ?? 'No';
  String get search => _strings['search'] ?? 'Search';
  String get searchHint => _strings['search_hint'] ?? 'Search plants...';
  String get sortBy => _strings['sort_by'] ?? 'Sort by';
  String get sortName => _strings['sort_name'] ?? 'Name';
  String get sortLastWatered => _strings['sort_last_watered'] ?? 'Last Watered';
  String get sortRecentlyAdded => _strings['sort_recently_added'] ?? 'Recently Added';
  String get filter => _strings['filter'] ?? 'Filter';
  String get filterByRoom => _strings['filter_by_room'] ?? 'Filter by Room';
  String get allRooms => _strings['all_rooms'] ?? 'All Rooms';
  String get noPlants => _strings['no_plants'] ?? 'No plants yet';
  String get addFirstPlant => _strings['add_first_plant'] ?? 'Add your first plant!';
  String get noReminders => _strings['no_reminders'] ?? 'No reminders';
  String get loading => _strings['loading'] ?? 'Loading...';
  String get error => _strings['error'] ?? 'Error';
  String get retry => _strings['retry'] ?? 'Retry';
  String get photo => _strings['photo'] ?? 'Photo';
  String get takePhoto => _strings['take_photo'] ?? 'Take Photo';
  String get chooseFromGallery => _strings['choose_from_gallery'] ?? 'Choose from Gallery';
  String get removePhoto => _strings['remove_photo'] ?? 'Remove Photo';
  String get permissionDenied => _strings['permission_denied'] ?? 'Permission denied';
  String get permissionCamera => _strings['permission_camera'] ?? 'Camera permission required';
  String get permissionStorage => _strings['permission_storage'] ?? 'Storage permission required';
  String get permissionPhotos => _strings['permission_photos'] ?? 'Photos permission required';

  // Plant Types
  String get difficultyEasy => _strings['difficulty_easy'] ?? 'Easy';
  String get difficultyMedium => _strings['difficulty_medium'] ?? 'Medium';
  String get difficultyHard => _strings['difficulty_hard'] ?? 'Hard';
  String get plantTypeLightIndirectBright => _strings['plant_type_light_indirect_bright'] ?? 'Bright Indirect';
  String get plantTypeLightIndirect => _strings['plant_type_light_indirect'] ?? 'Indirect';
  String get plantTypeLightDirect => _strings['plant_type_light_direct'] ?? 'Direct';
  String get plantTypeLightLow => _strings['plant_type_light_low'] ?? 'Low';
  String get humidityLow => _strings['humidity_low'] ?? 'Low';
  String get humidityMedium => _strings['humidity_medium'] ?? 'Medium';
  String get humidityHigh => _strings['humidity_high'] ?? 'High';
  String get wateringDays => _strings['watering_days'] ?? 'Every %d days';

  // Export
  String get exportFormat => _strings['export_format'] ?? 'Export Format';
  String get exportJSON => _strings['export_json'] ?? 'JSON';
  String get exportCSV => _strings['export_csv'] ?? 'CSV';
  String get exportIncludePhotos => _strings['export_include_photos'] ?? 'Include Photos';
  String get exportPreparing => _strings['export_preparing'] ?? 'Preparing export...';
  String get exportShare => _strings['export_share'] ?? 'Share Export';

  // Vacation Mode
  String get vacationMode => _strings['vacation_mode'] ?? 'Vacation Mode';
  String get vacationStart => _strings['vacation_start'] ?? 'Start Date';
  String get vacationEnd => _strings['vacation_end'] ?? 'End Date';
  String get vacationActive => _strings['vacation_active'] ?? 'Vacation Mode Active';
  String get vacationReminder => _strings['vacation_reminder'] ?? 'Vacation reminder set';

  // Gamification
  String get achievements => _strings['achievements'] ?? 'Achievements';
  String get level => _strings['level'] ?? 'Level';
  String get experience => _strings['experience'] ?? 'Experience';
  String get streak => _strings['streak'] ?? 'Streak';
  String get currentStreak => _strings['current_streak'] ?? 'Current Streak';
  String get longestStreak => _strings['longest_streak'] ?? 'Longest Streak';
  String get days => _strings['days'] ?? 'days';
  String get points => _strings['points'] ?? 'Points';

  // Weather
  String get weatherInsights => _strings['weather_insights'] ?? 'Weather Insights';
  String get delayWatering => _strings['delay_watering'] ?? 'Delay Watering';
  String get waterYourPlants => _strings['water_your_plants'] ?? 'Water Your Plants';
  String get increaseHumidity => _strings['increase_humidity'] ?? 'Increase Humidity';
  String get protectFromWeather => _strings['protect_from_weather'] ?? 'Protect from Weather';
}

/// English strings (default)
const Map<String, String> _englishStrings = {
  'app_name': 'Linfa',
  'app_tagline': 'Your Plant Care Assistant',
  'home': 'Home',
  'my_plants': 'My Plants',
  'reminders': 'Reminders',
  'settings': 'Settings',
  'analytics': 'Analytics',
  'growth': 'Growth',
  'good_morning': 'Good Morning',
  'good_afternoon': 'Good Afternoon',
  'good_evening': 'Good Evening',
  'upcoming_reminders': 'Upcoming Reminders',
  'no_upcoming_reminders': 'No upcoming reminders',
  'plants_needing_water': 'Plants needing water',
  'total_plants': 'Total Plants',
  'quick_actions': 'Quick Actions',
  'add_plant': 'Add Plant',
  'edit_plant': 'Edit Plant',
  'plant_name': 'Plant Name',
  'plant_name_hint': 'e.g., Monstera',
  'species': 'Species',
  'species_hint': 'Select or enter species',
  'room': 'Room',
  'room_hint': 'e.g., Living Room, Kitchen',
  'add_room': 'Add Room',
  'light_condition': 'Light Condition',
  'light_direct': 'Direct',
  'light_indirect': 'Indirect',
  'light_low': 'Low',
  'plant_status': 'Status',
  'status_healthy': 'Healthy',
  'status_stressed': 'Stressed',
  'status_dormant': 'Dormant',
  'status_recovering': 'Recovering',
  'notes': 'Notes',
  'notes_hint': 'Add notes about your plant...',
  'delete_plant': 'Delete Plant',
  'delete_plant_confirm': 'Are you sure you want to delete this plant? All associated data will be lost.',
  'add_reminder': 'Add Reminder',
  'edit_reminder': 'Edit Reminder',
  'reminder_type': 'Reminder Type',
  'type_watering': 'Watering',
  'type_fertilizing': 'Fertilizing',
  'type_repotting': 'Repotting',
  'type_cleaning': 'Cleaning Leaves',
  'type_pruning': 'Pruning',
  'type_misting': 'Misting',
  'reminder_frequency': 'Frequency',
  'reminder_time': 'Time',
  'reminder_enabled': 'Reminder Enabled',
  'every_day': 'Every day',
  'every_week': 'Every week',
  'every_2_weeks': 'Every 2 weeks',
  'every_month': 'Every month',
  'delete_reminder': 'Delete Reminder',
  'delete_reminder_confirm': 'Are you sure you want to delete this reminder?',
  'next_reminder': 'Next reminder',
  'overdue': 'Overdue',
  'today': 'Today',
  'tomorrow': 'Tomorrow',
  'add_growth_entry': 'Add Growth Entry',
  'growth_photo': 'Growth Photo',
  'growth_note': 'Growth Note',
  'height': 'Height',
  'height_hint': 'e.g., 30 cm',
  'new_leaves': 'New Leaves',
  'health_rating': 'Health Rating',
  'delete_entry': 'Delete Entry',
  'delete_entry_confirm': 'Are you sure you want to delete this entry?',
  'growth_timeline': 'Growth Timeline',
  'no_growth_entries': 'No growth entries yet',
  'add_first_photo': 'Add your first photo!',
  'general_settings': 'General Settings',
  'theme': 'Theme',
  'theme_system': 'System',
  'theme_light': 'Light',
  'theme_dark': 'Dark',
  'language': 'Language',
  'notifications': 'Notifications',
  'notification_sound': 'Notification Sound',
  'notification_enabled': 'Notifications Enabled',
  'data_management': 'Data Management',
  'export_data': 'Export Data',
  'export_success': 'Data exported successfully',
  'export_error': 'Error during export',
  'import_data': 'Import Data',
  'import_success': 'Data imported successfully',
  'import_error': 'Error during import',
  'clear_data': 'Clear All Data',
  'clear_data_confirm': 'Are you sure? This action is irreversible.',
  'data_cleared': 'Data cleared',
  'about': 'About',
  'version': 'Version',
  'license': 'MIT License',
  'github': 'GitHub',
  'privacy_policy': 'Privacy Policy',
  'privacy_note': 'All data stays on your device. No data is sent to external servers.',
  'save': 'Save',
  'cancel': 'Cancel',
  'delete': 'Delete',
  'edit': 'Edit',
  'add': 'Add',
  'done': 'Done',
  'ok': 'OK',
  'yes': 'Yes',
  'no': 'No',
  'search': 'Search',
  'search_hint': 'Search plants...',
  'sort_by': 'Sort by',
  'sort_name': 'Name',
  'sort_last_watered': 'Last Watered',
  'sort_recently_added': 'Recently Added',
  'filter': 'Filter',
  'filter_by_room': 'Filter by Room',
  'all_rooms': 'All Rooms',
  'no_plants': 'No plants yet',
  'add_first_plant': 'Add your first plant!',
  'no_reminders': 'No reminders',
  'loading': 'Loading...',
  'error': 'Error',
  'retry': 'Retry',
  'photo': 'Photo',
  'take_photo': 'Take Photo',
  'choose_from_gallery': 'Choose from Gallery',
  'remove_photo': 'Remove Photo',
  'permission_denied': 'Permission denied',
  'permission_camera': 'Camera permission required',
  'permission_storage': 'Storage permission required',
  'permission_photos': 'Photos permission required',
  'difficulty_easy': 'Easy',
  'difficulty_medium': 'Medium',
  'difficulty_hard': 'Hard',
  'plant_type_light_indirect_bright': 'Bright Indirect',
  'plant_type_light_indirect': 'Indirect',
  'plant_type_light_direct': 'Direct',
  'plant_type_light_low': 'Low',
  'humidity_low': 'Low',
  'humidity_medium': 'Medium',
  'humidity_high': 'High',
  'watering_days': 'Every %d days',
  'export_format': 'Export Format',
  'export_json': 'JSON',
  'export_csv': 'CSV',
  'export_include_photos': 'Include Photos',
  'export_preparing': 'Preparing export...',
  'export_share': 'Share Export',
  'vacation_mode': 'Vacation Mode',
  'vacation_start': 'Start Date',
  'vacation_end': 'End Date',
  'vacation_active': 'Vacation Mode Active',
  'vacation_reminder': 'Vacation reminder set',
  'achievements': 'Achievements',
  'level': 'Level',
  'experience': 'Experience',
  'streak': 'Streak',
  'current_streak': 'Current Streak',
  'longest_streak': 'Longest Streak',
  'days': 'days',
  'points': 'Points',
  'weather_insights': 'Weather Insights',
  'delay_watering': 'Delay Watering',
  'water_your_plants': 'Water Your Plants',
  'increase_humidity': 'Increase Humidity',
  'protect_from_weather': 'Protect from Weather',
};

/// Italian strings
const Map<String, String> _italianStrings = {
  'app_name': 'Linfa',
  'app_tagline': 'Il Tuo Assistente per le Piante Domestiche',
  'home': 'Home',
  'my_plants': 'Le Mie Piante',
  'reminders': 'Promemoria',
  'settings': 'Impostazioni',
  // ... (would include all Italian translations)
};