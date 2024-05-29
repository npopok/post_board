import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InfiniteListView<T> extends StatefulWidget {
  static const scrollThreshold = 200;

  final AsyncValue<List<T>> Function() loadItems;
  final Future<void> Function() loadNext;
  final Future<void> Function() refresh;
  final Widget Function(BuildContext, T item) itemBuilder;
  final Widget loadingIndicator;
  final Widget loadMoreIndicator;
  final Widget emptyPlaceholder;
  final Widget errorPlaceholder;

  const InfiniteListView({
    required this.loadItems,
    required this.loadNext,
    required this.refresh,
    required this.itemBuilder,
    required this.loadingIndicator,
    required this.loadMoreIndicator,
    required this.emptyPlaceholder,
    required this.errorPlaceholder,
    super.key,
  });

  @override
  State<InfiniteListView<T>> createState() => _InfiniteListViewState<T>();
}

class _InfiniteListViewState<T> extends State<InfiniteListView<T>> {
  final scrollController = ScrollController();
  bool isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    scrollController.removeListener(_scrollListener);
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final items = widget.loadItems();

    return RefreshIndicator(
      onRefresh: widget.refresh,
      child: items.when(
        data: (data) =>
            data.isNotEmpty ? _buildListView(data) : _buildPlaceholder(widget.emptyPlaceholder),
        error: (_, __) => _buildPlaceholder(widget.errorPlaceholder),
        loading: () => widget.loadingIndicator,
      ),
    );
  }

  void _scrollListener() async {
    final maxPos = scrollController.position.maxScrollExtent;
    final currentPos = scrollController.position.pixels;
    bool showMore = maxPos - currentPos <= InfiniteListView.scrollThreshold;

    if (showMore && !isLoadingMore) {
      setState(() => isLoadingMore = true);
      await widget.loadNext();
      setState(() => isLoadingMore = false);
    }
  }

  Widget _buildListView(List<T> data) {
    return ListView.builder(
      controller: scrollController,
      itemCount: data.length + 1,
      itemBuilder: (_, index) {
        if (index < data.length) {
          return widget.itemBuilder(context, data[index]);
        } else {
          return widget.loadMoreIndicator;
        }
      },
    );
  }

  Widget _buildPlaceholder(Widget child) {
    return CustomScrollView(
      slivers: [SliverFillRemaining(child: child)],
    );
  }
}
