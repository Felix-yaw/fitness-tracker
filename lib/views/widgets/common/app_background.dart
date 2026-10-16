import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import 'dot_grid_painter.dart';

/// Flat paper canvas with a faint dot grid, sitting behind the whole app.
class AppBackground extends StatelessWidget {
  const AppBackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        const ColoredBox(color: AppColors.background),
        const Positioned.fill(
          child: CustomPaint(painter: DotGridPainter()),
        ),
        Positioned.fill(child: child),
      ],
    );
  }
}
