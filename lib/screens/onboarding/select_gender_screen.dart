import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:post_board/common/common.dart';
import 'package:post_board/helpers/helpers.dart';
import 'package:post_board/models/models.dart';
import 'package:post_board/providers/providers.dart';

import 'template_screen.dart';

@RoutePage()
class SelectGenderScreen extends TemplateScreen {
  const SelectGenderScreen({super.key});

  @override
  ScreenInfo get screenInfo => const ScreenInfo(
        title: 'Кого вы ищете?',
        progress: (step: 2, count: 4),
        nextScreen: SelectCityRoute(),
      );

  @override
  Widget buildContent(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: Gender.values
          .exclude(Gender.unknown)
          .map(
            (e) => Padding(
              padding: const EdgeInsets.all(4),
              child: ChoiceChip(
                showCheckmark: false,
                label: Text(e.toString().tr()),
                selected: e == ref.watch(filtersStateProvider).gender,
                onSelected: (value) => ref.read(filtersStateProvider.notifier).gender = e,
              ),
            ),
          )
          .toList(),
    );
  }
}
