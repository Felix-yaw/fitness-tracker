import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../data/models/weather.dart';
import '../common/neo_card.dart';

/// Lime weather sticker, matching the neo-brutalist palette.
class WeatherCard extends StatelessWidget {
  const WeatherCard({super.key, required this.weather});

  final Weather weather;

  @override
  Widget build(BuildContext context) {
    return NeoCard(
      highlight: true,
      radius: 18,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Icon(
                Icons.location_on_rounded,
                color: AppColors.ink,
                size: 16,
              ),
              const SizedBox(width: 6),
              Flexible(
                child: Text(
                  weather.location,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.ink,
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(
                '+${weather.temperature}°C',
                style: const TextStyle(
                  color: AppColors.ink,
                  fontSize: 42,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -1.8,
                ),
              ),
              const Spacer(),
              Icon(weather.icon, color: AppColors.ink, size: 40),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            weather.condition,
            style: const TextStyle(
              color: AppColors.inkSecondary,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
