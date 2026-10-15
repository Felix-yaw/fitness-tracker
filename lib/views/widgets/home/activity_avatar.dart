import 'package:flutter/material.dart';

import '../../../data/models/activity_type.dart';

/// Circular activity icon tinted with the activity type's colour.
class ActivityAvatar extends StatelessWidget {
  const ActivityAvatar({super.key, required this.type, this.size = 44});

  final ActivityType type;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: type.color.withValues(alpha: 0.14),
        shape: BoxShape.circle,
      ),
      child: Icon(type.icon, size: size * 0.46, color: type.color),
    );
  }
}
