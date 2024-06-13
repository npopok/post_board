import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:post_board/common/common.dart';
import 'package:post_board/helpers/helpers.dart';
import 'package:post_board/models/models.dart';
import 'package:post_board/providers/providers.dart';
import 'package:post_board/widgets/widgets.dart';

import 'template_screen.dart';

@RoutePage()
class SelectGenderScreen extends TemplateScreen {
  const SelectGenderScreen({super.key});

  @override
  ScreenInfo get screenInfo => ScreenInfo(
        title: 'SelectGenderScreen.Title'.tr(),
        progress: (step: 2, count: 4),
        nextScreen: const SelectCityRoute(),
      );

  @override
  Widget buildContent(BuildContext context, WidgetRef ref) {
    return ChoiceField<Gender>(
      direction: Axis.vertical,
      values: Gender.values.exclude(Gender.unknown),
      textBuilder: (value) => value.toString().tr(),
      initialValue: ref.read(filtersStateProvider).gender,
      validator: (value) => value == Gender.unknown ? '' : null,
      onSaved: (value) => ref.read(filtersStateProvider.notifier).gender = value!,
    );
  }
}
