import 'package:flutter/material.dart';

/// Types of tracked activity, each with a label, icon and accent colour.
enum ActivityType {
  walk('Outdoor walk', Icons.directions_walk_rounded, Color(0xFFE8511C)),
  run('Run', Icons.directions_run_rounded, Color(0xFFF5A623)),
  cycle('Cycle', Icons.directions_bike_rounded, Color(0xFF3B82F6)),
  strength('Strength', Icons.fitness_center_rounded, Color(0xFF9B5DE5)),
  yoga('Yoga', Icons.self_improvement_rounded, Color(0xFF14B8A6)),
  swim('Swim', Icons.pool_rounded, Color(0xFF0EA5E9)),
  recovery('Recovery', Icons.spa_rounded, Color(0xFF2FBE7E));

  const ActivityType(this.label, this.icon, this.color);

  final String label;
  final IconData icon;
  final Color color;
}
