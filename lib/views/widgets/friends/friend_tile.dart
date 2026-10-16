import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../data/models/friend.dart';
import 'action_pill.dart';
import 'friend_avatar.dart';

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
          FriendAvatar(friend: friend),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  friend.name,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
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
                          fontWeight: FontWeight.w700,
                          color: AppColors.inkSecondary,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '· ${friend.workoutsThisWeek} workouts',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
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
                    ActionPill(
                      label: applauded ? 'Applauded' : 'Applaud',
                      filled: applauded,
                      onTap: onApplaud,
                    ),
                    ActionPill(label: 'Message', onTap: onMessage),
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
