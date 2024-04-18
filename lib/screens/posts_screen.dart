import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:post_board/providers/posts_state.dart';

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
      body: switch (posts) {
        AsyncData(:final value) => ListView.builder(
            itemCount: value.length,
            itemBuilder: (context, index) => ListTile(
              title: Text('${value[index].author.name}, ${value[index].author.age}'),
              subtitle: Text(value[index].message),
              trailing: Text(value[index].timestamp.toString()),
            ),
          ),
        AsyncError(:final error) => Center(
            child: Text('PostsScreen.Error'.tr(args: [error.toString()])),
          ),
        _ => const CircularProgressIndicator(),
      },
    );
  }
}
