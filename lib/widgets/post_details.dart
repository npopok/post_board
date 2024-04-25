import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:post_board/helpers/date_helper.dart';
import 'package:post_board/models/models.dart';

import 'contact_field.dart';

class PostDetails extends StatelessWidget {
  final Post post;

  const PostDetails({required this.post, super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('${post.author}, ${post.age}'),
          Text(
            post.timestamp.formatTimeSinceNow(),
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(post.text),
          // Align(
          //   alignment: Alignment.centerRight,
          //   child: ContactField(contact: post.contact),
          // ),
        ],
      ),
      onTap: () => null,
    );
  }
}
