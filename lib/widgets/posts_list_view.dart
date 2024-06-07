import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:post_board/helpers/helpers.dart';

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
  var scrollController = ScrollController();
  bool hasMore = true;
  bool isLoadingMore = false;
  bool isRefreshing = false;

  @override
  void initState() {
    super.initState();
    ref.listenManual(postsStateProvider, (_, state) => _resetScrollController(state));
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final posts = ref.watch(postsStateProvider);

    return RefreshIndicator(
      onRefresh: () {
        isRefreshing = true;
        logEvent(AnalyticsEvent.postsRefresh);
        return ref.refresh(postsStateProvider.future);
      },
      child: posts.when(
        skipLoadingOnRefresh: isRefreshing,
        data: (data) {
          isRefreshing = false;
          if (data.items.isNotEmpty) {
            return _buildListView(data);
          } else {
            return Center(child: EmptyPlaceholder(text: widget.emptyText));
          }
        },
        error: (_, __) {
          isRefreshing = false;
          return _buildErrorPlaceholder();
        },
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Widget _buildListView(Posts posts) {
    return NotificationListener<OverscrollNotification>(
      child: ListView.builder(
        controller: scrollController,
        physics: const ClampingScrollPhysics(),
        itemCount: posts.items.length + (posts.hasMore ? 1 : 0),
        itemBuilder: (_, index) {
          if (index < posts.items.length) {
            return PostListItem(post: posts.items[index]);
          } else {
            return _buildLoadMoreIndicator();
          }
        },
      ),
      onNotification: (notification) {
        if (notification.overscroll > 0) _loadMoreItems();
        return false;
      },
    );
  }

  Widget _buildErrorPlaceholder() {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          child: ErrorPlaceholder(text: widget.errorText),
        ),
      ],
    );
  }

  Widget _buildLoadMoreIndicator() {
    return const Padding(
      padding: EdgeInsets.only(top: 12, bottom: 24),
      child: Center(
          child: SizedBox.square(
        dimension: 24,
        child: CircularProgressIndicator(strokeWidth: 3),
      )),
    );
  }

  void _loadMoreItems() async {
    if (hasMore && !isLoadingMore) {
      isLoadingMore = true;

      await ref.read(postsStateProvider.notifier).loadNext();
      final posts = ref.read(postsStateProvider);

      hasMore = posts.value?.hasMore ?? false;
      isLoadingMore = false;
    }
  }

  void _resetScrollController(AsyncValue<Posts> state) {
    if (state.hasValue && state.requireValue.isFirst) {
      hasMore = true;
      if (scrollController.hasClients) {
        scrollController.jumpTo(0);
      }
    }
  }
}
