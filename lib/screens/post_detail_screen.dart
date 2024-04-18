import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:post_board/common/common.dart';
import 'package:post_board/helpers/helpers.dart';
import 'package:post_board/models/models.dart';
import 'package:post_board/providers/profile_state.dart';
import 'package:post_board/repositories/repositories.dart';

@RoutePage()
class PostDetailScreen extends ConsumerStatefulWidget {
  const PostDetailScreen({super.key});

  @override
  ConsumerState<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends ConsumerState<PostDetailScreen> {
  late TextEditingController textController;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('PostDetailScreen.Title'.tr()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: textController,
              autofocus: true,
              maxLines: 3,
              maxLength: kMaxPostLength,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () => _submitPostHandler(ref.read(profileStateProvider)),
              child: Text('PostDetailScreen.Submit'.tr()),
            ),
          ],
        ),
      ),
    );
  }

  void _submitPostHandler(Profile profile) {
    final post = Post(
      author: Author(name: profile.name, age: profile.age),
      message: textController.text,
      createdAt: DateTime.now(), // TODO: Use Firebase server time
    );

    context.maybePop();
    getIt<CloudRepository>()
        .saveObject("posts", post.toJson())
        .then((value) => getIt<MessengerHelper>().showSnackBar('PostDetailScreen.Success'.tr()))
        .onError((_, __) => getIt<MessengerHelper>().showSnackBar('PostDetailScreen.Error'.tr()));
  }
}
