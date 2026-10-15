import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../common/glass_card.dart';

/// "Intensity" card with a warm glow, matching the reference.
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

    return GlassCard(
      radius: 24,
      padding: const EdgeInsets.all(20),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Intensity',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
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
                      fontWeight: FontWeight.w800,
                      letterSpacing: -1.5,
                      color: AppColors.ink,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${up ? '+' : ''}${deltaPercent.toStringAsFixed(1)}% from last week',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: up ? AppColors.positive : AppColors.accent,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: <Color>[
                  AppColors.accent.withValues(alpha: 0.55),
                  AppColors.accent.withValues(alpha: 0.15),
                ],
              ),
            ),
            child: const Icon(Icons.bolt_rounded, color: Colors.white, size: 30),
          ),
        ],
      ),
    );
  }
}
