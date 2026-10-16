import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/formatters.dart';
import '../../../data/models/activity.dart';
import '../../../viewmodels/activities_viewmodel.dart';
import '../common/empty_state.dart';
import '../home/activity_tile.dart';

/// The activities list body with a count/step header and dismissible rows.
class ActivitiesView extends StatelessWidget {
  const ActivitiesView({super.key});

  @override
  Widget build(BuildContext context) {
    final ActivitiesViewModel vm = context.watch<ActivitiesViewModel>();
    final List<Activity> items = vm.activities;

    return Scaffold(
      appBar: AppBar(title: const Text('All activities')),
      body: items.isEmpty
          ? const EmptyState(
              icon: Icons.directions_run_rounded,
              title: 'No activities yet',
              message: 'Log your first workout to see it here.',
            )
          : Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 4, 20, 8),
                  child: Row(
                    children: <Widget>[
                      Text(
                        '${items.length} activities',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppColors.inkSecondary,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        Formatters.compactNumber(vm.totalSteps),
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.4,
                          color: AppColors.ink,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Text(
                        'steps',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppColors.inkSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
                    itemCount: items.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 4),
                    itemBuilder: (BuildContext context, int index) {
                      final Activity activity = items[index];
                      return Dismissible(
                        key: ValueKey<String>(activity.id),
                        direction: DismissDirection.endToStart,
                        onDismissed: (_) => vm.remove(activity.id),
                        background: Container(
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 20),
                          decoration: BoxDecoration(
                            color: AppColors.accent,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Icon(
                            Icons.delete_outline_rounded,
                            color: Colors.white,
                          ),
                        ),
                        child: ActivityTile(activity: activity),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
