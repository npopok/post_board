import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:post_board/models/models.dart';
import 'package:post_board/providers/providers.dart';
import 'package:post_board/widgets/widgets.dart';

class PostsListView extends ConsumerStatefulWidget {
  static const scrollThreshold = 200;

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
  final scrollController = ScrollController();
  bool hasMore = true;
  bool isLoadingMore = false;

  @override
  void initState() {
    super.initState();

    scrollController.addListener(_scrollListener);
    ref.listenManual(postsStateProvider, (_, state) => _resetScrollPosition(state));
  }

  @override
  void dispose() {
    scrollController.removeListener(_scrollListener);
    scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final posts = ref.watch(postsStateProvider);

    return RefreshIndicator(
      onRefresh: () => ref.refresh(postsStateProvider.future),
      child: posts.when(
        data: (data) => data.items.isNotEmpty
            ? _buildListView(data)
            : _buildPlaceholder(EmptyPlaceholder(text: widget.emptyText)),
        error: (_, __) => _buildPlaceholder(ErrorPlaceholder(text: widget.errorText)),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }

  void _scrollListener() async {
    final maxPos = scrollController.position.maxScrollExtent;
    final currentPos = scrollController.position.pixels;
    bool showMore = (maxPos - currentPos) <= PostsListView.scrollThreshold;

    if (hasMore && showMore && !isLoadingMore) {
      isLoadingMore = true;

      await ref.read(postsStateProvider.notifier).loadNext();
      final posts = ref.read(postsStateProvider);
      if (posts.hasValue) hasMore = posts.value!.hasMore;

      print('loadNext(): hasMore = $hasMore');
      isLoadingMore = false;
    }
  }

  void _resetScrollPosition(AsyncValue<Posts> state) {
    if (state.hasValue && state.requireValue.isFirst) {
      print('Reset scroll controller');
      if (scrollController.hasClients) scrollController.jumpTo(0);
    }
  }

  Widget _buildListView(Posts posts) {
    print('_buildListView: data.length = ${posts.items.length}');

    return ListView.builder(
      controller: scrollController,
      itemCount: posts.items.length + (posts.hasMore ? 1 : 0),
      itemBuilder: (_, index) {
        if (index < posts.items.length) {
          return PostListItem(post: posts.items[index]);
        } else {
          return _buildLoadMoreIndicator();
        }
      },
    );
  }

  Widget _buildPlaceholder(Widget child) {
    return CustomScrollView(
      slivers: [SliverFillRemaining(child: child)],
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
