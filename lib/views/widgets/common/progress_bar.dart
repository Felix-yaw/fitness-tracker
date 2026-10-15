import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

/// Outlined progress bar with a hard border.
class ProgressBar extends StatelessWidget {
  const ProgressBar({
    super.key,
    required this.value,
    this.color = AppColors.ink,
    this.trackColor = AppColors.surface,
    this.height = 10,
  });

  final double value;
  final Color color;
  final Color trackColor;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: trackColor,
        borderRadius: BorderRadius.circular(height / 2),
        border: Border.all(color: AppColors.ink, width: 2),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(height / 2),
        child: TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 0, end: value.clamp(0.0, 1.0)),
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeOutCubic,
          builder: (BuildContext context, double v, Widget? child) {
            return LinearProgressIndicator(
              value: v,
              minHeight: height,
              backgroundColor: trackColor,
              valueColor: AlwaysStoppedAnimation<Color>(color),
            );
          },
        ),
      ),
    );
  }
}
