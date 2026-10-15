import 'package:flutter/material.dart';

/// Neo-brutalist design tokens for the fitness tracker.
///
/// A warm "paper" canvas, near-black ink, thick outlines, hard (blur-less)
/// offset shadows and a single acid-lime accent.
abstract final class AppColors {
  static const Color background = Color(0xFFF4F0E6); // paper
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceMuted = Color(0xFFE9E3D4);

  static const Color ink = Color(0xFF14110C);
  static const Color inkSecondary = Color(0xFF5C5546);
  static const Color inkTertiary = Color(0xFF948B77);

  static const Color accent = Color(0xFFC8F135); // acid lime
  static const Color accentSoft = Color(0xFFEAF7C2);
  static const Color positive = Color(0xFF0FA958);
  static const Color positiveSoft = Color(0xFFD6F3E1);
  static const Color warning = Color(0xFFFFC53D);
  static const Color alert = Color(0xFFFF3D6E);

  static const Color divider = Color(0x2214110C);
  static const Color cardBorder = Color(0xFF14110C);

  /// Hard, blur-less drop shadow — the signature brutalist lift.
  static const List<BoxShadow> hardShadow = <BoxShadow>[
    BoxShadow(color: ink, offset: Offset(4, 4), blurRadius: 0),
  ];

  static const List<BoxShadow> hardShadowSm = <BoxShadow>[
    BoxShadow(color: ink, offset: Offset(2, 2), blurRadius: 0),
  ];

  // Aliases kept so existing widgets pick up the new look automatically.
  static const List<BoxShadow> cardShadow = hardShadow;
  static const List<BoxShadow> glowAccent = hardShadowSm;
}
