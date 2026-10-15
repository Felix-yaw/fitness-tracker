import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/theme/app_colors.dart';
import '../../data/models/activity_type.dart';
import '../../data/repositories/fitness_repository.dart';
import '../../viewmodels/add_activity_viewmodel.dart';

/// Log-activity form screen.
class AddActivityScreen extends StatelessWidget {
  const AddActivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddActivityViewModel>(
      create: (BuildContext ctx) =>
          AddActivityViewModel(ctx.read<FitnessRepository>()),
      child: const _AddActivityView(),
    );
  }
}

class _AddActivityView extends StatelessWidget {
  const _AddActivityView();

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
          const _Label('Activity title'),
          const SizedBox(height: 8),
          TextField(
            onChanged: vm.setTitle,
            textCapitalization: TextCapitalization.sentences,
            decoration: const InputDecoration(hintText: 'e.g. Morning run'),
          ),
          const SizedBox(height: 24),
          const _Label('Type'),
          const SizedBox(height: 12),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: <Widget>[
              for (final ActivityType type in ActivityType.values)
                _TypeChip(
                  type: type,
                  selected: vm.type == type,
                  onTap: () => vm.setType(type),
                ),
            ],
          ),
          const SizedBox(height: 24),
          const _Label('Duration (minutes)'),
          const SizedBox(height: 8),
          _NumberField(
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
                    const _Label('Distance (km)'),
                    const SizedBox(height: 8),
                    _NumberField(hint: '0.0', onChanged: vm.setDistance),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const _Label('Steps'),
                    const SizedBox(height: 8),
                    _NumberField(hint: '0', onChanged: vm.setSteps),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const _Label('Calories'),
          const SizedBox(height: 8),
          _NumberField(hint: '0', onChanged: vm.setCalories),
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

class _Label extends StatelessWidget {
  const _Label(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w700,
        color: AppColors.inkSecondary,
      ),
    );
  }
}

class _NumberField extends StatefulWidget {
  const _NumberField({
    this.initialValue,
    required this.hint,
    required this.onChanged,
  });

  final String? initialValue;
  final String hint;
  final ValueChanged<String> onChanged;

  @override
  State<_NumberField> createState() => _NumberFieldState();
}

class _NumberFieldState extends State<_NumberField> {
  late final TextEditingController _controller = TextEditingController(
    text: widget.initialValue,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      onChanged: widget.onChanged,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(hintText: widget.hint),
    );
  }
}

class _TypeChip extends StatelessWidget {
  const _TypeChip({
    required this.type,
    required this.selected,
    required this.onTap,
  });

  final ActivityType type;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? type.color : Colors.white.withValues(alpha: 0.7),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: selected ? type.color : Colors.white.withValues(alpha: 0.9),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              type.icon,
              size: 16,
              color: selected ? Colors.white : type.color,
            ),
            const SizedBox(width: 8),
            Text(
              type.label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: selected ? Colors.white : AppColors.ink,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
