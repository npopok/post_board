import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:post_board/common/common.dart';
import 'package:post_board/helpers/helpers.dart';
import 'package:post_board/providers/providers.dart';
import 'package:post_board/widgets/widgets.dart';

@RoutePage()
class PostsScreen extends ConsumerStatefulWidget {
  const PostsScreen({super.key});

  @override
  ConsumerState<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends ConsumerState<PostsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('PostsScreen.Title'.tr()),
        actions: [
          IconButton(
            onPressed: () => context.navigateTo(const FiltersRoute()),
            icon: const Icon(Icons.filter_list),
          ),
        ],
      ),
      body: _buildPostList(),
    );
  }

  Widget _buildPostList() {
    final filters = ref.watch(filtersStateProvider);
    final posts = ref.watch(postsStateProvider(filters));

    return LayoutBuilder(
      builder: (context, constraints) => RefreshIndicator(
        onRefresh: () => ref.refresh(postsStateProvider(filters).future),
        child: posts.when(
          data: (posts) => PostsListView(posts: posts),
          error: (_, __) => Center(child: context.textError('PostsScreen.Error'.tr())),
          loading: () => const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}
