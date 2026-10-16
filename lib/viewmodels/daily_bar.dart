/// A single bar in the weekly steps chart.
class DailyBar {
  const DailyBar({
    required this.label,
    required this.value,
    required this.date,
  });

  final String label;
  final double value;
  final DateTime date;
}
