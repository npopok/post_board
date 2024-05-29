import 'package:post_board/providers/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:post_board/common/common.dart';
import 'package:post_board/models/models.dart';
import 'package:post_board/repositories/repositories.dart';
import 'package:post_board/helpers/helpers.dart';

part 'posts_state.g.dart';

@riverpod
class PostsState extends _$PostsState {
  @override
  Future<Posts> build() => loadData();

  Future<Posts> loadData() async {
    ref.cacheFor(RepositorySettings.postsCacheDuration);

    final filters = ref.watch(filtersStateProvider);
    return remoteRepository.loadPosts(filters, null);
  }

  Future<void> loadNext() async {
    if (state is AsyncLoading) {
      // 1
      print('Already loading next page');
      return;
    }
    if (!state.requireValue.hasMore) {
      // 2
      print('No more pages to load');
      return;
    }

    state = await AsyncValue.guard(() async {
      final filters = ref.watch(filtersStateProvider);
      return remoteRepository.loadPosts(filters, state.requireValue);
    });
  }
}
