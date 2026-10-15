import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/theme/app_colors.dart';
import '../../core/utils/formatters.dart';
import '../../viewmodels/stats_viewmodel.dart';
import '../widgets/common/stat_card.dart';
import '../widgets/stats/intensity_card.dart';
import '../widgets/stats/weather_card.dart';
import '../widgets/stats/weekly_goal_card.dart';

/// Statistics tab: weekly goal chart, intensity, totals and weather.
class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final StatsViewModel vm = context.watch<StatsViewModel>();

    return SafeArea(
      bottom: false,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 140),
        children: <Widget>[
          const Text(
            'Statistics',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w600,
              letterSpacing: -1.0,
              color: AppColors.ink,
            ),
          ),
          const SizedBox(height: 20),
          WeeklyGoalCard(viewModel: vm),
          const SizedBox(height: 16),
          IntensityCard(
            intensity: vm.intensity,
            deltaPercent: vm.intensityDeltaPercent,
          ),
          const SizedBox(height: 16),
          Row(
            children: <Widget>[
              Expanded(
                child: StatCard(
                  label: 'Weekly steps',
                  value: Formatters.compactNumber(vm.weeklySteps),
                  subtitle: 'last 7 days',
                  subtitleColor: AppColors.inkSecondary,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: StatCard(
                  label: 'Active time',
                  value: Formatters.duration(Duration(minutes: vm.activeMinutes)),
                  subtitle: 'last 7 days',
                  subtitleColor: AppColors.inkSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          WeatherCard(weather: vm.weather),
        ],
      ),
    );
  }
}
