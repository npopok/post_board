import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:post_board/common/common.dart';

class PostsPlaceholder extends StatelessWidget {
  final bool showError;

  const PostsPlaceholder({
    required this.showError,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final color = showError ? Theme.of(context).colorScheme.error : null;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildTitle(context, color),
        FormLayout.textSpacer,
        _buildText(context, color),
      ],
    );
  }

  Widget _buildTitle(BuildContext context, Color? color) {
    return Text(
      showError ? 'PostsPlaceholder.ErrorTitle'.tr() : 'PostsPlaceholder.EmptyTitle'.tr(),
      style: Theme.of(context).textTheme.titleMedium!.copyWith(color: color),
    );
  }

  Widget _buildText(BuildContext context, Color? color) {
    return Text(
      showError ? 'PostsPlaceholder.ErrorText'.tr() : 'PostsPlaceholder.EmptyText'.tr(),
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: color),
    );
  }
}
