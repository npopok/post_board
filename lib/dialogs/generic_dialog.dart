import 'dart:io';

import 'package:flutter/material.dart';

import 'package:post_board/common/common.dart';

class GenericDialog extends StatelessWidget {
  final String? title;
  final EdgeInsets contentPadding;
  final Widget Function(BuildContext) contentBuilder;
  final List<DialogActionButton>? actions;

  const GenericDialog({
    this.title,
    required this.contentPadding,
    required this.contentBuilder,
    this.actions,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Platform.isIOS ? kiOSDialogPadding : kAndroidDialogPadding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (title != null)
            Padding(
              padding: kDialogTitlePadding,
              child: Text(title!, style: Theme.of(context).textTheme.titleLarge),
            ),
          Padding(
            padding: contentPadding,
            child: contentBuilder(context),
          ),
          if (actions != null && actions!.isNotEmpty) _buildActionButtons(context),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        const Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: actions!,
        ),
      ],
    );
  }
}

class DialogActionButton extends StatelessWidget {
  final String title;
  final Function() onPressed;

  const DialogActionButton({
    required this.title,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: TextButton(
          onPressed: onPressed,
          child: Text(title),
        ),
      ),
    );
  }
}
