import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';

import '../data/models/activity.dart';
import '../data/repositories/fitness_repository.dart';

/// Base class for all fitness ViewModels.
///
/// Subscribes to the single [FitnessRepository] and re-notifies, so any
/// mutation keeps every observing screen in sync.
abstract class ViewModel extends ChangeNotifier {
  ViewModel(this.repository) {
    repository.addListener(_onRepositoryChanged);
  }

  @protected
  final FitnessRepository repository;

  void _onRepositoryChanged() => notifyListeners();

  static DateTime startOfDay(DateTime date) =>
      DateTime(date.year, date.month, date.day);

  /// Monday-based start of the week containing [date].
  static DateTime startOfWeek(DateTime date) {
    final DateTime day = startOfDay(date);
    return day.subtract(Duration(days: day.weekday - 1));
  }

  static int sumSteps(Iterable<Activity> activities) =>
      activities.fold(0, (int total, Activity a) => total + a.steps);

  static double sumDistance(Iterable<Activity> activities) =>
      activities.fold(0, (double total, Activity a) => total + a.distanceKm);

  static int sumCalories(Iterable<Activity> activities) =>
      activities.fold(0, (int total, Activity a) => total + a.calories);

  /// Activities whose date falls on [day].
  Iterable<Activity> activitiesOn(DateTime day) => repository.activities.where(
    (Activity a) => startOfDay(a.date) == startOfDay(day),
  );

  @override
  void dispose() {
    repository.removeListener(_onRepositoryChanged);
    super.dispose();
  }
}
