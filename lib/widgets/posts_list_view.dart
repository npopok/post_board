import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:post_board/models/models.dart';
import 'package:post_board/widgets/widgets.dart';

class PostsListView extends ConsumerWidget {
  final List<Post> posts;

  const PostsListView({
    required this.posts,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomScrollView(
      slivers: [
        posts.isNotEmpty
            ? SliverList.builder(
                itemCount: posts.length,
                itemBuilder: (context, index) => PostListItem(post: posts[index]),
              )
            : const SliverFillRemaining(child: PostsPlaceholder(showError: false)),
      ],
    );
  }
}
