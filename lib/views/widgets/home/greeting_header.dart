import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

/// Big "Hi, {name}" greeting with a lime sticker avatar.
class GreetingHeader extends StatelessWidget {
  const GreetingHeader({
    super.key,
    required this.name,
    this.onAvatarTap,
  });

  final String name;
  final VoidCallback? onAvatarTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Text.rich(
            TextSpan(
              children: <InlineSpan>[
                const TextSpan(
                  text: 'Hi, ',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                TextSpan(
                  text: name,
                  style: const TextStyle(fontWeight: FontWeight.w900),
                ),
              ],
            ),
            style: const TextStyle(
              fontSize: 36,
              letterSpacing: -1.8,
              height: 1.0,
              color: AppColors.ink,
            ),
          ),
        ),
        GestureDetector(
          onTap: onAvatarTap,
          child: Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: AppColors.accent,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.ink, width: 2.5),
              boxShadow: AppColors.hardShadowSm,
            ),
            child: const Center(
              child: Text(
                'M',
                style: TextStyle(
                  color: AppColors.ink,
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
