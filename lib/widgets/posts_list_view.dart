import 'package:flutter/material.dart';

import 'package:post_board/models/models.dart';

import 'posts_list_item.dart';
import 'posts_placeholder.dart';

class PostsListView extends StatelessWidget {
  final List<Post> posts;

  const PostsListView({
    required this.posts,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return posts.isNotEmpty
        ? ListView.builder(
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            itemCount: posts.length,
            itemBuilder: (context, index) => PostListItem(post: posts[index]),
          )
        : const PostsPlaceholder();
  }
}
