import 'package:flutter/foundation.dart';

/// A friend whose activity can be viewed and applauded.
@immutable
class Friend {
  const Friend({
    required this.id,
    required this.name,
    required this.activePercent,
    required this.changePercent,
    this.workoutsThisWeek = 0,
    this.isActiveToday = false,
  });

  final String id;
  final String name;

  /// How close to their own weekly goal, 0–100.
  final int activePercent;

  /// Change vs last week, e.g. +40.
  final int changePercent;
  final int workoutsThisWeek;
  final bool isActiveToday;

  String get firstName => name.split(' ').first;

  String get initials {
    final List<String> parts = name.split(' ');
    if (parts.length == 1) return parts.first.substring(0, 1).toUpperCase();
    return (parts.first.substring(0, 1) + parts.last.substring(0, 1))
        .toUpperCase();
  }
}
