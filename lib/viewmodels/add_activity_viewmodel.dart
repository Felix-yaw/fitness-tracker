import '../data/models/activity.dart';
import '../data/models/activity_type.dart';
import 'view_model.dart';

/// Backs the Log-activity form.
class AddActivityViewModel extends ViewModel {
  AddActivityViewModel(super.repository);

  String _title = '';
  ActivityType _type = ActivityType.walk;
  String _minutes = '30';
  String _distance = '';
  String _steps = '';
  String _calories = '';

  String get title => _title;
  ActivityType get type => _type;
  String get minutes => _minutes;
  String get distance => _distance;
  String get steps => _steps;
  String get calories => _calories;

  bool get isValid =>
      _title.trim().isNotEmpty && (int.tryParse(_minutes.trim()) ?? 0) > 0;

  void setTitle(String value) {
    _title = value;
    notifyListeners();
  }

  void setType(ActivityType value) {
    _type = value;
    notifyListeners();
  }

  void setMinutes(String value) {
    _minutes = value;
    notifyListeners();
  }

  void setDistance(String value) {
    _distance = value;
    notifyListeners();
  }

  void setSteps(String value) {
    _steps = value;
    notifyListeners();
  }

  void setCalories(String value) {
    _calories = value;
    notifyListeners();
  }

  bool save() {
    if (!isValid) return false;
    repository.addActivity(
      Activity(
        id: repository.nextId(),
        title: _title.trim(),
        type: _type,
        date: DateTime.now(),
        duration: Duration(minutes: int.tryParse(_minutes.trim()) ?? 0),
        distanceKm: double.tryParse(_distance.trim()) ?? 0,
        steps: int.tryParse(_steps.trim()) ?? 0,
        calories: int.tryParse(_calories.trim()) ?? 0,
        intensity: 0.5,
      ),
    );
    return true;
  }
}
