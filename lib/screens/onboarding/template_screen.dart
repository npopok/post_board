import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:auto_route/auto_route.dart';

import 'package:post_board/repositories/repositories.dart';

class ScreenInfo {
  final String title;
  final Widget content;
  final PageRouteInfo nextScreen;
  final bool isFinal;

  const ScreenInfo({
    required this.title,
    required this.content,
    required this.nextScreen,
    required this.isFinal,
  });
}

abstract class TemplateScreen extends StatelessWidget {
  const TemplateScreen({super.key});

  ScreenInfo get screenInfo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text(
            screenInfo.title,
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          Expanded(
            child: Center(child: screenInfo.content),
          ),
          FilledButton(
            onPressed: () {
              localRepository.saveOnboarding(screenInfo.nextScreen.routeName);
              screenInfo.isFinal
                  ? context.router.replaceAll([screenInfo.nextScreen])
                  : context.navigateTo(screenInfo.nextScreen);
            },
            child: Text(
              screenInfo.isFinal ? 'Button.Start'.tr() : 'Button.Next'.tr(),
            ),
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}
