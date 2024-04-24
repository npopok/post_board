import 'package:post_board/common/routes.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:post_board/common/common.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      key: UniqueKey(),
      routes: const [
        PostsRoute(),
        SubmitRoute(),
        ProfileRoute(),
      ],
      bottomNavigationBuilder: (_, tabsRouter) => BottomNavigationBar(
        currentIndex: tabsRouter.activeIndex,
        onTap: tabsRouter.setActiveIndex,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.search),
            label: 'HomeScreen.Search'.tr(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.add_circle_outline),
            label: 'HomeScreen.Create'.tr(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person),
            label: 'HomeScreen.Profile'.tr(),
          ),
        ],
      ),
    );
  }
}
