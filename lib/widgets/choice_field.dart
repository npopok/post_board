import 'package:flutter/material.dart';

class ChoiceField<T> extends FormField<T> {
  final Axis direction;
  final List<T> values;
  final String Function(T) textBuilder;
  final Function(T)? onChanged;

  ChoiceField({
    this.direction = Axis.horizontal,
    required this.values,
    required this.textBuilder,
    this.onChanged,
    super.onSaved,
    super.initialValue,
    super.validator,
    super.key,
  }) : super(
          builder: (FormFieldState<T> state) {
            final colorScheme = Theme.of(state.context).colorScheme;
            return Wrap(
              spacing: 12,
              direction: direction,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: values
                  .map(
                    (e) => ChoiceChip(
                      showCheckmark: false,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: state.hasError ? colorScheme.error : colorScheme.outline,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      label: Text(textBuilder(e)),
                      selected: e == state.value,
                      onSelected: (value) {
                        state.didChange(e);
                        onChanged?.call(e);
                      },
                    ),
                  )
                  .toList(),
            );
          },
        );
}
