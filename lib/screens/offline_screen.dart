import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';

import 'package:post_board/widgets/widgets.dart';

@RoutePage()
class OfflineScreen extends StatelessWidget {
  const OfflineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(automaticallyImplyLeading: false),
        body: Center(
          child: ErrorPlaceholder(text: 'OfflineScreen.ErrorText'.tr()),
        ),
      ),
    );
  }
}
