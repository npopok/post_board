import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';

import 'package:post_board/common/common.dart';

import 'template_screen.dart';

@RoutePage()
class SelectGenderScreen extends TemplateScreen {
  const SelectGenderScreen({super.key});

  @override
  ScreenInfo get screenInfo => const ScreenInfo(
        title: 'Gender!',
        content: Text('GENDER text goes here...'),
        nextScreen: SelectAgeRoute(),
        isFinal: false,
      );
}
