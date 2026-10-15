import '../data/models/activity.dart';
import 'view_model.dart';

/// Backs the full activities list screen.
class ActivitiesViewModel extends ViewModel {
  ActivitiesViewModel(super.repository);

  List<Activity> get activities {
    final List<Activity> list = repository.activities.toList()
      ..sort((Activity a, Activity b) => b.date.compareTo(a.date));
    return list;
  }

  int get totalSteps => ViewModel.sumSteps(repository.activities);

  double get totalDistance => ViewModel.sumDistance(repository.activities);

  void remove(String id) => repository.removeActivity(id);
}
