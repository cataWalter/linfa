import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:linfa/data/models/plant.dart';
import 'package:linfa/data/models/reminder.dart';
import 'package:linfa/core/constants/enums.dart';

/// Utility class for UI testing
class UiTestUtils {
  /// Creates a test plant with customizable properties
  static Plant createTestPlant({
    int id = 1,
    String name = 'Test Plant',
    String? species = 'Testicus Plantus',
    String? room = 'Test Room',
    String? photoPath,
    LightCondition lightCondition = LightCondition.indirectBright,
    PlantStatus status = PlantStatus.healthy,
    DateTime? lastWatered,
    DateTime? lastFertilized,
    DateTime? lastMisted,
    String? notes,
  }) {
    return Plant()
      ..id = id
      ..name = name
      ..species = species
      ..room = room
      ..photoPath = photoPath
      ..lightCondition = lightCondition.name
      ..status = status.name
      ..lastWatered = lastWatered ?? DateTime.now().subtract(const Duration(days: 2))
      ..lastFertilized = lastFertilized
      ..lastMisted = lastMisted
      ..notes = notes
      ..createdAt = DateTime.now();
  }

  /// Creates a test reminder with customizable properties
  static Reminder createTestReminder({
    int id = 1,
    int? plantId = 1,
    ReminderType type = ReminderType.watering,
    int frequencyDays = 7,
    DateTime? time,
    bool enabled = true,
    DateTime? lastTriggered,
  }) {
    return Reminder()
      ..id = id
      ..plantId = plantId
      ..type = type.name
      ..frequencyDays = frequencyDays
      ..time = time ?? DateTime.now().setClock(DateTime.now())
      ..enabled = enabled
      ..lastTriggered = lastTriggered;
  }

  /// Creates a list of test plants
  static List<Plant> createTestPlantList({int count = 5}) {
    return List.generate(count, (index) {
      return createTestPlant(
        id: index + 1,
        name: 'Plant ${index + 1}',
        species: 'Species ${index + 1}',
      );
    });
  }

  /// Creates a list of test reminders
  static List<Reminder> createTestReminderList({int count = 3}) {
    return List.generate(count, (index) {
      return createTestReminder(
        id: index + 1,
        type: ReminderType.values[index % ReminderType.values.length],
      );
    });
  }

  /// Waits for an animation to complete
  static Future<void> waitForAnimation(WidgetTester tester) async {
    await tester.pumpAndSettle();
  }

  /// Taps on a widget and waits for animations
  static Future<void> tapAndSettle(WidgetTester tester, Finder finder) async {
    await tester.tap(finder);
    await tester.pumpAndSettle();
  }

  /// Enters text into a text field and waits
  static Future<void> enterTextAndSettle(
    WidgetTester tester,
    Finder finder,
    String text,
  ) async {
    await tester.enterText(finder, text);
    await tester.pumpAndSettle();
  }

  /// Drags to refresh and waits
  static Future<void> pullToRefresh(WidgetTester tester) async {
    await tester.drag(
      find.byType(RefreshIndicator),
      const Offset(0, 500),
    );
    await tester.pumpAndSettle();
  }

  /// Scrolls until a widget is found
  static Future<bool> scrollUntilFound(
    WidgetTester tester,
    Finder finder, {
    int maxScrolls = 10,
  }) async {
    for (int i = 0; i < maxScrolls; i++) {
      if (finder.evaluate().isNotEmpty) {
        return true;
      }
      await tester.drag(
        find.byType(SingleChildScrollView),
        const Offset(0, -500),
      );
      await tester.pump();
    }
    return false;
  }

  /// Verifies that a widget exists
  static void expectWidgetExists(WidgetTester tester, Finder finder) {
    expect(finder, findsOneWidget);
  }

  /// Verifies that a widget does not exist
  static void expectWidgetNotExists(WidgetTester tester, Finder finder) {
    expect(finder, findsNothing);
  }

  /// Verifies that multiple widgets exist
  static void expectWidgetsExist(WidgetTester tester, List<Finder> finders) {
    for (final finder in finders) {
      expect(finder, findsOneWidget);
    }
  }

  /// Gets the text from a Text widget
  static String? getTextFromWidget(WidgetTester tester, Finder finder) {
    if (finder.evaluate().isEmpty) return null;
    final textWidget = tester.widget<Text>(finder);
    return textWidget.data;
  }

  /// Checks if a widget is visible
  static bool isWidgetVisible(WidgetTester tester, Finder finder) {
    if (finder.evaluate().isEmpty) return false;
    final renderObject = tester.renderObject(finder);
    return renderObject.attached;
  }

  /// Waits for a widget to appear
  static Future<bool> waitForWidget(
    WidgetTester tester,
    Finder finder, {
    Duration timeout = const Duration(seconds: 5),
  }) async {
    final stopwatch = Stopwatch()..start();
    while (stopwatch.elapsed < timeout) {
      if (finder.evaluate().isNotEmpty) {
        return true;
      }
      await tester.pump();
    }
    return false;
  }

  /// Simulates app startup
  static Future<void> pumpApp(WidgetTester tester, Widget widget) async {
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
  }

  /// Creates a test provider scope wrapper
  static Widget createProviderScope({
    required Widget child,
    List<Override> overrides = const [],
  }) {
    return ProviderScope(
      overrides: overrides,
      child: child,
    );
  }

  /// Creates a test material app wrapper
  static Widget createMaterialApp({
    required Widget home,
    List<Override> overrides = const [],
  }) {
    return ProviderScope(
      overrides: overrides,
      child: MaterialApp(
        home: home,
      ),
    );
  }
}

/// Extension methods for WidgetTester to simplify testing
extension WidgetTesterExtensions on WidgetTester {
  /// Tap and pump and settle in one call
  Future<void> tapAndSettle(Finder finder) async {
    await tap(finder);
    await pumpAndSettle();
  }

  /// Enter text and pump and settle in one call
  Future<void> enterTextAndSettle(Finder finder, String text) async {
    await enterText(finder, text);
    await pumpAndSettle();
  }

  /// Drag and pump and settle in one call
  Future<void> dragAndSettle(Finder finder, Offset offset) async {
    await drag(finder, offset);
    await pumpAndSettle();
  }

  /// Check if a finder has any matches
  bool hasFinder(Finder finder) {
    return finder.evaluate().isNotEmpty;
  }

  /// Get all text from widgets matching a finder
  List<String> getAllText(Finder finder) {
    return finder
        .evaluate()
        .whereType<StatelessElement>()
        .where((element) => element.widget is Text)
        .map((element) => (element.widget as Text).data ?? '')
        .where((text) => text.isNotEmpty)
        .toList();
  }
}

/// Common finders for UI testing
class AppFinders {
  static Finder byText(String text) => find.text(text);
  static Finder byTextContaining(String pattern) => find.textContaining(pattern);
  static Finder byIcon(IconData icon) => find.byIcon(icon);
  static Finder byType(Type type) => find.byType(type);
  static Finder byKey(Key key) => find.byKey(key);
  static Finder byTooltip(String tooltip) => find.byTooltip(tooltip);

  // Common UI elements
  static Finder appBar() => find.byType(AppBar);
  static Finder scaffold() => find.byType(Scaffold);
  static Finder floatingActionButton() => find.byType(FloatingActionButton);
  static Finder bottomNavigationBar() => find.byType(BottomNavigationBar);
  static Finder drawer() => find.byType(Drawer);
  static Finder listView() => find.byType(ListView);
  static Finder gridView() => find.byType(GridView);
  static Finder singleChildScrollView() => find.byType(SingleChildScrollView);
  static Finder refreshIndicator() => find.byType(RefreshIndicator);
  static Finder progressDialog() => find.byType(ProgressDialog);
  static Finder snackBar() => find.byType(SnackBars);
  static Finder dialog() => find.byType(Dialog);
  static Finder alertDialog() => find.byType(AlertDialog);
}