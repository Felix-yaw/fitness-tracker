import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

/// Tiny 7-bar sparkline with hard outlines, used inside the summary grid.
class MiniBars extends StatelessWidget {
  const MiniBars({super.key, required this.values});

  final List<double> values;

  @override
  Widget build(BuildContext context) {
    final double max = values.fold<double>(
      0,
      (double m, double v) => v > m ? v : m,
    );

    return SizedBox(
      height: 34,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          for (int i = 0; i < values.length; i++)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: Container(
                  height: max == 0 ? 6 : (values[i] / max * 34).clamp(6.0, 34.0),
                  decoration: BoxDecoration(
                    color: i == values.length - 1
                        ? AppColors.ink
                        : AppColors.ink.withValues(alpha: 0.28),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
