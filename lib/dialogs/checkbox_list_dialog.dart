import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:post_board/common/common.dart';
import 'generic_dialog.dart';

class CheckboxListDialog extends StatefulWidget {
  final String title;
  final List<String> items;
  final List<bool> values;
  final bool Function(List<bool>) onValidate;

  const CheckboxListDialog({
    required this.title,
    required this.items,
    required this.values,
    required this.onValidate,
    super.key,
  });

  @override
  State<CheckboxListDialog> createState() => _CheckboxListDialogState();
}

class _CheckboxListDialogState extends State<CheckboxListDialog> {
  late List<bool> checks;

  @override
  void initState() {
    checks = List<bool>.from(widget.values);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GenericDialog(
      title: widget.title,
      contentPadding: kDefaultContentPadding,
      contentBuilder: _buildContent,
      actions: [
        DialogActionButton(
          title: 'Button.Cancel'.tr(),
          onPressed: () => context.maybePop(),
        ),
        DialogActionButton(
          title: 'Button.OK'.tr(),
          onPressed: () => context.maybePop(checks),
        ),
      ],
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      children: List.generate(
        checks.length,
        (index) => CheckboxListTile(
          controlAffinity: ListTileControlAffinity.leading,
          value: checks[index],
          title: Text(widget.items[index].toString()),
          onChanged: (value) => _changeCheckHandler(checks, index, value!),
        ),
      ),
    );
  }

  void _changeCheckHandler(List<bool> checks, int index, bool value) {
    checks[index] = value;
    if (widget.onValidate(checks)) {
      setState(() {});
    } else {
      checks[index] = value;
    }
  }
}
