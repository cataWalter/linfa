import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:linfa/core/utils/date.dart';

void main() {
  setUpAll(() async {
    await initializeDateFormatting('it_IT', null);
  });

  group('LinfaDateUtils', () {
    group('formatFullDate', () {
      test('should format date in Italian long format', () {
        final date = DateTime(2024, 3, 15);
        expect(LinfaDateUtils.formatFullDate(date), '15 marzo 2024');
      });
    });

    group('formatShortDate', () {
      test('should format date in dd/MM/yyyy format', () {
        final date = DateTime(2024, 3, 15);
        expect(LinfaDateUtils.formatShortDate(date), '15/03/2024');
      });

      test('should pad single digit months and days', () {
        final date = DateTime(2024, 1, 5);
        expect(LinfaDateUtils.formatShortDate(date), '05/01/2024');
      });
    });

    group('formatTime', () {
      test('should format time in HH:mm format', () {
        final date = DateTime(2024, 3, 15, 14, 30);
        expect(LinfaDateUtils.formatTime(date), '14:30');
      });

      test('should pad single digit hours and minutes', () {
        final date = DateTime(2024, 3, 15, 9, 5);
        expect(LinfaDateUtils.formatTime(date), '09:05');
      });
    });

    group('formatDateTime', () {
      test('should format date and time', () {
        final date = DateTime(2024, 3, 15, 14, 30);
        expect(LinfaDateUtils.formatDateTime(date), '15/03/2024 14:30');
      });
    });

    group('formatMonthYear', () {
      test('should format month and year in Italian', () {
        final date = DateTime(2024, 3, 15);
        expect(LinfaDateUtils.formatMonthYear(date), 'marzo 2024');
      });
    });

    group('formatApiDate', () {
      test('should format date in yyyy-MM-dd format', () {
        final date = DateTime(2024, 3, 15);
        expect(LinfaDateUtils.formatApiDate(date), '2024-03-15');
      });
    });

    group('getRelativeTime', () {
      test('should return Adesso for recent dates', () {
        final date = DateTime.now().subtract(const Duration(seconds: 30));
        expect(LinfaDateUtils.getRelativeTime(date), 'Adesso');
      });

      test('should return minutes ago', () {
        final date = DateTime.now().subtract(const Duration(minutes: 15));
        expect(LinfaDateUtils.getRelativeTime(date), '15 min fa');
      });

      test('should return hours ago', () {
        final date = DateTime.now().subtract(const Duration(hours: 5));
        expect(LinfaDateUtils.getRelativeTime(date), '5 ore fa');
      });

      test('should return Ieri for 1 day ago', () {
        final date = DateTime.now().subtract(const Duration(days: 1));
        expect(LinfaDateUtils.getRelativeTime(date), 'Ieri');
      });

      test('should return days ago for less than a week', () {
        final date = DateTime.now().subtract(const Duration(days: 4));
        expect(LinfaDateUtils.getRelativeTime(date), '4 giorni fa');
      });

      test('should return weeks ago for less than a month', () {
        final date = DateTime.now().subtract(const Duration(days: 14));
        expect(LinfaDateUtils.getRelativeTime(date), '2 settimane fa');
      });

      test('should return singular settimana for 1 week', () {
        final date = DateTime.now().subtract(const Duration(days: 7));
        expect(LinfaDateUtils.getRelativeTime(date), '1 settimana fa');
      });

      test('should return short date for older than a month', () {
        final date = DateTime(2024, 1, 15);
        expect(LinfaDateUtils.getRelativeTime(date), '15/01/2024');
      });
    });

    group('getReminderDueDate', () {
      test('should return Oggi for today', () {
        final today = DateTime.now();
        final date = DateTime(today.year, today.month, today.day);
        expect(LinfaDateUtils.getReminderDueDate(date), 'Oggi');
      });

      test('should return Domani for tomorrow', () {
        final tomorrow = DateTime.now().add(const Duration(days: 1));
        final date = DateTime(tomorrow.year, tomorrow.month, tomorrow.day);
        expect(LinfaDateUtils.getReminderDueDate(date), 'Domani');
      });

      test('should return Tra X giorni for future dates within a week', () {
        final future = DateTime.now().add(const Duration(days: 3));
        final date = DateTime(future.year, future.month, future.day);
        expect(LinfaDateUtils.getReminderDueDate(date), 'Tra 3 giorni');
      });

      test('should return short date for future dates beyond a week', () {
        final future = DateTime.now().add(const Duration(days: 14));
        expect(
          LinfaDateUtils.getReminderDueDate(future),
          LinfaDateUtils.formatShortDate(future),
        );
      });

      test('should return Scaduto for past dates', () {
        final past = DateTime.now().subtract(const Duration(days: 2));
        final date = DateTime(past.year, past.month, past.day);
        expect(LinfaDateUtils.getReminderDueDate(date), 'Scaduto da 2 giorni');
      });

      test('should return singular giorno for 1 day overdue', () {
        final past = DateTime.now().subtract(const Duration(days: 1));
        final date = DateTime(past.year, past.month, past.day);
        expect(LinfaDateUtils.getReminderDueDate(date), 'Scaduto da 1 giorno');
      });
    });

    group('getGreeting', () {
      test('should return Buongiorno in the morning', () {
        final morning = DateTime(2024, 3, 15, 10);
        expect(
          LinfaDateUtils.getGreeting(),
          isIn(['Buongiorno', 'Buon pomeriggio', 'Buonasera']),
        );
      });
    });

    group('daysSince', () {
      test('should return 0 for today', () {
        final today = DateTime.now();
        final date = DateTime(today.year, today.month, today.day);
        expect(LinfaDateUtils.daysSince(date), 0);
      });

      test('should return positive number for past dates', () {
        final past = DateTime.now().subtract(const Duration(days: 5));
        final date = DateTime(past.year, past.month, past.day);
        expect(LinfaDateUtils.daysSince(date), 5);
      });
    });

    group('daysUntil', () {
      test('should return 0 for today', () {
        final today = DateTime.now();
        final date = DateTime(today.year, today.month, today.day);
        expect(LinfaDateUtils.daysUntil(date), 0);
      });

      test('should return positive number for future dates', () {
        final future = DateTime.now().add(const Duration(days: 7));
        final date = DateTime(future.year, future.month, future.day);
        expect(LinfaDateUtils.daysUntil(date), 7);
      });

      test('should return negative number for past dates', () {
        final past = DateTime.now().subtract(const Duration(days: 3));
        final date = DateTime(past.year, past.month, past.day);
        expect(LinfaDateUtils.daysUntil(date), -3);
      });
    });

    group('isToday', () {
      test('should return true for today', () {
        final today = DateTime.now();
        final date = DateTime(today.year, today.month, today.day);
        expect(LinfaDateUtils.isToday(date), true);
      });

      test('should return false for yesterday', () {
        final yesterday = DateTime.now().subtract(const Duration(days: 1));
        expect(LinfaDateUtils.isToday(yesterday), false);
      });

      test('should return false for tomorrow', () {
        final tomorrow = DateTime.now().add(const Duration(days: 1));
        expect(LinfaDateUtils.isToday(tomorrow), false);
      });
    });

    group('isTomorrow', () {
      test('should return true for tomorrow', () {
        final tomorrow = DateTime.now().add(const Duration(days: 1));
        final date = DateTime(tomorrow.year, tomorrow.month, tomorrow.day);
        expect(LinfaDateUtils.isTomorrow(date), true);
      });

      test('should return false for today', () {
        final today = DateTime.now();
        final date = DateTime(today.year, today.month, today.day);
        expect(LinfaDateUtils.isTomorrow(date), false);
      });

      test('should return false for day after tomorrow', () {
        final dayAfter = DateTime.now().add(const Duration(days: 2));
        expect(LinfaDateUtils.isTomorrow(dayAfter), false);
      });
    });

    group('isPast', () {
      test('should return true for yesterday', () {
        final yesterday = DateTime.now().subtract(const Duration(days: 1));
        expect(LinfaDateUtils.isPast(yesterday), true);
      });

      test('should return false for today', () {
        final today = DateTime.now();
        final date = DateTime(today.year, today.month, today.day);
        expect(LinfaDateUtils.isPast(date), false);
      });

      test('should return false for tomorrow', () {
        final tomorrow = DateTime.now().add(const Duration(days: 1));
        expect(LinfaDateUtils.isPast(tomorrow), false);
      });
    });

    group('getNextOccurrence', () {
      test('should add days to date', () {
        final date = DateTime(2024, 3, 15);
        final result = LinfaDateUtils.getNextOccurrence(date, 7);
        expect(result, DateTime(2024, 3, 22));
      });

      test('should handle 0 days', () {
        final date = DateTime(2024, 3, 15);
        final result = LinfaDateUtils.getNextOccurrence(date, 0);
        expect(result, date);
      });
    });

    group('parseDate', () {
      test('should parse valid date string', () {
        final result = LinfaDateUtils.parseDate('2024-03-15');
        expect(result, DateTime(2024, 3, 15));
      });

      test('should return null for null input', () {
        expect(LinfaDateUtils.parseDate(null), isNull);
      });

      test('should return null for empty string', () {
        expect(LinfaDateUtils.parseDate(''), isNull);
      });

      test('should return null for invalid format', () {
        expect(LinfaDateUtils.parseDate('invalid'), isNull);
      });
    });
  });
}
