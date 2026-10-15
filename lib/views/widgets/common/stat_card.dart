import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import 'neo_card.dart';

/// Stat card: uppercase label, large value and optional subtitle / body.
class StatCard extends StatelessWidget {
  const StatCard({
    super.key,
    required this.label,
    this.value,
    this.subtitle,
    this.subtitleColor = AppColors.positive,
    this.onTap,
    this.highlight = false,
    this.child,
  });

  final String label;
  final String? value;
  final String? subtitle;
  final Color subtitleColor;
  final VoidCallback? onTap;

  /// Render on the acid-lime accent.
  final bool highlight;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return NeoCard(
      radius: 18,
      padding: const EdgeInsets.all(16),
      onTap: onTap,
      highlight: highlight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  label.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.6,
                    color: AppColors.inkSecondary,
                  ),
                ),
              ),
              if (onTap != null)
                const Icon(
                  Icons.north_east_rounded,
                  size: 16,
                  color: AppColors.ink,
                ),
            ],
          ),
          const SizedBox(height: 10),
          if (value != null)
            FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Text(
                value!,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -1.0,
                  color: AppColors.ink,
                ),
              ),
            ),
          if (subtitle != null) ...<Widget>[
            const SizedBox(height: 4),
            Text(
              subtitle!,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: subtitleColor,
              ),
            ),
          ],
          if (child != null) ...<Widget>[
            const SizedBox(height: 10),
            child!,
          ],
        ],
      ),
    );
  }
}
