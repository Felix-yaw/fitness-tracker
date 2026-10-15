import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/theme/app_theme.dart';
import 'data/repositories/fitness_repository.dart';
import 'views/screens/root_shell.dart';
import 'views/widgets/common/app_background.dart';

void main() {
  runApp(const FitnessTrackerApp());
}

/// App root. Provides the single [FitnessRepository] (the MVVM model layer);
/// the ViewModels depend on it and are provided per screen/tab.
class FitnessTrackerApp extends StatelessWidget {
  const FitnessTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FitnessRepository>(
      create: (_) => FitnessRepository(),
      child: MaterialApp(
        title: 'Fitness Tracker',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light(),
        builder: (BuildContext context, Widget? child) =>
            AppBackground(child: child ?? const SizedBox.shrink()),
        home: const RootShell(),
      ),
    );
  }
}
