import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:post_board/models/models.dart';
import 'package:post_board/providers/providers.dart';
import 'package:post_board/widgets/widgets.dart';

class PostsListView extends ConsumerStatefulWidget {
  final String emptyText;
  final String errorText;
  final String errorItem;

  const PostsListView({
    required this.emptyText,
    required this.errorText,
    required this.errorItem,
    super.key,
  });

  @override
  ConsumerState<PostsListView> createState() => _PostsListViewState();
}

class _PostsListViewState extends ConsumerState<PostsListView> {
  @override
  Widget build(BuildContext context) {
    final filters = ref.watch(filtersStateProvider);
    final posts = ref.watch(postsStateProvider(filters));

    return InfiniteListView<Post>(
      loadItems: () => posts,
      loadNext: () => ref.read(postsStateProvider(filters).notifier).loadNext(),
      refresh: () => ref.refresh(postsStateProvider(filters).future),
      itemBuilder: (_, item) => PostListItem(post: item),
      loadingIndicator: const Center(child: CircularProgressIndicator()),
      loadMoreIndicator: _buildLoadMoreIndicator(),
      emptyPlaceholder: EmptyPlaceholder(text: widget.emptyText),
      errorPlaceholder: ErrorPlaceholder(text: widget.errorText),
    );
  }

  Widget _buildLoadMoreIndicator() {
    return const Padding(
      padding: EdgeInsets.only(top: 8, bottom: 16),
      child: Center(
          child: SizedBox.square(
        dimension: 24,
        child: CircularProgressIndicator(strokeWidth: 3),
      )),
    );
  }
}
