import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/repositories/fitness_repository.dart';
import '../../viewmodels/activities_viewmodel.dart';
import '../widgets/activities/activities_view.dart';

/// Full list of every logged activity.
class ActivitiesScreen extends StatelessWidget {
  const ActivitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ActivitiesViewModel>(
      create: (BuildContext ctx) =>
          ActivitiesViewModel(ctx.read<FitnessRepository>()),
      child: const ActivitiesView(),
    );
  }
}
