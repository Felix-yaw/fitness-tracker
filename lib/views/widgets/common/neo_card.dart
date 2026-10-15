import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

/// Neo-brutalist surface: solid fill, thick black outline and a hard offset
/// shadow that "presses in" on tap.
class NeoCard extends StatefulWidget {
  const NeoCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(18),
    this.margin,
    this.radius = 18,
    this.color,
    this.onTap,
    this.highlight = false,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry? margin;
  final double radius;
  final Color? color;
  final VoidCallback? onTap;

  /// Render on the acid-lime accent instead of white.
  final bool highlight;

  @override
  State<NeoCard> createState() => _NeoCardState();
}

class _NeoCardState extends State<NeoCard> {
  bool _pressed = false;

  void _setPressed(bool value) {
    if (widget.onTap == null || _pressed == value) return;
    setState(() => _pressed = value);
  }

  @override
  Widget build(BuildContext context) {
    final Color background =
        widget.color ?? (widget.highlight ? AppColors.accent : AppColors.surface);

    return Padding(
      padding: widget.margin ?? EdgeInsets.zero,
      child: GestureDetector(
        onTap: widget.onTap,
        onTapDown: (_) => _setPressed(true),
        onTapUp: (_) => _setPressed(false),
        onTapCancel: () => _setPressed(false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 90),
          curve: Curves.easeOut,
          transform: Matrix4.translationValues(
            _pressed ? 3 : 0,
            _pressed ? 3 : 0,
            0,
          ),
          decoration: BoxDecoration(
            color: background,
            borderRadius: BorderRadius.circular(widget.radius),
            border: Border.all(color: AppColors.ink, width: 2.5),
            boxShadow: _pressed ? AppColors.hardShadowSm : AppColors.hardShadow,
          ),
          padding: widget.padding,
          child: widget.child,
        ),
      ),
    );
  }
}
