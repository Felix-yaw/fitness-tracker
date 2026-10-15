import 'package:flutter/foundation.dart';

import 'activity_type.dart';

/// A single tracked workout / activity.
@immutable
class Activity {
  const Activity({
    required this.id,
    required this.title,
    required this.type,
    required this.date,
    required this.duration,
    this.distanceKm = 0,
    this.steps = 0,
    this.calories = 0,
    this.intensity = 0,
    this.note = '',
  });

  final String id;
  final String title;
  final ActivityType type;
  final DateTime date;
  final Duration duration;
  final double distanceKm;
  final int steps;
  final int calories;

  /// Effort score from 0 to 1.
  final double intensity;
  final String note;

  DateTime get end => date.add(duration);

  bool get isMorning => date.hour < 12;

  bool get isRecovery => type == ActivityType.recovery;
}
