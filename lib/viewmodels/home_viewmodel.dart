import '../core/utils/formatters.dart';
import '../data/models/activity.dart';
import 'activity_filter.dart';
import 'view_model.dart';

/// Backs the Home/dashboard screen.
class HomeViewModel extends ViewModel {
  HomeViewModel(super.repository);

  ActivityFilter _filter = ActivityFilter.all;

  ActivityFilter get filter => _filter;

  void setFilter(ActivityFilter filter) {
    if (_filter == filter) return;
    _filter = filter;
    notifyListeners();
  }

  String get userName => 'Miranda';

  int get todaySteps => ViewModel.sumSteps(activitiesOn(DateTime.now()));

  double get todayDistance => ViewModel.sumDistance(activitiesOn(DateTime.now()));

  int get todayCalories => ViewModel.sumCalories(activitiesOn(DateTime.now()));

  /// Steps for each of the last 7 days (oldest → newest).
  List<double> get last7DaySteps {
    final DateTime today = ViewModel.startOfDay(DateTime.now());
    return List<double>.generate(7, (int i) {
      final DateTime day = today.subtract(Duration(days: 6 - i));
      return ViewModel.sumSteps(activitiesOn(day)).toDouble();
    });
  }

  List<String> get last7DayLabels {
    final DateTime today = ViewModel.startOfDay(DateTime.now());
    return List<String>.generate(7, (int i) {
      final DateTime day = today.subtract(Duration(days: 6 - i));
      return Formatters.dayOfWeekShort(day);
    });
  }

  int get weeklySteps =>
      last7DaySteps.fold<double>(0, (double s, double v) => s + v).round();

  int get weeklyGoal => repository.weeklyStepGoal.round();

  double get weeklyPercent =>
      weeklyGoal == 0 ? 0 : (weeklySteps / weeklyGoal).clamp(0.0, 1.0);

  int get _previous7Steps {
    final DateTime today = ViewModel.startOfDay(DateTime.now());
    int total = 0;
    for (int i = 7; i < 14; i++) {
      total += ViewModel.sumSteps(activitiesOn(today.subtract(Duration(days: i))));
    }
    return total;
  }

  double get weeklyDeltaPercent {
    final int previous = _previous7Steps;
    if (previous == 0) return 0;
    return (weeklySteps - previous) / previous * 100;
  }

  List<Activity> get recentActivities {
    final Iterable<Activity> source = repository.activities.where((Activity a) {
      switch (_filter) {
        case ActivityFilter.all:
          return true;
        case ActivityFilter.morning:
          return a.isMorning && !a.isRecovery;
        case ActivityFilter.recovery:
          return a.isRecovery;
      }
    });
    final List<Activity> list = source.toList()
      ..sort((Activity a, Activity b) => b.date.compareTo(a.date));
    return list.take(8).toList(growable: false);
  }
}
