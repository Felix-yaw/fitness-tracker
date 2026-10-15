import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../common/neo_card.dart';

/// "Intensity" card with a lime badge.
class IntensityCard extends StatelessWidget {
  const IntensityCard({
    super.key,
    required this.intensity,
    required this.deltaPercent,
  });

  final double intensity;
  final double deltaPercent;

  @override
  Widget build(BuildContext context) {
    final bool up = deltaPercent >= 0;

    return NeoCard(
      radius: 18,
      padding: const EdgeInsets.all(20),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'INTENSITY',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.6,
                    color: AppColors.inkSecondary,
                  ),
                ),
                const SizedBox(height: 10),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '${(intensity * 100).round()}%',
                    style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -1.8,
                      color: AppColors.ink,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${up ? '+' : ''}${deltaPercent.toStringAsFixed(1)}% from last week',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: up ? AppColors.positive : AppColors.alert,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: AppColors.accent,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.ink, width: 2.5),
            ),
            child: const Icon(
              Icons.bolt_rounded,
              color: AppColors.ink,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}
