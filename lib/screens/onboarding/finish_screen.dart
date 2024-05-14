import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';

import 'package:post_board/common/common.dart';

import 'template_screen.dart';

@RoutePage()
class FinishScreen extends TemplateScreen {
  const FinishScreen({super.key});

  @override
  ScreenInfo get screenInfo => const ScreenInfo(
        title: 'Finish!',
        content: Text('Finish text goes here...'),
        nextScreen: HomeRoute(),
        isFinal: true,
      );
}
