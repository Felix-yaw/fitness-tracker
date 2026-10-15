import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/theme/app_colors.dart';
import '../../data/repositories/fitness_repository.dart';
import '../../navigation/app_routes.dart';
import '../../viewmodels/friends_viewmodel.dart';
import '../../viewmodels/home_viewmodel.dart';
import '../../viewmodels/profile_viewmodel.dart';
import '../../viewmodels/stats_viewmodel.dart';
import '../widgets/navigation/floating_nav_bar.dart';
import 'friends_screen.dart';
import 'home_screen.dart';
import 'profile_screen.dart';
import 'stats_screen.dart';

/// Root scaffold hosting the four primary tabs.
class RootShell extends StatefulWidget {
  const RootShell({super.key});

  @override
  State<RootShell> createState() => _RootShellState();
}

class _RootShellState extends State<RootShell> {
  int _index = 0;

  void _onSelect(int index) {
    if (index == _index) return;
    setState(() => _index = index);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: <ChangeNotifierProvider<ChangeNotifier>>[
        ChangeNotifierProvider<HomeViewModel>(
          create: (BuildContext ctx) =>
              HomeViewModel(ctx.read<FitnessRepository>()),
        ),
        ChangeNotifierProvider<StatsViewModel>(
          create: (BuildContext ctx) =>
              StatsViewModel(ctx.read<FitnessRepository>()),
        ),
        ChangeNotifierProvider<FriendsViewModel>(
          create: (BuildContext ctx) =>
              FriendsViewModel(ctx.read<FitnessRepository>()),
        ),
        ChangeNotifierProvider<ProfileViewModel>(
          create: (BuildContext ctx) =>
              ProfileViewModel(ctx.read<FitnessRepository>()),
        ),
      ],
      child: Scaffold(
        extendBody: true,
        body: IndexedStack(
          index: _index,
          children: const <Widget>[
            HomeScreen(),
            StatsScreen(),
            FriendsScreen(),
            ProfileScreen(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => AppRoutes.openAddActivity(context),
          backgroundColor: AppColors.ink,
          foregroundColor: Colors.white,
          elevation: 4,
          shape: const CircleBorder(),
          child: const Icon(Icons.add_rounded, size: 28),
        ),
        bottomNavigationBar: FloatingNavBar(
          index: _index,
          onSelect: _onSelect,
        ),
      ),
    );
  }
}
