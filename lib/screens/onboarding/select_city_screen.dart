import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:post_board/common/common.dart';
import 'package:post_board/dialogs/dialogs.dart';
import 'package:post_board/providers/providers.dart';

import 'template_screen.dart';

@RoutePage()
class SelectCityScreen extends TemplateScreen {
  const SelectCityScreen({super.key});

  @override
  ScreenInfo get screenInfo => const ScreenInfo(
        title: 'Где вы ищете?',
        progress: (step: 3, count: 4),
        nextScreen: FinishRoute(),
      );

  @override
  Widget buildContent(BuildContext context, WidgetRef ref) {
    return LocationDialog(
      initialValue: ref.watch(profileStateProvider).city,
      contentPadding: EdgeInsets.zero,
      saveButton: false,
      onSelected: (value) => ref.read(filtersStateProvider.notifier).city = value,
    );
  }
}
