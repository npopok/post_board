import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:post_board/common/common.dart';
import 'package:post_board/providers/profile_state.dart';

import 'template_screen.dart';

@RoutePage()
class SelectAgeScreen extends TemplateScreen {
  const SelectAgeScreen({super.key});

  @override
  ScreenInfo get screenInfo => const ScreenInfo(
        title: 'Сколько вам лет?',
        progress: (step: 4, count: 7),
        nextScreen: SelectCityRoute(),
      );

  @override
  Widget buildContent(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(profileStateProvider);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          profile.age.toString(),
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        Slider(
          min: FieldSettings.ageMinValue.toDouble(),
          max: FieldSettings.ageMaxValue.toDouble(),
          divisions: FieldSettings.ageMaxValue - FieldSettings.ageMinValue,
          value: profile.age.toDouble(),
          label: profile.age.toString(),
          onChanged: (value) => ref.read(profileStateProvider.notifier).age = value.round(),
        ),
      ],
    );
  }
}
