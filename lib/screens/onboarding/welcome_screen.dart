import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';

import 'package:post_board/common/common.dart';

import 'template_screen.dart';

@RoutePage()
class WelcomeScreen extends TemplateScreen {
  const WelcomeScreen({super.key});

  @override
  ScreenInfo get screenInfo => const ScreenInfo(
        title: 'Welcome!',
        content: Text('Welcome text goes here...'),
        nextScreen: SelectNameRoute(),
        isFinal: false,
      );
}
