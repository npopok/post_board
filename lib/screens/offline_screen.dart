import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';

import 'package:post_board/widgets/widgets.dart';

@RoutePage()
class OfflineScreen extends StatelessWidget {
  const OfflineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpacePlaceholder(
          text: 'OfflineScreen.ErrorText'.tr(),
          showError: true,
        ),
      ),
    );
  }
}
