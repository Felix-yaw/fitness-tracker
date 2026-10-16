import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/repositories/fitness_repository.dart';
import '../../viewmodels/add_activity_viewmodel.dart';
import '../widgets/add_activity/add_activity_view.dart';

/// Log-activity form screen; provides its view-model and hosts the form.
class AddActivityScreen extends StatelessWidget {
  const AddActivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddActivityViewModel>(
      create: (BuildContext ctx) =>
          AddActivityViewModel(ctx.read<FitnessRepository>()),
      child: const AddActivityView(),
    );
  }
}
