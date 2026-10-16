import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

/// A single animated bar rendered inside a [BarChart].
class ChartBar extends StatelessWidget {
  const ChartBar({
    super.key,
    required this.label,
    required this.valueLabel,
    required this.fraction,
    required this.height,
    required this.color,
    required this.barWidth,
    required this.highlighted,
  });

  final String label;
  final String? valueLabel;
  final double fraction;
  final double height;
  final Color color;
  final double barWidth;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        if (valueLabel != null)
          Text(
            valueLabel!,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w800,
              color: AppColors.ink,
            ),
          ),
        const SizedBox(height: 8),
        SizedBox(
          height: height,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0, end: fraction),
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeOutCubic,
              builder: (BuildContext context, double t, Widget? child) {
                return Container(
                  width: barWidth,
                  height: (height * t).clamp(10.0, height),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(barWidth / 2),
                    border: Border.all(color: AppColors.ink, width: 2),
                  ),
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: AppColors.inkSecondary,
          ),
        ),
      ],
    );
  }
}
