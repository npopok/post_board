import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
  Category selectedCategory = Category.sex;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('PostsScreen.Title'.tr()),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 8),
          _buildFilterBar(),
          const SizedBox(height: 8),
          Expanded(child: _buildPostList(ref)),
        ],
      ),
    );
  }

  Widget _buildFilterBar() {
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
              selected: selectedCategory == Category.values[index],
              onSelected: (value) => setState(() => selectedCategory = Category.values[index]),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPostList(WidgetRef ref) {
    final posts = ref.watch(postsStateProvider(selectedCategory));
    return RefreshIndicator(
      onRefresh: () => ref.refresh(postsStateProvider(selectedCategory).future),
      child: posts.when(
        data: (items) => items.isNotEmpty
            ? ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) => PostDetails(post: items[index]),
              )
            : Center(child: Text('PostsScreen.Empty'.tr())),
        error: (_, __) => Center(child: Text('PostsScreen.Error'.tr())),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
