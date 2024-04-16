import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:post_board/common/common.dart';

import 'generic_dialog.dart';

class RadioListDialog<T> extends StatelessWidget {
  final String title;
  final List<String> items;
  final List<T> values;
  final T initialValue;

  const RadioListDialog({
    required this.title,
    required this.items,
    required this.values,
    required this.initialValue,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GenericDialog(
      title: title,
      contentPadding: kDefaultContentPadding,
      contentBuilder: _buildContent,
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      children: List.generate(
        values.length,
        (index) => RadioListTile(
          value: values[index],
          groupValue: initialValue,
          title: Text(items[index]),
          onChanged: (value) => context.maybePop(value),
        ),
      ),
    );
  }
}
