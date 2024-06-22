import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:post_board/common/common.dart';
import 'package:post_board/helpers/helpers.dart';
import 'package:post_board/models/models.dart';
import 'package:post_board/widgets/widgets.dart';

import 'generic_dialog.dart';

class SubmitDialog extends StatefulWidget {
  final String title;
  final String buttonTitle;
  final String? errorText;

  const SubmitDialog({
    required this.title,
    required this.buttonTitle,
    this.errorText,
    super.key,
  });

  @override
  State<SubmitDialog> createState() => _SubmitDialogState();
}

class _SubmitDialogState extends State<SubmitDialog> {
  final formKey = GlobalKey<FormState>();
  Category? category;
  String? text;
  bool showDistance = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: GenericDialog(
        title: widget.title,
        contentPadding: DialogPaddings.inputContent,
        contentBuilder: (context) => Form(
          key: formKey,
          child: _buildTextFields(context),
        ),
        actions: [
          DialogActionButton.submit(
            context,
            widget.buttonTitle,
            () => (category, text),
            formKey,
          ),
        ],
      ),
    );
  }

  Widget _buildTextFields(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        DropdownField<Category>(
          values: Category.values,
          initialValue: category,
          hintText: 'SubmitDialog.CategoryHint'.tr(),
          errorText: '',
          textBuilder: (value) => value.toString().tr(),
          onChanged: (value) => setState(() => category = value),
        ),
        FormLayout.inputSpacer,
        TextFormField(
          maxLines: 6,
          maxLength: FieldConstraints.postMaxLength,
          textCapitalization: TextCapitalization.sentences,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            hintText: 'SubmitDialog.TextHint'.tr(),
            counterText: '',
          ),
          validator: const TextLengthValidator(
            emptyMessage: '',
            minLength: FieldConstraints.postMinLength,
            minMessage: '',
          ).validate,
          onSaved: (value) => text = value!,
        ),
      ],
    );
  }
}
