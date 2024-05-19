import 'package:flutter/material.dart';

import 'package:post_board/common/common.dart';
import 'package:post_board/models/models.dart';
import 'package:post_board/widgets/widgets.dart';

import 'generic_dialog.dart';

class ContactDialog extends StatefulWidget {
  final String? title;
  final Contact initialValue;
  final String? hintText;
  final String? errorText;

  const ContactDialog({
    this.title,
    required this.initialValue,
    this.hintText,
    this.errorText,
    super.key,
  });

  @override
  State<ContactDialog> createState() => _ContactDialogState();
}

class _ContactDialogState extends State<ContactDialog> {
  final formKey = GlobalKey<FormState>();
  late Contact selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.initialValue;
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
          child: ContactField(
            initialValue: selectedValue,
            hintText: widget.hintText,
            errorText: widget.errorText,
            onSaved: (value) => selectedValue = value!,
          ),
        ),
        actions: [
          DialogActionButton.save(context, () => selectedValue, formKey),
        ],
      ),
    );
  }
}
