import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:post_board/helpers/helpers.dart';
import 'package:post_board/common/common.dart';

class ScreenInfo {
  final String title;
  final ({int step, int count}) progress;
  final PageRouteInfo nextScreen;

  bool get isFinal => progress.step == progress.count;
  bool get isComplete => progress.step >= progress.count - 1;

  const ScreenInfo({
    required this.title,
    required this.progress,
    required this.nextScreen,
  });
}

abstract class TemplateScreen extends ConsumerStatefulWidget {
  const TemplateScreen({super.key});

  ScreenInfo get screenInfo;
  Widget buildContent(BuildContext context, WidgetRef ref);

  @override
  ConsumerState<TemplateScreen> createState() => _TemplateScreenState();
}

class _TemplateScreenState extends ConsumerState<TemplateScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text(
            widget.screenInfo.title,
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Center(
                child: Form(
                  key: formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: widget.buildContent(context, ref),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          FilledButton(
            onPressed: () => showNextScreen(context),
            child: Text(
              widget.screenInfo.isFinal ? 'Button.Start'.tr() : 'Button.Next'.tr(),
            ),
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  void showNextScreen(BuildContext context) {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      localRepository.saveSetup(widget.screenInfo.isComplete);

      if (widget.screenInfo.isFinal) {
        context.router.replaceAll([widget.screenInfo.nextScreen]);
        logEvent(AnalyticsEvent.setupComplete);
      } else {
        context.navigateTo(widget.screenInfo.nextScreen);
      }
    }
  }
}
