import 'package:flutter/material.dart';
import 'package:format/format.dart';

import 'package:post_board/common/common.dart';
import 'package:post_board/models/models.dart';

import 'generic_dialog.dart';

class SliderDialog extends StatefulWidget {
  final String title;
  final String titleEmpty;
  final String buttonTitle;
  final NumericRange range;
  final int initialValue;

  const SliderDialog({
    required this.title,
    required this.titleEmpty,
    required this.buttonTitle,
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
      title: _formatTitle(),
      contentPadding: DialogPaddings.sliderContent,
      contentBuilder: _buildContent,
      actions: [
        DialogActionButton.submit(
          context,
          widget.buttonTitle,
          () => selectedValue,
        ),
      ],
    );
  }

  Widget _buildContent(BuildContext context) {
    final value = selectedValue.clamp(widget.range.min, widget.range.max);

    return Slider(
      min: widget.range.min.toDouble(),
      max: widget.range.max.toDouble(),
      divisions: widget.range.max - widget.range.min,
      value: value.toDouble(),
      label: value.toString(),
      onChanged: (value) => setState(() => selectedValue = value.round()),
    );
  }

  String _formatTitle() {
    if (selectedValue >= widget.range.min && selectedValue <= widget.range.max) {
      return format(widget.title, selectedValue);
    } else {
      return widget.titleEmpty;
    }
  }
}
