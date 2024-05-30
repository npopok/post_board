import 'package:flutter/material.dart';

import 'package:post_board/common/common.dart';
import 'package:post_board/helpers/helpers.dart';

import 'generic_dialog.dart';

class InputDialog extends StatefulWidget {
  final String title;
  final String buttonTitle;
  final String? initialValue;
  final int? maxLength;
  final String? errorText;

  const InputDialog({
    required this.title,
    required this.buttonTitle,
    this.initialValue,
    this.maxLength,
    this.errorText,
    super.key,
  });

  @override
  State<InputDialog> createState() => _InputDialogState();
}

class _InputDialogState extends State<InputDialog> {
  final formKey = GlobalKey<FormState>();
  late String selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.initialValue ?? '';
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
        contentBuilder: (_) => Form(
          key: formKey,
          child: TextFormField(
            initialValue: selectedValue,
            maxLength: widget.maxLength,
            textCapitalization: TextCapitalization.words,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: const InputDecoration(counterText: ''),
            validator: TextLengthValidator(
              emptyMessage: widget.errorText,
            ).validate,
            onSaved: (value) => selectedValue = value!,
          ),
        ),
        actions: [
          DialogActionButton.submit(
            context,
            widget.buttonTitle,
            () => selectedValue,
            formKey,
          ),
        ],
      ),
    );
  }
}
