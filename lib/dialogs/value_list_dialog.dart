import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:post_board/common/common.dart';

import 'generic_dialog.dart';

class ValueListDialog<T> extends StatelessWidget {
  static const contentFraction = 0.75;

  final List<String> items;
  final List<T> values;
  final T? initialValue;
  final AlignmentGeometry alignment;
  final bool clearButton;

  const ValueListDialog({
    required this.items,
    required this.values,
    this.initialValue,
    this.alignment = Alignment.centerLeft,
    this.clearButton = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GenericDialog(
      contentPadding: kValueContentPadding,
      contentBuilder: _buildContent,
      actions: [
        if (clearButton)
          DialogActionButton(
            title: 'Button.Clear'.tr(),
            onPressed: () => context.maybePop(''),
          ),
      ],
    );
  }

  Widget _buildContent(BuildContext context) {
    return LimitedBox(
      maxHeight: MediaQuery.of(context).size.height * contentFraction,
      child: SingleChildScrollView(
        child: Column(
          children: List.generate(
            items.length,
            (index) => ListTile(
              contentPadding: kValueTilePadding,
              title: Align(
                alignment: alignment,
                child: Text(
                  items[index],
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              leading: alignment == Alignment.center ? const Icon(null) : null,
              trailing: Icon(values[index] == initialValue ? Icons.check : null),
              onTap: () => context.maybePop(values[index]),
            ),
          ),
        ),
      ),
    );
  }
}
