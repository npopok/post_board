import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:post_board/providers/posts_state.dart';
import 'package:post_board/widgets/post_details.dart';

@RoutePage()
class PostsScreen extends ConsumerWidget {
  const PostsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posts = ref.watch(postsStateProvider);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('PostsScreen.Title'.tr()),
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(postsStateProvider.future),
        child: posts.when(
          data: (items) => ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) => PostDetails(post: items[index]),
          ),
          error: (e, st) => Center(child: Text('PostsScreen.Error'.tr())),
          loading: () => const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}
