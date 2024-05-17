import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:post_board/common/common.dart';

class PostsPlaceholder extends StatelessWidget {
  const PostsPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'PostsPlaceholder.EmptyTitle'.tr(),
          style: Theme.of(context).textTheme.titleMedium,
        ),
        FormSettings.textSpacer,
        Text('PostsPlaceholder.EmptyText'.tr()),
      ],
    );
  }
}
