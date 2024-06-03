import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:post_board/common/common.dart';

import 'template_screen.dart';

@RoutePage()
class FinishScreen extends TemplateScreen {
  const FinishScreen({super.key});

  @override
  ScreenInfo get screenInfo => ScreenInfo(
        title: 'FinishScreen.Title'.tr(),
        progress: (step: 4, count: 4),
        nextScreen: const HomeRoute(),
      );

  @override
  Widget buildContent(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          'FinishScreen.Congrats'.tr(),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        Text(
          'FinishScreen.Advices'.tr(),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        Text(
          'FinishScreen.Wishes'.tr(),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }
}
