import 'package:post_board/providers/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:post_board/models/models.dart';
import 'package:post_board/common/common.dart';

part 'posts_state.g.dart';

@riverpod
class PostsState extends _$PostsState {
  @override
  Future<Posts> build() => loadData();

  Future<Posts> loadData() async {
    final filters = ref.watch(filtersStateProvider);
    return remoteRepository.loadPosts(filters, null);
  }

  Future<void> loadNext() async {
    state = await AsyncValue.guard(() async {
      final filters = ref.watch(filtersStateProvider);
      return remoteRepository.loadPosts(filters, state.requireValue);
    });
  }
}
