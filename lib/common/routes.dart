import 'package:auto_route/auto_route.dart';

import 'package:post_board/screens/screens.dart';

part 'routes.gr.dart';

@AutoRouterConfig()
class Routes extends _$Routes {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: HomeRoute.page,
          initial: true,
          children: [
            AutoRoute(page: PostsRoute.page),
            AutoRoute(page: SubmitRoute.page),
            AutoRoute(page: ProfileRoute.page),
          ],
        ),
        AutoRoute(page: FilterRoute.page),
        AutoRoute(page: SettingsRoute.page),
        AutoRoute(page: HelpRoute.page),
      ];
}
