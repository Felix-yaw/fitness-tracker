import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/formatters.dart';
import '../../../viewmodels/home_viewmodel.dart';
import '../common/stat_card.dart';
import 'mini_bars.dart';

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
                highlight: true,
                onTap: onActivityTap,
              ),
              const SizedBox(height: 14),
              StatCard(
                label: 'Calories',
                value: Formatters.calories(viewModel.todayCalories),
              ),
            ],
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            children: <Widget>[
              StatCard(
                label: 'Distance',
                value: Formatters.distanceKm(viewModel.todayDistance),
              ),
              const SizedBox(height: 14),
              StatCard(
                label: 'Weekly goal',
                value: '${(viewModel.weeklyPercent * 100).round()}%',
                subtitle:
                    '${up ? '+' : ''}${delta.toStringAsFixed(1)}% from last week',
                subtitleColor: up ? AppColors.positive : AppColors.alert,
                onTap: onWeeklyTap,
                child: MiniBars(values: viewModel.last7DaySteps),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
