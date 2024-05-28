import 'package:flutter/material.dart';

import 'package:post_board/helpers/helpers.dart';

class PostsListError extends StatelessWidget {
  final String errorText;

  const PostsListError({
    required this.errorText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 24),
      child: context.textError(errorText),
    );
  }
}
