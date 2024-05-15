import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:post_board/providers/providers.dart';
import 'package:post_board/helpers/helpers.dart';
import 'package:post_board/widgets/widgets.dart';

class PostsListView extends ConsumerWidget {
  const PostsListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filters = ref.watch(filtersStateProvider);
    final posts = ref.watch(postsStateProvider(filters));

    return RefreshIndicator(
      onRefresh: () => ref.refresh(postsStateProvider(filters).future),
      child: posts.when(
        data: (posts) => CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(child: CategoryFilter()),
            posts.isNotEmpty
                ? SliverList.builder(
                    itemCount: posts.length,
                    itemBuilder: (context, index) => PostListItem(post: posts[index]),
                  )
                : const SliverFillRemaining(child: PostsPlaceholder()),
          ],
        ),
        error: (_, __) => Center(child: context.textError('PostsScreen.Error'.tr())),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
