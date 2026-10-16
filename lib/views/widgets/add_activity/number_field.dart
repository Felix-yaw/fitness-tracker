import 'package:flutter/material.dart';

/// Numeric text field used by the log-activity form.
class NumberField extends StatefulWidget {
  const NumberField({
    super.key,
    this.initialValue,
    required this.hint,
    required this.onChanged,
  });

  final String? initialValue;
  final String hint;
  final ValueChanged<String> onChanged;

  @override
  State<NumberField> createState() => _NumberFieldState();
}

class _NumberFieldState extends State<NumberField> {
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
