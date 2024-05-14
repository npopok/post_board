import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';

import 'package:post_board/common/common.dart';

import 'template_screen.dart';

@RoutePage()
class SelectCityScreen extends TemplateScreen {
  const SelectCityScreen({super.key});

  @override
  ScreenInfo get screenInfo => const ScreenInfo(
        title: 'City!',
        content: Text('CITY text goes here...'),
        nextScreen: SelectFiltersRoute(),
        isFinal: false,
      );
}
