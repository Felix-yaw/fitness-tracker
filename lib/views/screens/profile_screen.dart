import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/theme/app_colors.dart';
import '../../core/utils/formatters.dart';
import '../../viewmodels/profile_viewmodel.dart';
import '../widgets/common/neo_card.dart';
import '../widgets/profile/menu_item.dart';
import '../widgets/profile/profile_stat.dart';
import '../widgets/profile/stat_divider.dart';

/// Profile tab: athlete summary and settings.
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static const List<MenuItem> _menu = <MenuItem>[
    MenuItem(Icons.flag_outlined, 'Goals'),
    MenuItem(Icons.watch_outlined, 'Devices'),
    MenuItem(Icons.notifications_none_rounded, 'Notifications'),
    MenuItem(Icons.lock_outline_rounded, 'Privacy'),
    MenuItem(Icons.help_outline_rounded, 'Help & support'),
  ];

  @override
  Widget build(BuildContext context) {
    final ProfileViewModel vm = context.watch<ProfileViewModel>();

    return SafeArea(
      bottom: false,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 140),
        children: <Widget>[
          const Text(
            'Profile',
            style: TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.w900,
              letterSpacing: -1.6,
              color: AppColors.ink,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: <Widget>[
              Container(
                width: 72,
                height: 72,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[AppColors.accent, Color(0xFFFF8A5B)],
                  ),
                ),
                child: const Center(
                  child: Text(
                    'M',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      vm.userName,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.5,
                        color: AppColors.ink,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      vm.email,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.inkSecondary,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      vm.memberSince,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.inkTertiary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          NeoCard(
            radius: 18,
            padding: const EdgeInsets.symmetric(vertical: 22),
            child: Row(
              children: <Widget>[
                ProfileStat(value: '${vm.streakDays}', label: 'Day streak'),
                const StatDivider(),
                ProfileStat(
                  value: Formatters.compactNumber(vm.totalSteps),
                  label: 'Steps',
                ),
                const StatDivider(),
                ProfileStat(value: '${vm.totalActivities}', label: 'Workouts'),
              ],
            ),
          ),
          const SizedBox(height: 12),
          NeoCard(
            radius: 18,
            padding: const EdgeInsets.all(18),
            child: Row(
              children: <Widget>[
                const Icon(
                  Icons.route_rounded,
                  color: AppColors.accent,
                  size: 22,
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text(
                    'Total distance',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.inkSecondary,
                    ),
                  ),
                ),
                Text(
                  vm.totalDistanceLabel,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.4,
                    color: AppColors.ink,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 26),
          NeoCard(
            radius: 18,
            padding: EdgeInsets.zero,
            child: Material(
              color: Colors.transparent,
              child: Column(
                children: <Widget>[
                  for (int i = 0; i < _menu.length; i++) ...<Widget>[
                    ListTile(
                      leading: Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          color: AppColors.surfaceMuted,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.ink, width: 2),
                        ),
                        child: Icon(
                          _menu[i].icon,
                          size: 20,
                          color: AppColors.ink,
                        ),
                      ),
                      title: Text(
                        _menu[i].title,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: AppColors.ink,
                        ),
                      ),
                      trailing: const Icon(
                        Icons.chevron_right_rounded,
                        color: AppColors.inkTertiary,
                      ),
                      onTap: () => ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(
                          SnackBar(
                            content: Text('${_menu[i].title} coming soon'),
                          ),
                        ),
                    ),
                    if (i != _menu.length - 1)
                      const Divider(height: 1, indent: 70),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          OutlinedButton.icon(
            onPressed: () => ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(content: Text('Log out is not part of this prototype')),
              ),
            icon: const Icon(Icons.logout_rounded),
            label: const Text('Log out'),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.ink,
              side: const BorderSide(color: AppColors.ink, width: 2),
            ),
          ),
          const SizedBox(height: 18),
          const Center(
            child: Text(
              'fitness_tracker · v1.0.0',
              style: TextStyle(fontSize: 12, color: AppColors.inkTertiary),
            ),
          ),
        ],
      ),
    );
  }
}
