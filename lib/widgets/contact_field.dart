import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'package:post_board/common/common.dart';
import 'package:post_board/dialogs/dialogs.dart';
import 'package:post_board/helpers/helpers.dart';
import 'package:post_board/models/models.dart';
import 'package:post_board/widgets/widgets.dart';

class ContactField extends StatefulWidget {
  final Contact initialValue;
  final String? hintText;
  final String? errorText;
  final Function(Contact?)? onSaved;

  const ContactField({
    required this.initialValue,
    this.hintText,
    this.errorText,
    this.onSaved,
    super.key,
  });

  @override
  State<ContactField> createState() => _ContactFieldState();
}

class _ContactFieldState extends State<ContactField> {
  late Contact selectedValue;
  late TextEditingController textController;
  late Map<ContactType, MaskTextInputFormatter> inputFormatters;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.initialValue;

    _setInputFormatters();

    final formatter = inputFormatters[selectedValue.type]!;
    final value = formatter.formatEditUpdate(
      TextEditingValue.empty,
      TextEditingValue(text: selectedValue.toString()),
    );
    textController = TextEditingController(text: value.text);
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final readOnly = selectedValue.type == ContactType.unknown;
    final formatter = inputFormatters[selectedValue.type]!;

    return FormField<Contact>(
      builder: (FormFieldState<Contact> state) => TextFormField(
        controller: textController,
        readOnly: readOnly,
        maxLength: FieldConstraints.contactMaxLength,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        keyboardType: _getKeyboardType(),
        inputFormatters: [formatter],
        decoration: InputDecoration(
          counterText: '',
          hintText: readOnly ? widget.hintText : null,
          prefixIcon: IconButton(
            onPressed: () => _selectContactType(context),
            icon: ContactIcon(type: selectedValue.type),
          ),
        ),
        validator: (value) => _validateText(value, formatter.isFill()),
        onTap: () => readOnly ? _selectContactType(context) : null,
        onChanged: (value) {
          selectedValue = selectedValue.copyWith(
            details: formatter.getMaskedText().replaceAll(' ', ''),
          );
        },
      ),
      onSaved: (value) => widget.onSaved?.call(selectedValue),
    );
  }

  String? _validateText(String? value, bool isFilled) {
    if (Contact.parse(value!).type == selectedValue.type) {
      if (selectedValue.type == ContactType.phone && isFilled ||
          selectedValue.type != ContactType.phone) {
        return null;
      }
    }
    return widget.errorText;
  }

  TextInputType _getKeyboardType() {
    return switch (selectedValue.type) {
      ContactType.unknown => TextInputType.text,
      ContactType.email => TextInputType.emailAddress,
      ContactType.phone => TextInputType.phone,
      ContactType.telegram => TextInputType.emailAddress,
    };
  }

  void _setInputFormatters() {
    inputFormatters = {
      ContactType.unknown: MaskTextInputFormatter(),
      ContactType.email: MaskTextInputFormatter(
        mask: '#' * FieldConstraints.contactMaxLength,
        filter: {"#": RegExp(r'[0-9a-zA-Z@._-]')},
        type: MaskAutoCompletionType.lazy,
      ),
      ContactType.phone: MaskTextInputFormatter(
        mask: '${RegionalSettings.countryCode} ### ### ####',
        filter: {"#": RegExp(r'[0-9]')},
        type: MaskAutoCompletionType.eager,
      ),
      ContactType.telegram: MaskTextInputFormatter(
        mask: '@${"#" * (FieldConstraints.contactMaxLength - 1)}',
        filter: {"#": RegExp(r'[0-9a-zA-Z_.]')},
        type: MaskAutoCompletionType.lazy,
      ),
    };
  }

  void _selectContactType(BuildContext contect) async {
    final value = await showModalBottomSheet<ContactType>(
      isScrollControlled: true,
      context: context,
      builder: (_) => ValueListDialog<ContactType>(
        values: ContactType.values.exclude(ContactType.unknown),
        textBuilder: (value) => value.toString().tr(),
        initialValue: selectedValue.type,
      ),
    );
    if (value != null) {
      FocusManager.instance.primaryFocus?.unfocus();
      setState(() => _resetContactDetails(value));
    }
  }

  void _resetContactDetails(ContactType type) {
    selectedValue = Contact(type: type, details: '');
    textController.text = selectedValue.toString();
    inputFormatters[selectedValue.type]!.clear();
  }
}
