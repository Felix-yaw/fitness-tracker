import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../data/models/friend.dart';

/// Circular initials avatar with an "active today" marker.
class FriendAvatar extends StatelessWidget {
  const FriendAvatar({super.key, required this.friend});

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
            decoration: BoxDecoration(
              color: AppColors.surface,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.ink, width: 2),
            ),
            child: Center(
              child: Text(
                friend.initials,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w900,
                  color: AppColors.ink,
                ),
              ),
            ),
          ),
          if (friend.isActiveToday)
            Positioned(
              right: -2,
              bottom: -2,
              child: Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color: AppColors.positive,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.ink, width: 2),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
