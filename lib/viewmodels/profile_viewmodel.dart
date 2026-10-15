import '../core/utils/formatters.dart';
import '../data/models/activity.dart';
import 'view_model.dart';

/// Backs the Profile screen.
class ProfileViewModel extends ViewModel {
  ProfileViewModel(super.repository);

  String get userName => 'Miranda';

  String get email => 'miranda@example.com';

  String get memberSince => 'Member since January 2024';

  int get totalSteps => ViewModel.sumSteps(repository.activities);

  int get totalActivities => repository.activities.length;

  double get totalDistance => ViewModel.sumDistance(repository.activities);

  /// Consecutive days (ending today) with at least one activity.
  int get streakDays {
    int streak = 0;
    DateTime day = ViewModel.startOfDay(DateTime.now());
    while (streak < 60) {
      final bool hasActivity = repository.activities.any(
        (Activity a) => ViewModel.startOfDay(a.date) == day,
      );
      if (!hasActivity) break;
      streak++;
      day = day.subtract(const Duration(days: 1));
    }
    return streak;
  }

  String get totalDistanceLabel => Formatters.distanceKm(totalDistance);
}
