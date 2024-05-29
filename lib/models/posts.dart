import 'package:freezed_annotation/freezed_annotation.dart';

import 'post.dart';

part 'posts.freezed.dart';
part 'posts.g.dart';

@freezed
class Posts with _$Posts {
  const factory Posts({
    required final List<Post> items,
    required final bool isFirst,
    required final bool hasMore,
  }) = _Posts;

  factory Posts.fromJson(Map<String, dynamic> json) => _$PostsFromJson(json);
}
