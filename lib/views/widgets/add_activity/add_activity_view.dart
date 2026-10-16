import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/models/activity_type.dart';
import '../../../viewmodels/add_activity_viewmodel.dart';
import '../common/field_label.dart';
import 'number_field.dart';
import 'type_chip.dart';

/// The log-activity form body.
class AddActivityView extends StatelessWidget {
  const AddActivityView({super.key});

  void _save(BuildContext context, AddActivityViewModel vm) {
    if (!vm.save()) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(const SnackBar(content: Text('Activity logged')));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final AddActivityViewModel vm = context.watch<AddActivityViewModel>();

    return Scaffold(
      appBar: AppBar(title: const Text('Log activity')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        children: <Widget>[
          const FieldLabel('Activity title'),
          const SizedBox(height: 8),
          TextField(
            onChanged: vm.setTitle,
            textCapitalization: TextCapitalization.sentences,
            decoration: const InputDecoration(hintText: 'e.g. Morning run'),
          ),
          const SizedBox(height: 24),
          const FieldLabel('Type'),
          const SizedBox(height: 12),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: <Widget>[
              for (final ActivityType type in ActivityType.values)
                TypeChip(
                  type: type,
                  selected: vm.type == type,
                  onTap: () => vm.setType(type),
                ),
            ],
          ),
          const SizedBox(height: 24),
          const FieldLabel('Duration (minutes)'),
          const SizedBox(height: 8),
          NumberField(
            initialValue: vm.minutes,
            hint: '30',
            onChanged: vm.setMinutes,
          ),
          const SizedBox(height: 24),
          Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const FieldLabel('Distance (km)'),
                    const SizedBox(height: 8),
                    NumberField(hint: '0.0', onChanged: vm.setDistance),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const FieldLabel('Steps'),
                    const SizedBox(height: 8),
                    NumberField(hint: '0', onChanged: vm.setSteps),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const FieldLabel('Calories'),
          const SizedBox(height: 8),
          NumberField(hint: '0', onChanged: vm.setCalories),
          const SizedBox(height: 32),
          FilledButton(
            onPressed: vm.isValid ? () => _save(context, vm) : null,
            child: const Text('Save activity'),
          ),
        ],
      ),
    );
  }
}
