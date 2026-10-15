import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/formatters.dart';
import '../../../viewmodels/home_viewmodel.dart';
import '../common/stat_card.dart';

/// The staggered 2×2 summary grid: Activity, Distance, Weekly goal, Calories.
class SummaryGrid extends StatelessWidget {
  const SummaryGrid({
    super.key,
    required this.viewModel,
    this.onActivityTap,
    this.onWeeklyTap,
  });

  final HomeViewModel viewModel;
  final VoidCallback? onActivityTap;
  final VoidCallback? onWeeklyTap;

  @override
  Widget build(BuildContext context) {
    final double delta = viewModel.weeklyDeltaPercent;
    final bool up = delta >= 0;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Column(
            children: <Widget>[
              StatCard(
                label: 'Activity',
                value: Formatters.steps(viewModel.todaySteps),
                glow: true,
                onTap: onActivityTap,
              ),
              const SizedBox(height: 12),
              StatCard(
                label: 'Calories',
                value: Formatters.calories(viewModel.todayCalories),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            children: <Widget>[
              StatCard(
                label: 'Distance',
                value: Formatters.distanceKm(viewModel.todayDistance),
              ),
              const SizedBox(height: 12),
              StatCard(
                label: 'Weekly goal',
                value: '${(viewModel.weeklyPercent * 100).round()}%',
                subtitle:
                    '${up ? '+' : ''}${delta.toStringAsFixed(1)}% from last week',
                subtitleColor: up ? AppColors.positive : AppColors.accent,
                onTap: onWeeklyTap,
                child: _MiniBars(values: viewModel.last7DaySteps),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Tiny 7-bar sparkline used inside the weekly-goal card.
class _MiniBars extends StatelessWidget {
  const _MiniBars({required this.values});

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
                  height: max == 0 ? 4 : (values[i] / max * 34).clamp(4.0, 34.0),
                  decoration: BoxDecoration(
                    color: i == values.length - 1
                        ? AppColors.accent
                        : AppColors.accentSoft,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
