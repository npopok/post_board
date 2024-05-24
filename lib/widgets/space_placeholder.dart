import 'package:flutter/material.dart';

import 'package:post_board/common/common.dart';

class SpacePlaceholder extends StatelessWidget {
  final String text;
  final bool showError;

  const SpacePlaceholder({
    required this.text,
    required this.showError,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final color = showError ? Theme.of(context).colorScheme.error : null;
    final lines = text.split('\n');

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          lines[0],
          style: Theme.of(context).textTheme.titleMedium!.copyWith(color: color),
        ),
        FormLayout.textSpacer,
        Text(
          lines[1],
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: color),
        ),
      ],
    );
  }
}
