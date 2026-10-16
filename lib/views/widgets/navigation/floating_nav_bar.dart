import 'package:flutter/material.dart';

import '../common/neo_card.dart';
import 'nav_bar_item.dart';
import 'nav_destination.dart';

/// Floating bottom navigation bar; the active tab expands into a black pill.
class FloatingNavBar extends StatelessWidget {
  const FloatingNavBar({
    super.key,
    required this.index,
    required this.onSelect,
  });

  final int index;
  final ValueChanged<int> onSelect;

  static const List<NavDestination> _items = <NavDestination>[
    NavDestination(Icons.home_outlined, Icons.home_rounded, 'Home'),
    NavDestination(Icons.insights_outlined, Icons.insights_rounded, 'Stats'),
    NavDestination(Icons.groups_outlined, Icons.groups_rounded, 'Friends'),
    NavDestination(Icons.person_outline_rounded, Icons.person_rounded, 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    return NeoCard(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 16),
      radius: 20,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          for (int i = 0; i < _items.length; i++)
            NavBarItem(
              data: _items[i],
              selected: index == i,
              onTap: () => onSelect(i),
            ),
        ],
      ),
    );
  }
}
