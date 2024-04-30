import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:post_board/common/common.dart';
import 'package:post_board/models/models.dart';
import 'package:post_board/repositories/repositories.dart';
import 'package:post_board/helpers/helpers.dart';

part 'posts_state.g.dart';

@riverpod
class PostsState extends _$PostsState {
  @override
  Future<List<Post>> build(Filter filter) async => loadData(filter);

  Future<List<Post>> loadData(Filter filter) async {
    ref.cacheFor(kPostsCacheDuration);
    return getIt<CloudRepository>().loadPosts(filter);
  }
}
