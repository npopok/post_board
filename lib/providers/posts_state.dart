import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:post_board/common/common.dart';
import 'package:post_board/models/models.dart';
import 'package:post_board/repositories/repositories.dart';

part 'posts_state.g.dart';

@riverpod
class PostsState extends _$PostsState {
  @override
  Stream<List<Post>> build() => getIt<CloudRepository>().loadPosts();

  Future<void> submitPost(Profile profile, Category category, String text) {
    final post = Post(
      author: Author(
        name: profile.name,
        age: profile.age,
        gender: profile.gender,
      ),
      category: category,
      text: text,
      timestamp: DateTime.timestamp(),
    );
    return getIt<CloudRepository>().savePost(post);
  }
}
