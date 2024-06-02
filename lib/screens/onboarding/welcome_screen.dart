import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:post_board/common/common.dart';
import 'package:post_board/helpers/helpers.dart';

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
    return Center(
      child: context.textCentered('WelcomeScreen.Text'.tr()),
    );
  }
}
