import 'package:flutter/material.dart';

import 'package:post_board/helpers/date_helper.dart';
import 'package:post_board/models/models.dart';

class PostDetails extends StatelessWidget {
  final Post post;

  const PostDetails({required this.post, super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('${post.author.name}, ${post.author.age}'),
      subtitle: Text(post.text),
      trailing: Text(post.timestamp.formatTimeSinceNow()),
    );
  }
}
