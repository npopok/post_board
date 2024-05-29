import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:post_board/common/common.dart';
import 'package:post_board/widgets/widgets.dart';
import 'package:post_board/providers/providers.dart';

@RoutePage()
class PostsScreen extends ConsumerStatefulWidget {
  const PostsScreen({super.key});

  @override
  ConsumerState<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends ConsumerState<PostsScreen> {
  late AppLifecycleListener listener;
  final stopwatch = Stopwatch();

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
      body: PostsListView(
        emptyText: 'PostsScreen.EmptyText'.tr(),
        errorText: 'PostsScreen.ErrorText'.tr(),
        errorItem: 'PostsScreen.ErrorItem'.tr(),
      ),
    );
  }
}
