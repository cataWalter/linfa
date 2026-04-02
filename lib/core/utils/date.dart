import 'package:intl/intl.dart';

/// Date utility functions for Linfa
class LinfaDateUtils {
  LinfaDateUtils._();

  static final DateFormat _fullDateFormat = DateFormat('dd MMMM yyyy', 'it_IT');
  static final DateFormat _shortDateFormat = DateFormat('dd/MM/yyyy');
  static final DateFormat _timeFormat = DateFormat('HH:mm');
  static final DateFormat _dateTimeFormat = DateFormat('dd/MM/yyyy HH:mm');
  static final DateFormat _monthYearFormat = DateFormat('MMMM yyyy', 'it_IT');
  static final DateFormat _apiDateFormat = DateFormat('yyyy-MM-dd');

  /// Format a date to full format (e.g., "15 Gennaio 2024")
  static String formatFullDate(DateTime date) {
    return _fullDateFormat.format(date);
  }

  /// Format a date to short format (e.g., "15/01/2024")
  static String formatShortDate(DateTime date) {
    return _shortDateFormat.format(date);
  }

  /// Format a time (e.g., "14:30")
  static String formatTime(DateTime date) {
    return _timeFormat.format(date);
  }

  /// Format a date and time (e.g., "15/01/2024 14:30")
  static String formatDateTime(DateTime date) {
    return _dateTimeFormat.format(date);
  }

  /// Format month and year (e.g., "Gennaio 2024")
  static String formatMonthYear(DateTime date) {
    return _monthYearFormat.format(date);
  }

  /// Format date for API/storage (e.g., "2024-01-15")
  static String formatApiDate(DateTime date) {
    return _apiDateFormat.format(date);
  }

  /// Get relative time description in Italian
  static String getRelativeTime(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inSeconds < 60) {
      return 'Adesso';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} min fa';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} ore fa';
    } else if (difference.inDays == 1) {
      return 'Ieri';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} giorni fa';
    } else if (difference.inDays < 30) {
      final weeks = (difference.inDays / 7).floor();
      return '$weeks settiman${weeks == 1 ? 'a' : 'e'} fa';
    } else {
      return formatShortDate(date);
    }
  }

  /// Get reminder due date description
  static String getReminderDueDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final dueDate = DateTime(date.year, date.month, date.day);
    final difference = dueDate.difference(today).inDays;

    if (difference < 0) {
      return 'Scaduto da ${-difference} giorn${-difference == 1 ? 'o' : 'i'}';
    } else if (difference == 0) {
      return 'Oggi';
    } else if (difference == 1) {
      return 'Domani';
    } else if (difference < 7) {
      return 'Tra $difference giorni';
    } else {
      return formatShortDate(date);
    }
  }

  /// Get greeting based on time of day
  static String getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Buongiorno';
    } else if (hour < 18) {
      return 'Buon pomeriggio';
    } else {
      return 'Buonasera';
    }
  }

  /// Calculate days since a date
  static int daysSince(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final targetDate = DateTime(date.year, date.month, date.day);
    return today.difference(targetDate).inDays;
  }

  /// Calculate days until a date
  static int daysUntil(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final targetDate = DateTime(date.year, date.month, date.day);
    return targetDate.difference(today).inDays;
  }

  /// Check if a date is today
  static bool isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  /// Check if a date is tomorrow
  static bool isTomorrow(DateTime date) {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return date.year == tomorrow.year &&
        date.month == tomorrow.month &&
        date.day == tomorrow.day;
  }

  /// Check if a date is in the past
  static bool isPast(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final targetDate = DateTime(date.year, date.month, date.day);
    return targetDate.isBefore(today);
  }

  /// Get next occurrence based on frequency
  static DateTime getNextOccurrence(DateTime lastDate, int days) {
    return lastDate.add(Duration(days: days));
  }

  /// Parse date from string (API format)
  static DateTime? parseDate(String? dateString) {
    if (dateString == null || dateString.isEmpty) return null;
    try {
      return _apiDateFormat.parse(dateString);
    } catch (e) {
      return null;
    }
  }
}
