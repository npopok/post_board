import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:post_board/common/common.dart';
import 'package:post_board/helpers/helpers.dart';
import 'package:post_board/models/models.dart';
import 'package:post_board/providers/providers.dart';

@RoutePage()
class SubmitScreen extends ConsumerStatefulWidget {
  const SubmitScreen({super.key});

  @override
  ConsumerState<SubmitScreen> createState() => _SubmitScreenState();
}

class _SubmitScreenState extends ConsumerState<SubmitScreen> {
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
        title: Text('SubmitScreen.Title'.tr()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            TextField(
              controller: textController,
              maxLines: 3,
              maxLength: kMaxPostLength,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () => context.pushRoute(ResultRoute(message: textController.text)),
              child: Text('SubmitScreen.Submit'.tr()),
            ),
          ],
        ),
      ),
    );
  }

  void _submitPostHandler(Profile profile) {
    context.maybePop();
    final posts = ref.read(postsStateProvider.notifier);
    posts
        .addPost(profile, textController.text)
        .then((value) => showSnackBar('SubmitScreen.Success'.tr()))
        .onError((_, __) => showSnackBar('SubmitScreen.Error'.tr()));
  }
}
