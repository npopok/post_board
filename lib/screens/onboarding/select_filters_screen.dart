import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';

import 'package:post_board/common/common.dart';

import 'template_screen.dart';

@RoutePage()
class SelectFiltersScreen extends TemplateScreen {
  const SelectFiltersScreen({super.key});

  @override
  ScreenInfo get screenInfo => const ScreenInfo(
        title: 'Filters!',
        content: Text('Filters text goes here...'),
        nextScreen: FinishRoute(),
        isFinal: false,
      );
}
