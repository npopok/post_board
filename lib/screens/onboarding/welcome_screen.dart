import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:post_board/common/common.dart';

import 'template_screen.dart';

@RoutePage()
class WelcomeScreen extends TemplateScreen {
  const WelcomeScreen({super.key});

  @override
  ScreenInfo get screenInfo => const ScreenInfo(
        title: 'Добро пожаловать!',
        progress: (step: 1, count: 4),
        nextScreen: SelectGenderRoute(),
      );

  @override
  Widget buildContent(BuildContext context, WidgetRef ref) {
    return const Text('Принять соглашение, что вам больше 18 лет.');
  }
}
