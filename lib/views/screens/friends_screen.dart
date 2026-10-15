import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/theme/app_colors.dart';
import '../../data/models/friend.dart';
import '../../viewmodels/friends_viewmodel.dart';
import '../widgets/common/neo_card.dart';
import '../widgets/friends/friend_tile.dart';

/// Friends tab: activity leaderboard with Applaud / Message actions.
class FriendsScreen extends StatelessWidget {
  const FriendsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FriendsViewModel vm = context.watch<FriendsViewModel>();
    final List<Friend> friends = vm.friends;

    return SafeArea(
      bottom: false,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 140),
        children: <Widget>[
          const Text(
            'Friends',
            style: TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.w900,
              letterSpacing: -1.6,
              color: AppColors.ink,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            '${vm.activeTodayCount} friends active today',
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.inkSecondary,
            ),
          ),
          const SizedBox(height: 18),
          NeoCard(
            radius: 18,
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
            child: Column(
              children: <Widget>[
                for (int i = 0; i < friends.length; i++) ...<Widget>[
                  FriendTile(
                    friend: friends[i],
                    applauded: vm.isApplauded(friends[i]),
                    onApplaud: () {
                      vm.applaud(friends[i]);
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(
                          SnackBar(
                            content: Text(
                              'Applauded ${friends[i].firstName}',
                            ),
                          ),
                        );
                    },
                    onMessage: () => ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        SnackBar(
                          content: Text(
                            'Message ${friends[i].firstName} (coming soon)',
                          ),
                        ),
                      ),
                  ),
                  if (i != friends.length - 1)
                    const Divider(height: 1, color: AppColors.divider),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
