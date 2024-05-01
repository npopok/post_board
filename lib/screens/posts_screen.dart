import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:post_board/common/common.dart';
import 'package:post_board/helpers/helpers.dart';
import 'package:post_board/models/models.dart';
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
            onPressed: () => context.navigateTo(const FilterRoute()),
            icon: const Icon(Icons.filter_list),
          ),
        ],
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 8),
          _buildFilterBar(),
          const SizedBox(height: 8),
          Expanded(child: _buildPostList()),
        ],
      ),
    );
  }

  Widget _buildFilterBar() {
    final filter = ref.watch(filterStateProvider);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Wrap(
          spacing: 12,
          children: List.generate(
            Category.values.length,
            (index) => ChoiceChip(
              showCheckmark: false,
              label: Text(Category.values[index].toString().tr()),
              selected: filter.category == Category.values[index],
              onSelected: (_) => _updateCategory(Category.values[index]),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPostList() {
    final filter = ref.watch(filterStateProvider);
    final posts = ref.watch(postsStateProvider(filter));

    return LayoutBuilder(
      builder: (context, constraints) => RefreshIndicator(
        onRefresh: () => ref.refresh(postsStateProvider(filter).future),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: constraints.maxWidth,
              minHeight: constraints.maxHeight,
            ),
            child: posts.when(
              data: (posts) => _buildListView(posts),
              error: (_, __) => Center(child: Text('PostsScreen.Error'.tr())),
              loading: () => const Center(child: CircularProgressIndicator()),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildListView(List<Post> posts) {
    return posts.isNotEmpty
        ? ListView.builder(
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            itemCount: posts.length,
            itemBuilder: (context, index) => PostDetails(post: posts[index]),
          )
        : Center(child: Text('PostsScreen.Empty'.tr()));
  }

  void _updateCategory(Category value) {
    ref.read(filterStateProvider.notifier).category = value;
    AnalyticsHelper.logEvent(AnalyticsEvent.filterUpdate, {'filter_category': value});
  }
}
