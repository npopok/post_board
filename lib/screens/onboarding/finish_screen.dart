import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:post_board/common/common.dart';

import 'template_screen.dart';

@RoutePage()
class FinishScreen extends TemplateScreen {
  const FinishScreen({super.key});

  @override
  ScreenInfo get screenInfo => const ScreenInfo(
        title: 'Все готово',
        progress: (step: 7, count: 7),
        nextScreen: HomeRoute(),
      );

  @override
  Widget buildContent(BuildContext context, WidgetRef ref) {
    return const Text('FINISH text goes here...');
  }
}
