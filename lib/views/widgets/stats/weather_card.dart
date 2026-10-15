import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../data/models/weather.dart';

/// Vivid orange weather card, matching the reference.
class WeatherCard extends StatelessWidget {
  const WeatherCard({super.key, required this.weather});

  final Weather weather;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[AppColors.accent, Color(0xFFFF7A3D)],
        ),
        boxShadow: AppColors.glowAccent,
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Icon(
                Icons.location_on_rounded,
                color: Colors.white,
                size: 16,
              ),
              const SizedBox(width: 6),
              Flexible(
                child: Text(
                  weather.location,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
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
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -1.5,
                ),
              ),
              const Spacer(),
              Icon(weather.icon, color: Colors.white, size: 40),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            weather.condition,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.85),
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
