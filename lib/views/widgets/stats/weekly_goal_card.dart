import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/formatters.dart';
import '../../../viewmodels/daily_bar.dart';
import '../../../viewmodels/stats_viewmodel.dart';
import '../common/bar_chart.dart';
import '../common/neo_card.dart';

/// "Weekly goal" card: big bar chart over the last 7 days.
class WeeklyGoalCard extends StatelessWidget {
  const WeeklyGoalCard({super.key, required this.viewModel});

  final StatsViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    final List<DailyBar> bars = viewModel.weeklyBars;
    final DateTime start = bars.first.date;
    final DateTime end = bars.last.date;

    return NeoCard(
      radius: 18,
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Expanded(
                child: Text(
                  'Weekly goal',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -0.5,
                    color: AppColors.ink,
                  ),
                ),
              ),
              Text(
                Formatters.dateRange(start, end),
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: AppColors.inkSecondary,
                ),
              ),
              const Icon(
                Icons.north_east_rounded,
                size: 15,
                color: AppColors.ink,
              ),
            ],
          ),
          const SizedBox(height: 22),
          BarChart(
            labels: bars.map((DailyBar b) => b.label).toList(),
            values: bars.map((DailyBar b) => b.value).toList(),
            valueLabels: viewModel.weeklyValueLabels,
            barWidth: 22,
            height: 160,
          ),
        ],
      ),
    );
  }
}
