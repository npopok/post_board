import 'package:auto_route/auto_route.dart';

import 'package:post_board/repositories/repositories.dart';
import 'package:post_board/screens/screens.dart';

part 'routes.gr.dart';

class SlideLeftRoute extends CustomRoute {
  SlideLeftRoute({
    required super.page,
    super.initial,
    super.transitionsBuilder = TransitionsBuilders.slideLeft,
  });
}

class HomeRouteGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    return switch (localRepository.loadOnboarding()) {
      null => router.push(const WelcomeRoute()),
      false => router.push(const SelectGenderRoute()),
      true => resolver.next(),
    };
  }
}

@AutoRouterConfig()
class Routes extends _$Routes {
  @override
  List<AutoRoute> get routes => [
        SlideLeftRoute(page: WelcomeRoute.page),
        SlideLeftRoute(page: SelectGenderRoute.page),
        SlideLeftRoute(page: SelectCityRoute.page),
        SlideLeftRoute(page: FinishRoute.page),
        AutoRoute(
          page: HomeRoute.page,
          initial: true,
          children: [
            AutoRoute(page: PostsRoute.page),
            AutoRoute(page: ProfileRoute.page),
          ],
          guards: [HomeRouteGuard()],
        ),
        AutoRoute(page: FiltersRoute.page),
        AutoRoute(page: SettingsRoute.page),
        AutoRoute(page: HelpRoute.page),
        AutoRoute(page: OfflineRoute.page),
      ];
}
