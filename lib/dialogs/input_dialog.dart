import 'package:flutter/material.dart';

import 'package:post_board/common/common.dart';

import 'generic_dialog.dart';

class InputDialog extends StatefulWidget {
  final String? title;
  final String? initialValue;
  final int? maxLength;

  const InputDialog({
    this.title,
    this.initialValue,
    this.maxLength,
    super.key,
  });

  @override
  State<InputDialog> createState() => _InputDialogState();
}

class _InputDialogState extends State<InputDialog> {
  late TextEditingController textController;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController(text: widget.initialValue);
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: GenericDialog(
        title: widget.title,
        contentPadding: DialogPaddings.inputContent,
        contentBuilder: (_) => TextField(
          controller: textController,
          maxLength: widget.maxLength,
          decoration: const InputDecoration(counterText: ''),
        ),
        actions: [DialogActionButton.save(context, () => textController.text)],
      ),
    );
  }
}
