import '../core/utils/formatters.dart';
import '../data/models/activity.dart';
import '../data/models/weather.dart';
import 'daily_bar.dart';
import 'view_model.dart';

/// Backs the Statistics screen.
class StatsViewModel extends ViewModel {
  StatsViewModel(super.repository);

  /// Mon → Sun (rolling last 7 days) step totals.
  List<DailyBar> get weeklyBars {
    final DateTime today = ViewModel.startOfDay(DateTime.now());
    return List<DailyBar>.generate(7, (int i) {
      final DateTime day = today.subtract(Duration(days: 6 - i));
      return DailyBar(
        label: Formatters.dayOfWeekShort(day),
        value: ViewModel.sumSteps(activitiesOn(day)).toDouble(),
        date: day,
      );
    });
  }

  List<String> get weeklyValueLabels => weeklyBars
      .map(
        (DailyBar b) =>
            b.value == 0 ? '' : Formatters.compactNumber(b.value),
      )
      .toList();

  int get weeklySteps =>
      weeklyBars.fold<double>(0, (double s, DailyBar b) => s + b.value).round();

  int get weeklyGoal => repository.weeklyStepGoal.round();

  double get weeklyPercent =>
      weeklyGoal == 0 ? 0 : (weeklySteps / weeklyGoal).clamp(0.0, 1.0);

  DailyBar? get bestDay {
    if (weeklyBars.isEmpty) return null;
    return weeklyBars.reduce(
      (DailyBar a, DailyBar b) => a.value >= b.value ? a : b,
    );
  }

  /// Average effort score (0–1) across the last 7 days.
  double get intensity {
    final DateTime today = ViewModel.startOfDay(DateTime.now());
    final List<Activity> recent = repository.activities
        .where(
          (Activity a) =>
              !ViewModel.startOfDay(a.date).isBefore(
                today.subtract(const Duration(days: 6)),
              ),
        )
        .toList(growable: false);
    return _averageIntensity(recent);
  }

  double _averageIntensity(List<Activity> list) {
    if (list.isEmpty) return 0;
    final double total = list.fold<double>(
      0,
      (double s, Activity a) => s + a.intensity,
    );
    return total / list.length;
  }

  double get intensityDeltaPercent {
    final DateTime today = ViewModel.startOfDay(DateTime.now());
    final double thisWeek = _averageIntensity(
      repository.activities
          .where(
            (Activity a) =>
                !ViewModel.startOfDay(a.date).isBefore(
                  today.subtract(const Duration(days: 6)),
                ),
          )
          .toList(growable: false),
    );
    final double lastWeek = _averageIntensity(
      repository.activities
          .where((Activity a) {
            final DateTime day = ViewModel.startOfDay(a.date);
            return day.isBefore(today.subtract(const Duration(days: 6))) &&
                !day.isBefore(today.subtract(const Duration(days: 13)));
          })
          .toList(growable: false),
    );
    if (lastWeek == 0) return 0;
    return (thisWeek - lastWeek) / lastWeek * 100;
  }

  int get activeMinutes {
    final DateTime today = ViewModel.startOfDay(DateTime.now());
    return repository.activities
        .where(
          (Activity a) =>
              !ViewModel.startOfDay(a.date).isBefore(
                today.subtract(const Duration(days: 6)),
              ),
        )
        .fold<int>(0, (int s, Activity a) => s + a.duration.inMinutes);
  }

  Weather get weather => repository.weather;
}
