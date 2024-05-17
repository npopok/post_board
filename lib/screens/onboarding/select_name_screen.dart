import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:post_board/common/common.dart';
import 'package:post_board/helpers/helpers.dart';
import 'package:post_board/providers/providers.dart';

import 'template_screen.dart';

@RoutePage()
class SelectNameScreen extends TemplateScreen {
  const SelectNameScreen({super.key});

  @override
  ScreenInfo get screenInfo => const ScreenInfo(
        title: 'Как вас зовут?',
        progress: (step: 2, count: 7),
        nextScreen: SelectGenderRoute(),
      );

  @override
  Widget buildContent(BuildContext context, WidgetRef ref) {
    return TextFormField(
      initialValue: ref.read(profileStateProvider).name,
      maxLength: FieldSettings.nameMaxLength,
      decoration: const InputDecoration(
        hintText: 'Ваше имя',
        counterText: '',
      ),
      validator: const TextLengthValidator(
        emptyMessage: 'Введите имя',
      ).validate,
      onSaved: (value) => ref.read(profileStateProvider.notifier).name = value!,
    );
  }
}
