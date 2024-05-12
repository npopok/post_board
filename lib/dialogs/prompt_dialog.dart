import 'package:flutter/material.dart';

import 'package:post_board/common/common.dart';

import 'generic_dialog.dart';

class PromptDialog extends StatelessWidget {
  final String title;
  final String text;

  const PromptDialog({
    required this.title,
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GenericDialog(
      title: title,
      contentPadding: DialogPaddings.promptContent,
      contentBuilder: (_) => Text(
        text,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      actions: [DialogActionButton.save(context, () => true)],
    );
  }
}
