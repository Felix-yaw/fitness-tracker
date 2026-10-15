import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

/// Horizontal row of pill filters; the selected pill is filled black.
class PillTabBar<T> extends StatelessWidget {
  const PillTabBar({
    super.key,
    required this.items,
    required this.selected,
    required this.labelOf,
    required this.onSelect,
  });

  final List<T> items;
  final T selected;
  final String Function(T item) labelOf;
  final ValueChanged<T> onSelect;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 46,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        separatorBuilder: (_, _) => const SizedBox(width: 10),
        itemBuilder: (BuildContext context, int index) {
          final T item = items[index];
          final bool isSelected = item == selected;
          return GestureDetector(
            onTap: () => onSelect(item),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 160),
              curve: Curves.easeOut,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.ink : AppColors.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.ink, width: 2),
                boxShadow: isSelected ? null : AppColors.hardShadowSm,
              ),
              child: Center(
                child: Text(
                  labelOf(item),
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: isSelected ? AppColors.surface : AppColors.ink,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
