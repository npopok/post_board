import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:post_board/common/common.dart';

import 'generic_dialog.dart';

class ValueListDialog<T> extends StatelessWidget {
  static const contentFraction = 0.75;

  final String? title;
  final List<T> values;
  final String Function(T) textBuilder;
  final T? initialValue;
  final AlignmentGeometry alignment;

  const ValueListDialog({
    this.title,
    required this.values,
    required this.textBuilder,
    this.initialValue,
    this.alignment = Alignment.centerLeft,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GenericDialog(
      title: title,
      contentPadding: DialogPaddings.defaultContent,
      contentBuilder: _buildContent,
    );
  }

  Widget _buildContent(BuildContext context) {
    return LimitedBox(
      maxHeight: MediaQuery.of(context).size.height * contentFraction,
      child: SingleChildScrollView(
        child: Column(
          children: values
              .map((value) => ListTile(
                    contentPadding: DialogPaddings.valueTile,
                    title: Align(
                      alignment: alignment,
                      child: Text(
                        textBuilder(value),
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                    leading: alignment == Alignment.center ? const Icon(null) : null,
                    trailing: Icon(value == initialValue ? Icons.check : null),
                    onTap: () => context.maybePop(value),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
