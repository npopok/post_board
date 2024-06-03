import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:post_board/common/common.dart';
import 'package:post_board/dialogs/dialogs.dart';
import 'package:post_board/models/models.dart';
import 'package:post_board/providers/providers.dart';

import 'template_screen.dart';

@RoutePage()
class SelectCityScreen extends TemplateScreen {
  const SelectCityScreen({super.key});

  @override
  ScreenInfo get screenInfo => ScreenInfo(
        title: 'SelectCityScreen.Title'.tr(),
        progress: (step: 3, count: 4),
        nextScreen: const FinishRoute(),
      );

  @override
  Widget buildContent(BuildContext context, WidgetRef ref) {
    return FormField<City>(
      builder: (FormFieldState<City> state) => LocationDialog(
        initialValue: ref.watch(profileStateProvider).city,
        successText: '',
        contentPadding: EdgeInsets.zero,
        onSelected: (value) => ref.read(filtersStateProvider.notifier).city = value,
      ),
      validator: (value) => value?.isNotEmpty == true ? null : '',
    );
  }
}
