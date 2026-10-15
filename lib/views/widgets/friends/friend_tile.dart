import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../data/models/friend.dart';

/// A friend row with their activity and Applaud / Message actions.
class FriendTile extends StatelessWidget {
  const FriendTile({
    super.key,
    required this.friend,
    required this.applauded,
    required this.onApplaud,
    required this.onMessage,
  });

  final Friend friend;
  final bool applauded;
  final VoidCallback onApplaud;
  final VoidCallback onMessage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _Avatar(friend: friend),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  friend.name,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: AppColors.ink,
                  ),
                ),
                const SizedBox(height: 3),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: <Widget>[
                      const Icon(
                        Icons.arrow_upward_rounded,
                        size: 13,
                        color: AppColors.positive,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        '${friend.changePercent}% active',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.inkSecondary,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '· ${friend.workoutsThisWeek} workouts',
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.inkTertiary,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: <Widget>[
                    _Pill(
                      label: applauded ? 'Applauded' : 'Applaud',
                      filled: applauded,
                      onTap: onApplaud,
                    ),
                    _Pill(label: 'Message', onTap: onMessage),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({required this.friend});

  final Friend friend;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 48,
      height: 48,
      child: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          Container(
            width: 48,
            height: 48,
            decoration: const BoxDecoration(
              color: AppColors.accentSoft,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                friend.initials,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  color: AppColors.accent,
                ),
              ),
            ),
          ),
          if (friend.isActiveToday)
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                width: 14,
                height: 14,
                decoration: BoxDecoration(
                  color: AppColors.positive,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.surface, width: 2),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill({
    required this.label,
    required this.onTap,
    this.filled = false,
  });

  final String label;
  final VoidCallback onTap;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: filled ? AppColors.ink : Colors.white.withValues(alpha: 0.7),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: filled
              ? AppColors.ink
              : Colors.white.withValues(alpha: 0.9),
        ),
      ),
      child: InkWell(
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: filled ? Colors.white : AppColors.ink,
            ),
          ),
        ),
      ),
    );
  }
}
