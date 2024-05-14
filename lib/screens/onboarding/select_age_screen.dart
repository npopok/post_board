import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';

import 'package:post_board/common/common.dart';

import 'template_screen.dart';

@RoutePage()
class SelectAgeScreen extends TemplateScreen {
  const SelectAgeScreen({super.key});

  @override
  ScreenInfo get screenInfo => const ScreenInfo(
        title: 'Age!',
        content: Text('AGE goes here...'),
        nextScreen: SelectCityRoute(),
        isFinal: false,
      );
}
