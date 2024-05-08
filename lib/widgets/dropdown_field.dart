import 'package:flutter/material.dart';

import 'package:post_board/dialogs/dialogs.dart';

class DropdownField<T> extends StatefulWidget {
  final List<T> values;
  final T? initialValue;
  final String hintText;
  final String errorText;
  final String Function(T) textBuilder;
  final Function(T?) onSaved;

  const DropdownField({
    required this.values,
    required this.initialValue,
    required this.hintText,
    required this.errorText,
    required this.textBuilder,
    required this.onSaved,
    super.key,
  });

  @override
  State<DropdownField<T>> createState() => _DropdownFieldState<T>();
}

class _DropdownFieldState<T> extends State<DropdownField<T>> {
  late T? selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    final text = selectedValue != null ? widget.textBuilder(selectedValue as T) : '';
    return TextFormField(
      key: Key(text),
      initialValue: text,
      readOnly: true,
      decoration: InputDecoration(
        hintText: widget.hintText,
        border: const OutlineInputBorder(),
        suffixIcon: const Icon(Icons.arrow_drop_down, size: 24),
      ),
      onTap: () => _selectValue(context),
      validator: (_) => selectedValue == null ? widget.errorText : null,
    );
  }

  void _selectValue(BuildContext context) async {
    final value = await showModalBottomSheet<T>(
      isScrollControlled: true,
      context: context,
      builder: (_) => ValueListDialog<T>(
        items: List<String>.generate(
          widget.values.length,
          (index) => widget.textBuilder(widget.values[index]),
        ),
        values: widget.values,
        initialValue: widget.initialValue,
      ),
    );
    if (value != null) {
      setState(() => selectedValue = value);
      widget.onSaved(value);
    }
  }
}
