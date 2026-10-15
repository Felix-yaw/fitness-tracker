import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/formatters.dart';
import '../../../data/models/activity.dart';
import 'activity_avatar.dart';

/// One activity row: type icon, time-of-day label, title and schedule.
class ActivityTile extends StatelessWidget {
  const ActivityTile({super.key, required this.activity, this.onTap});

  final Activity activity;
  final VoidCallback? onTap;

  String get _slotLabel {
    if (activity.isRecovery) return 'Recovery';
    if (activity.isMorning) return 'Morning activities';
    if (activity.date.hour < 17) return 'Afternoon activities';
    return 'Evening activities';
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            children: <Widget>[
              ActivityAvatar(type: activity.type),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      _slotLabel,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.inkSecondary,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      activity.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: AppColors.ink,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      '${Formatters.fullDate(activity.date)} · '
                      '${Formatters.timeRange(activity.date, activity.end)}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.inkSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Icon(
                Icons.monitor_heart_outlined,
                size: 20,
                color: AppColors.inkTertiary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
