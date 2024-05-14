import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';

import 'package:post_board/common/common.dart';

import 'template_screen.dart';

@RoutePage()
class SelectNameScreen extends TemplateScreen {
  const SelectNameScreen({super.key});

  @override
  ScreenInfo get screenInfo => const ScreenInfo(
        title: 'Name!',
        content: Text('NAME text goes here...'),
        nextScreen: SelectGenderRoute(),
        isFinal: false,
      );
}
