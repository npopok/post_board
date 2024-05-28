import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'package:post_board/common/common.dart';
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
  late PagingController<int, Post> pagingController;

  @override
  void initState() {
    super.initState();

    pagingController = PagingController(
      firstPageKey: RepositorySettings.postsMaxId,
    )..addPageRequestListener((pageKey) => _fetchPage(pageKey));
  }

  @override
  void dispose() {
    pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(filtersStateProvider);

    return PagedListView<int, Post>(
      pagingController: pagingController,
      builderDelegate: PagedChildBuilderDelegate<Post>(
        itemBuilder: (_, item, __) => PostListItem(post: item),
        noItemsFoundIndicatorBuilder: (_) => SpacePlaceholder(
          text: widget.emptyText,
          showError: false,
        ),
        firstPageErrorIndicatorBuilder: (_) => SpacePlaceholder(
          text: widget.errorText,
          showError: true,
        ),
        newPageErrorIndicatorBuilder: (_) => PostsListError(
          errorText: widget.errorItem,
        ),
      ),
    );
  }

  Future<void> _fetchPage(int pageKey) async {
    final filters = ref.watch(filtersStateProvider);

    ref.listenManual(
      postsStateProvider(filters, pageKey),
      (prev, next) => next.whenData(
        (items) {
          if (items.length < RepositorySettings.postsPageSize) {
            pagingController.appendLastPage(items);
          } else {
            pagingController.appendPage(items, items.last.id);
          }
        },
      ),
    );
  }
}
