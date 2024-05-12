import 'package:flutter/material.dart';

import 'package:post_board/common/common.dart';
import 'package:post_board/models/models.dart';

import 'generic_dialog.dart';

class SliderDialog extends StatefulWidget {
  final String? title;
  final NumericRange range;
  final int initialValue;

  const SliderDialog({
    this.title,
    required this.range,
    required this.initialValue,
    super.key,
  });

  @override
  State<SliderDialog> createState() => _SliderDialogState();
}

class _SliderDialogState extends State<SliderDialog> {
  late int selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return GenericDialog(
      title: widget.title,
      contentPadding: kSliderContentPadding,
      contentBuilder: _buildContent,
      actions: [DialogActionButton.save(context, () => selectedValue)],
    );
  }

  Widget _buildContent(BuildContext context) {
    return Slider(
      min: widget.range.min.toDouble(),
      max: widget.range.max.toDouble(),
      divisions: widget.range.max - widget.range.min,
      value: selectedValue.toDouble(),
      label: selectedValue.toString(),
      onChanged: (value) => setState(() => selectedValue = value.round()),
    );
  }
}
