import 'package:flutter/material.dart';

import '../views/screens/activities_screen.dart';
import '../views/screens/add_activity_screen.dart';

/// Centralised Navigator helpers.
abstract final class AppRoutes {
  static Future<void> openActivities(BuildContext context) {
    return Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => const ActivitiesScreen()),
    );
  }

  static Future<void> openAddActivity(BuildContext context) {
    return Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => const AddActivityScreen()),
    );
  }
}
