import 'package:flutter/material.dart';

import 'package:post_board/dialogs/dialogs.dart';

class DropdownField<T> extends FormField<T> {
  final List<T> values;
  final String hintText;
  final String errorText;
  final String Function(T) textBuilder;

  DropdownField({
    required super.initialValue,
    required this.values,
    required this.hintText,
    required this.errorText,
    required this.textBuilder,
    required super.onSaved,
    super.key,
  }) : super(
          builder: (FormFieldState<T> state) {
            final text = state.value != null ? textBuilder(state.value as T) : '';
            return TextFormField(
              key: Key(text),
              initialValue: text,
              readOnly: true,
              decoration: InputDecoration(
                hintText: hintText,
                border: const OutlineInputBorder(),
                suffixIcon: const Icon(Icons.arrow_drop_down, size: 24),
              ),
              onTap: () async {
                final value = await showModalBottomSheet<T>(
                  isScrollControlled: true,
                  context: state.context,
                  builder: (_) => ValueListDialog<T>(
                    values: values,
                    textBuilder: textBuilder,
                    initialValue: initialValue,
                  ),
                );
                if (value != null) {
                  state.didChange(value);
                }
              },
              validator: (_) => state.value == null ? errorText : null,
            );
          },
        );
}
