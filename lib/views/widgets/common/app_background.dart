import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

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
          child: CustomPaint(painter: _DotGridPainter()),
        ),
        Positioned.fill(child: child),
      ],
    );
  }
}

class _DotGridPainter extends CustomPainter {
  const _DotGridPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..color = const Color(0x1414110C);
    const double gap = 26;
    for (double x = gap / 2; x < size.width; x += gap) {
      for (double y = gap / 2; y < size.height; y += gap) {
        canvas.drawCircle(Offset(x, y), 1.4, paint);
      }
    }
  }

  @override
  bool shouldRepaint(_DotGridPainter oldDelegate) => false;
}
