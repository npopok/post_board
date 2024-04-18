import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:post_board/providers/providers.dart';

@RoutePage()
class ResultScreen extends ConsumerWidget {
  final String message;

  const ResultScreen(this.message, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.read(profileStateProvider);
    final posts = ref.read(postsStateProvider.notifier);

    return Scaffold(
      body: FutureBuilder(
        future: posts.addPost(profile, message),
        builder: (context, snapshot) {
          if (snapshot.hasData) return Text('Success');
          if (snapshot.hasError) return Text('Error');
          return Container();
        },
      ),
    );
  }
}
