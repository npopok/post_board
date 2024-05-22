import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:post_board/common/common.dart';
import 'package:post_board/widgets/widgets.dart';
import 'package:post_board/providers/providers.dart';
import 'package:post_board/helpers/helpers.dart';

@RoutePage()
class PostsScreen extends ConsumerStatefulWidget {
  const PostsScreen({super.key});

  @override
  ConsumerState<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends ConsumerState<PostsScreen> {
  late AppLifecycleListener listener;
  late Timer timer;
  late bool needsRefresh;

  @override
  void initState() {
    super.initState();
    listener = AppLifecycleListener(onStateChange: _appStateHandler);
  }

  @override
  void dispose() {
    listener.dispose();
    super.dispose();
  }

  void _appStateHandler(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      needsRefresh = false;
      timer = Timer(RepositorySettings.postsCacheDuration, () => needsRefresh = true);
    } else if (state == AppLifecycleState.resumed) {
      timer.cancel();
      if (needsRefresh) ref.invalidate(postsStateProvider);
    }
  }

  @override
  Widget build(BuildContext context) {
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
      body: _buildPostsList(context),
    );
  }

  Widget _buildPostsList(BuildContext context) {
    final filters = ref.watch(filtersStateProvider);
    final posts = ref.watch(postsStateProvider(filters));

    return RefreshIndicator(
      onRefresh: () {
        logEvent(AnalyticsEvent.postsRefresh);
        return ref.refresh(postsStateProvider(filters).future);
      },
      child: posts.when(
        data: (posts) => PostsListView(posts: posts),
        error: (_, __) => const Center(child: PostsPlaceholder(showError: true)),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
