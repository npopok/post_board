import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      value: widget.values.contains(widget.initialValue) ? widget.initialValue : null,
      isExpanded: true,
      decoration: InputDecoration(
        hintText: widget.hintText,
        border: const OutlineInputBorder(),
      ),
      items: List<DropdownMenuItem<T>>.generate(
        widget.values.length,
        (index) => DropdownMenuItem<T>(
          value: widget.values[index],
          child: Text(widget.textBuilder(widget.values[index])),
        ),
      ),
      selectedItemBuilder: (context) => List<Widget>.generate(
        widget.values.length,
        (index) => Text(
          widget.textBuilder(widget.values[index]),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      onChanged: (value) {},
      onSaved: (value) => widget.onSaved(value),
      validator: (value) => value == null ? widget.errorText : null,
    );
  }
}
