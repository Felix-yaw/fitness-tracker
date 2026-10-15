import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../common/neo_card.dart';

/// Floating bottom navigation bar; the active tab expands into a black pill.
class FloatingNavBar extends StatelessWidget {
  const FloatingNavBar({
    super.key,
    required this.index,
    required this.onSelect,
  });

  final int index;
  final ValueChanged<int> onSelect;

  static const List<_NavData> _items = <_NavData>[
    _NavData(Icons.home_outlined, Icons.home_rounded, 'Home'),
    _NavData(Icons.insights_outlined, Icons.insights_rounded, 'Stats'),
    _NavData(Icons.groups_outlined, Icons.groups_rounded, 'Friends'),
    _NavData(Icons.person_outline_rounded, Icons.person_rounded, 'Profile'),
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
            _NavItem(
              data: _items[i],
              selected: index == i,
              onTap: () => onSelect(i),
            ),
        ],
      ),
    );
  }
}

class _NavData {
  const _NavData(this.icon, this.selectedIcon, this.label);
  final IconData icon;
  final IconData selectedIcon;
  final String label;
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.data,
    required this.selected,
    required this.onTap,
  });

  final _NavData data;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,
        padding: EdgeInsets.symmetric(
          horizontal: selected ? 16 : 14,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: selected ? AppColors.ink : Colors.transparent,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              selected ? data.selectedIcon : data.icon,
              size: 22,
              color: selected ? AppColors.surface : AppColors.inkSecondary,
            ),
            AnimatedSize(
              duration: const Duration(milliseconds: 220),
              curve: Curves.easeOutCubic,
              child: selected
                  ? Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Text(
                        data.label,
                        style: const TextStyle(
                          color: AppColors.surface,
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}
