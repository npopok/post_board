import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:post_board/common/common.dart';

import 'template_screen.dart';

@RoutePage()
class WelcomeScreen extends TemplateScreen {
  const WelcomeScreen({super.key});

  @override
  ScreenInfo get screenInfo => ScreenInfo(
        title: 'WelcomeScreen.Title'.tr(),
        progress: (step: 1, count: 4),
        nextScreen: const SelectGenderRoute(),
      );

  @override
  Widget buildContent(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox.square(dimension: 0),
        Align(
          alignment: Alignment.center,
          child: Text(
            'WelcomeScreen.Intro'.tr(),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Text(
            'WelcomeScreen.Agreement'.tr(),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }
}
