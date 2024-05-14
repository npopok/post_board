import 'package:flutter/material.dart';

import 'package:post_board/models/models.dart';

import 'posts_list_item.dart';
import 'posts_placeholder.dart';
import 'category_filter.dart';

class PostsListView extends StatelessWidget {
  final List<Post> posts;

  const PostsListView({
    required this.posts,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(child: CategoryFilter()),
        posts.isNotEmpty
            ? SliverList.builder(
                itemCount: posts.length,
                itemBuilder: (context, index) => PostListItem(post: posts[index]),
              )
            : const SliverFillRemaining(child: PostsPlaceholder()),
      ],
    );
  }
}
