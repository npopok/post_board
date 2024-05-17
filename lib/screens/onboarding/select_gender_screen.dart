import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:post_board/common/common.dart';
import 'package:post_board/models/models.dart';
import 'package:post_board/providers/providers.dart';

import 'template_screen.dart';

@RoutePage()
class SelectGenderScreen extends TemplateScreen {
  const SelectGenderScreen({super.key});

  @override
  ScreenInfo get screenInfo => const ScreenInfo(
        title: 'Кто вы?',
        progress: (step: 3, count: 7),
        nextScreen: SelectAgeRoute(),
      );

  @override
  Widget buildContent(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: Gender.values
          .map(
            (e) => Padding(
              padding: const EdgeInsets.all(4),
              child: ChoiceChip(
                showCheckmark: false,
                label: Text(e.toString().tr()),
                selected: e == ref.watch(profileStateProvider).gender,
                onSelected: (value) => ref.read(profileStateProvider.notifier).gender = e,
              ),
            ),
          )
          .toList(),
    );
  }
}
