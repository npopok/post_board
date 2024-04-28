import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:post_board/common/common.dart';

import 'generic_dialog.dart';

class ActionDialog<T> extends StatelessWidget {
  final Map<T, String> actions;

  const ActionDialog({
    required this.actions,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GenericDialog(
      contentPadding: kDefaultContentPadding,
      contentBuilder: _buildContent,
    );
  }

  Widget _buildContent(BuildContext context) {
    final entries = actions.entries.toList();

    return ListView.builder(
      shrinkWrap: true,
      itemCount: actions.length,
      itemBuilder: (context, index) => ListTile(
        contentPadding: kValueTilePadding,
        title: Text(
          entries[index].value,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        onTap: () => context.maybePop(entries[index].key),
      ),
    );
  }
}
