import 'package:flutter/material.dart';

import 'package:post_board/common/common.dart';
import 'generic_dialog.dart';

class CheckListDialog extends StatefulWidget {
  final String title;
  final List<String> items;
  final List<bool> values;
  final bool Function(List<bool>) onValidate;

  const CheckListDialog({
    required this.title,
    required this.items,
    required this.values,
    required this.onValidate,
    super.key,
  });

  @override
  State<CheckListDialog> createState() => _CheckListDialogState();
}

class _CheckListDialogState extends State<CheckListDialog> {
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
      contentPadding: DialogPaddings.defaultContent,
      contentBuilder: _buildContent,
      actions: [DialogActionButton.save(context, () => checks)],
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
