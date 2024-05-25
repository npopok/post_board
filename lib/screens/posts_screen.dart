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
  late Stopwatch stopwatch;

  @override
  void initState() {
    super.initState();
    listener = AppLifecycleListener(onStateChange: _appStateHandler);
    stopwatch = Stopwatch();
  }

  @override
  void dispose() {
    listener.dispose();
    super.dispose();
  }

  void _appStateHandler(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      stopwatch.start();
    } else if (state == AppLifecycleState.resumed) {
      stopwatch.stop();
      if (stopwatch.elapsed > RepositorySettings.postsCacheDuration) {
        ref.invalidate(postsStateProvider);
        stopwatch.reset();
      }
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
        data: (posts) => PostsListView(
          posts: posts,
          emptyText: 'PostsScreen.EmptyText'.tr(),
        ),
        error: (_, __) => CustomScrollView(
          slivers: [
            SliverFillRemaining(
              child: SpacePlaceholder(
                text: 'PostsScreen.ErrorText'.tr(),
                showError: true,
              ),
            ),
          ],
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
