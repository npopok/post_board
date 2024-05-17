import 'package:auto_route/auto_route.dart';

import 'package:post_board/repositories/repositories.dart';
import 'package:post_board/screens/screens.dart';

part 'routes.gr.dart';

class OnboardingRoute extends CustomRoute {
  OnboardingRoute({
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
      false => router.push(const SelectNameRoute()),
      true => resolver.next(true),
    };
  }
}

@AutoRouterConfig()
class Routes extends _$Routes {
  @override
  List<AutoRoute> get routes => [
        OnboardingRoute(page: WelcomeRoute.page),
        OnboardingRoute(page: SelectGenderRoute.page),
        OnboardingRoute(page: SelectNameRoute.page),
        OnboardingRoute(page: SelectAgeRoute.page),
        OnboardingRoute(page: SelectCityRoute.page),
        OnboardingRoute(page: SelectFiltersRoute.page),
        OnboardingRoute(page: FinishRoute.page),
        AutoRoute(
          page: HomeRoute.page,
          initial: true,
          children: [
            AutoRoute(page: PostsRoute.page),
            AutoRoute(page: SubmitRoute.page),
            AutoRoute(page: ProfileRoute.page),
          ],
          guards: [HomeRouteGuard()],
        ),
        AutoRoute(page: FiltersRoute.page),
        AutoRoute(page: SettingsRoute.page),
        AutoRoute(page: HelpRoute.page),
      ];
}
