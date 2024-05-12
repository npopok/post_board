import 'package:flutter/material.dart';

import 'package:post_board/common/common.dart';
import 'package:post_board/models/models.dart';

import 'generic_dialog.dart';

class RangeDialog extends StatefulWidget {
  final String? title;
  final NumericRange range;
  final NumericRange initialValue;

  const RangeDialog({
    this.title,
    required this.range,
    required this.initialValue,
    super.key,
  });

  @override
  State<RangeDialog> createState() => _RangeDialogState();
}

class _RangeDialogState extends State<RangeDialog> {
  late NumericRange selectedValues;

  @override
  void initState() {
    super.initState();
    selectedValues = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return GenericDialog(
      title: widget.title,
      contentPadding: kSliderContentPadding,
      contentBuilder: _buildContent,
      actions: [DialogActionButton.save(context, () => selectedValues)],
    );
  }

  Widget _buildContent(BuildContext context) {
    return RangeSlider(
      min: widget.range.min.toDouble(),
      max: widget.range.max.toDouble(),
      divisions: widget.range.max - widget.range.min,
      values: RangeValues(
        selectedValues.min.toDouble(),
        selectedValues.max.toDouble(),
      ),
      labels: RangeLabels(
        selectedValues.min.toString(),
        selectedValues.max.toString(),
      ),
      onChanged: (values) => setState(
        () => selectedValues = (
          min: values.start.round(),
          max: values.end.round(),
        ),
      ),
    );
  }
}
