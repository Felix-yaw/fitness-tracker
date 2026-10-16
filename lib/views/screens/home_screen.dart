import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/models/activity.dart';
import '../../navigation/app_routes.dart';
import '../../viewmodels/activity_filter.dart';
import '../../viewmodels/home_viewmodel.dart';
import '../widgets/common/pill_tab_bar.dart';
import '../widgets/common/section_header.dart';
import '../widgets/home/activity_tile.dart';
import '../widgets/home/greeting_header.dart';
import '../widgets/home/summary_grid.dart';

/// Home/dashboard tab.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeViewModel viewModel = context.watch<HomeViewModel>();

    return SafeArea(
      bottom: false,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 140),
        children: <Widget>[
          GreetingHeader(name: viewModel.userName),
          const SizedBox(height: 24),
          SummaryGrid(
            viewModel: viewModel,
            onActivityTap: () => AppRoutes.openActivities(context),
            onWeeklyTap: () => AppRoutes.openActivities(context),
          ),
          const SizedBox(height: 26),
          SectionHeader(
            title: 'Recent activities',
            actionLabel: 'See all',
            onAction: () => AppRoutes.openActivities(context),
          ),
          const SizedBox(height: 14),
          PillTabBar<ActivityFilter>(
            items: ActivityFilter.values,
            selected: viewModel.filter,
            labelOf: (ActivityFilter f) => f.label,
            onSelect: viewModel.setFilter,
          ),
          const SizedBox(height: 6),
          for (final Activity activity in viewModel.recentActivities)
            ActivityTile(activity: activity),
        ],
      ),
    );
  }
}
