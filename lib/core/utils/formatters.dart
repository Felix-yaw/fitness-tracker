/// Lightweight formatting helpers (no `intl` dependency).
abstract final class Formatters {
  static const List<String> _months = <String>[
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  static const List<String> _monthsShort = <String>[
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  static const List<String> _weekdays = <String>[
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  static const List<String> _weekdaysShort = <String>[
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun',
  ];

  /// `10.6k`, `1.2m`, or the plain number below 1000.
  static String compactNumber(num value, {int decimals = 1}) {
    if (value >= 1000000) {
      return '${(value / 1000000).toStringAsFixed(decimals)}m';
    }
    if (value >= 1000) {
      final double k = value / 1000;
      final String text = k >= 100
          ? k.toStringAsFixed(0)
          : k.toStringAsFixed(decimals);
      return '$text' 'k';
    }
    return value.toStringAsFixed(0);
  }

  static String steps(int value) => '${compactNumber(value)} steps';

  static String distanceKm(double km) => '${km.toStringAsFixed(1)} km';

  static String calories(int value) => '$value kcal';

  /// `45 min`, `1h 05m`.
  static String duration(Duration d) {
    final int hours = d.inHours;
    final int minutes = d.inMinutes.remainder(60);
    if (hours == 0) return '$minutes min';
    return '${hours}h ${minutes.toString().padLeft(2, '0')}m';
  }

  static String monthShort(DateTime date) => _monthsShort[date.month - 1];

  static String month(DateTime date) => _months[date.month - 1];

  static String dayOfWeekShort(DateTime date) =>
      _weekdaysShort[date.weekday - 1];

  /// e.g. `Wednesday, January 12`.
  static String fullDate(DateTime date) =>
      '${_weekdays[date.weekday - 1]}, ${_months[date.month - 1]} ${date.day}';

  /// e.g. `Jan 12 - Jan 19`.
  static String dateRange(DateTime start, DateTime end) =>
      '${monthShort(start)} ${start.day} - ${monthShort(end)} ${end.day}';

  /// e.g. `10:30 AM`.
  static String time(DateTime date) {
    final int hour12 = date.hour % 12 == 0 ? 12 : date.hour % 12;
    final String minute = date.minute.toString().padLeft(2, '0');
    final String period = date.hour < 12 ? 'AM' : 'PM';
    return '$hour12:$minute $period';
  }

  /// e.g. `10:30 AM - 12:30 PM`.
  static String timeRange(DateTime start, DateTime end) =>
      '${time(start)} - ${time(end)}';
}
