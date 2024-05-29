import 'dart:async';

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
  Future<List<Post>> build(Filters filters) => loadData(filters);

  Future<List<Post>> loadData(Filters filters) async {
    ref.cacheFor(RepositorySettings.postsCacheDuration);
    return remoteRepository.loadPosts(filters, RepositorySettings.postsMaxId);
  }

  Future<void> loadNext() async {
    state.whenData(
      (data) async {
        if (data.isNotEmpty) {
          state = await AsyncValue.guard(() async {
            final posts = await remoteRepository.loadPosts(filters, state.value!.last.id);
            return [...data, ...posts];
          });
        }
      },
    );
  }
}
