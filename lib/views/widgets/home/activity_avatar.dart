import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../data/models/activity_type.dart';

/// Circular activity icon with a hard outline.
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
        color: AppColors.surface,
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.ink, width: 2),
      ),
      child: Icon(type.icon, size: size * 0.46, color: type.color),
    );
  }
}
