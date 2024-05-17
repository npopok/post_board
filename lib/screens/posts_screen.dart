import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:post_board/common/common.dart';
import 'package:post_board/widgets/widgets.dart';
import 'package:post_board/providers/providers.dart';
import 'package:post_board/helpers/helpers.dart';

@RoutePage()
class PostsScreen extends ConsumerWidget {
  const PostsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('PostsScreen.Title'.tr()),
        bottom: const CategoryFilter(),
        actions: [
          IconButton(
            onPressed: () => context.navigateTo(const FiltersRoute()),
            icon: const Icon(Icons.filter_list),
          ),
        ],
      ),
      body: _buildPostsList(context, ref),
    );
  }

  Widget _buildPostsList(BuildContext context, WidgetRef ref) {
    final filters = ref.watch(filtersStateProvider);
    final posts = ref.watch(postsStateProvider(filters));

    return RefreshIndicator(
      onRefresh: () {
        logEvent(AnalyticsEvent.postsRefresh);
        return ref.refresh(postsStateProvider(filters).future);
      },
      child: posts.when(
        data: (posts) => PostsListView(posts: posts),
        error: (_, __) => Center(child: context.textError('PostsScreen.Error'.tr())),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
