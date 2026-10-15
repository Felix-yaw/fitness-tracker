import 'package:flutter/material.dart';

import '../models/activity.dart';
import '../models/activity_type.dart';
import '../models/friend.dart';
import '../models/weather.dart';

/// In-memory data source and single source of truth — the MVVM "Model" layer.
///
/// It is a [ChangeNotifier]; the ViewModels observe it so every screen stays in
/// sync. Ready to be swapped for a real API/local store later.
class FitnessRepository extends ChangeNotifier {
  FitnessRepository({
    List<Activity>? activities,
    List<Friend>? friends,
    Weather? weather,
    this.weeklyStepGoal = 75000,
  }) : _activities = List<Activity>.of(activities ?? seedActivities()),
       _friends = List<Friend>.of(friends ?? seedFriends()),
       _weather = weather ?? seedWeather();

  final List<Activity> _activities;
  final List<Friend> _friends;
  final Set<String> _applauded = <String>{};
  final Weather _weather;
  final double weeklyStepGoal;

  List<Activity> get activities => List<Activity>.unmodifiable(_activities);

  List<Friend> get friends => List<Friend>.unmodifiable(_friends);

  Weather get weather => _weather;

  bool isApplauded(Friend friend) => _applauded.contains(friend.id);

  String nextId() => DateTime.now().microsecondsSinceEpoch.toString();

  void addActivity(Activity activity) {
    _activities.insert(0, activity);
    notifyListeners();
  }

  void removeActivity(String id) {
    _activities.removeWhere((Activity a) => a.id == id);
    notifyListeners();
  }

  void toggleApplaud(Friend friend) {
    if (!_applauded.remove(friend.id)) _applauded.add(friend.id);
    notifyListeners();
  }

  // ─────────────────────────────── Seed data ──────────────────────────────

  static const List<int> _dailyStepTargets = <int>[
    10600, // today
    8300,
    3400,
    10500,
    7200,
    5400,
    10600,
    8800,
    6100,
    9200,
    4200,
    11500,
    7600,
    5300,
  ];

  static List<Activity> seedActivities() {
    final DateTime now = DateTime.now();
    DateTime at(int daysAgo, int hour, int minute) {
      final DateTime day = DateTime(now.year, now.month, now.day)
          .subtract(Duration(days: daysAgo));
      return DateTime(day.year, day.month, day.day, hour, minute);
    }

    final List<Activity> list = <Activity>[
      Activity(
        id: 'a0a',
        title: '5km outdoor walk',
        type: ActivityType.walk,
        date: at(0, 10, 30),
        duration: const Duration(hours: 2),
        distanceKm: 5.2,
        steps: 10400,
        calories: 300,
        intensity: 0.55,
      ),
      Activity(
        id: 'a0b',
        title: 'Evening recovery',
        type: ActivityType.recovery,
        date: at(0, 19, 0),
        duration: const Duration(minutes: 20),
        steps: 200,
        calories: 26,
        intensity: 0.25,
      ),
    ];

    const List<ActivityType> rotation = <ActivityType>[
      ActivityType.run,
      ActivityType.cycle,
      ActivityType.strength,
      ActivityType.yoga,
      ActivityType.walk,
      ActivityType.swim,
    ];

    for (int d = 1; d < _dailyStepTargets.length; d++) {
      final int steps = _dailyStepTargets[d];
      final ActivityType type = rotation[(d - 1) % rotation.length];
      list.add(
        Activity(
          id: 'a$d',
          title: _titleFor(type),
          type: type,
          date: at(d, d.isEven ? 7 : 18, 0),
          duration: Duration(minutes: 30 + (d % 4) * 12),
          distanceKm: double.parse((steps / 2038).toStringAsFixed(1)),
          steps: steps,
          calories: (steps * 0.0308).round(),
          intensity: 0.4 + (d % 5) * 0.1,
        ),
      );
    }

    return list;
  }

  static String _titleFor(ActivityType type) {
    switch (type) {
      case ActivityType.walk:
        return 'Neighbourhood walk';
      case ActivityType.run:
        return 'Morning run';
      case ActivityType.cycle:
        return 'City cycle';
      case ActivityType.strength:
        return 'Strength session';
      case ActivityType.yoga:
        return 'Yoga flow';
      case ActivityType.swim:
        return 'Lap swim';
      case ActivityType.recovery:
        return 'Recovery session';
    }
  }

  static List<Friend> seedFriends() {
    return const <Friend>[
      Friend(
        id: 'f1',
        name: 'Margaret Smith',
        activePercent: 40,
        changePercent: 40,
        workoutsThisWeek: 5,
        isActiveToday: true,
      ),
      Friend(
        id: 'f2',
        name: 'Olivia R.',
        activePercent: 11,
        changePercent: 11,
        workoutsThisWeek: 3,
        isActiveToday: true,
      ),
      Friend(
        id: 'f3',
        name: 'Daniel Kim',
        activePercent: 68,
        changePercent: 8,
        workoutsThisWeek: 6,
      ),
      Friend(
        id: 'f4',
        name: 'Aisha Bello',
        activePercent: 52,
        changePercent: 15,
        workoutsThisWeek: 4,
      ),
      Friend(
        id: 'f5',
        name: 'Liam Petersen',
        activePercent: 30,
        changePercent: 3,
        workoutsThisWeek: 2,
      ),
    ];
  }

  static Weather seedWeather() => const Weather(
    city: 'Neukölln',
    country: 'Berlin',
    temperature: 11,
    condition: 'Partly cloudy',
    icon: Icons.wb_sunny_rounded,
  );
}
