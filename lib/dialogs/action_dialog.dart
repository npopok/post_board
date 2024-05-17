import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:post_board/common/common.dart';

import 'generic_dialog.dart';

class ActionItem<T> {
  final T value;
  final String text;
  final Widget icon;

  const ActionItem({
    required this.value,
    required this.text,
    required this.icon,
  });
}

class ActionDialog<T> extends StatelessWidget {
  final int itemCount;
  final ActionItem Function(int) itemBuilder;

  const ActionDialog({
    required this.itemCount,
    required this.itemBuilder,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GenericDialog(
      contentPadding: DialogPaddings.defaultContent,
      contentBuilder: _buildContent,
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      children: List.generate(
        itemCount,
        (index) => _buildListTile(context, index),
      ),
    );
  }

  Widget _buildListTile(BuildContext context, int index) {
    final action = itemBuilder(index);
    return ListTile(
      contentPadding: DialogPaddings.valueTile,
      leading: action.icon,
      title: Text(
        action.text,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      onTap: () => context.maybePop(action.value),
    );
  }
}
