import 'package:flutter/material.dart';

/// Current weather shown on the dashboard.
@immutable
class Weather {
  const Weather({
    required this.city,
    required this.country,
    required this.temperature,
    required this.condition,
    required this.icon,
  });

  final String city;
  final String country;
  final int temperature;
  final String condition;
  final IconData icon;

  String get location => '$city, $country';
}
