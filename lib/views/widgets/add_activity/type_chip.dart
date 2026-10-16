import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../data/models/activity_type.dart';

/// Selectable activity-type pill used in the log-activity form.
class TypeChip extends StatelessWidget {
  const TypeChip({
    super.key,
    required this.type,
    required this.selected,
    required this.onTap,
  });

  final ActivityType type;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? type.color : AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.ink, width: 2),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              type.icon,
              size: 16,
              color: selected ? Colors.white : type.color,
            ),
            const SizedBox(width: 8),
            Text(
              type.label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: selected ? Colors.white : AppColors.ink,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
