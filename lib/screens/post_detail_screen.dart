import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:post_board/common/common.dart';

@RoutePage()
class PostDetailScreen extends StatelessWidget {
  const PostDetailScreen({super.key});

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
            const TextField(
              autofocus: true,
              maxLines: 3,
              maxLength: kMaxPostLength,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _submitHandler,
              child: Text('PostDetailScreen.Submit'.tr()),
            ),
          ],
        ),
      ),
    );
  }

  void _submitHandler() {}
}
