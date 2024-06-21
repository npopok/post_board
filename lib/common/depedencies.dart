import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:post_board/repositories/repositories.dart';
import 'package:post_board/helpers/helpers.dart';

final getIt = GetIt.I;

final cachedRepository = getIt<CachedRepository>();
final remoteRepository = GetIt.I<RemoteRepository>();
final localRepository = GetIt.I<LocalRepository>();

final logEvent = getIt<AnalyticsHelper>().logEvent;
final showSnackBar = getIt<MessengerHelper>().showSnackBar;
final locationLister = getIt<LocationListener>();

class Depedencies {
  static Future<void> initialize() async {
    getIt.registerSingletonAsync<SharedPreferences>(
      () => SharedPreferences.getInstance(),
    );
    getIt.registerSingletonWithDependencies<LocalRepository>(
      () => LocalRepository(prefs: getIt.get<SharedPreferences>()),
      dependsOn: [SharedPreferences],
    );
    getIt.registerSingleton<RemoteRepository>(RemoteRepository());
    getIt.registerSingletonWithDependencies<CachedRepository>(
      () => CachedRepository(
        local: getIt.get<LocalRepository>(),
        remote: getIt.get<RemoteRepository>(),
      ),
      dependsOn: [LocalRepository],
    );
    getIt.registerSingleton<AnalyticsHelper>(AnalyticsHelper());
    getIt.registerSingleton<MessengerHelper>(MessengerHelper());
    getIt.registerSingleton<LocationListener>(LocationListener());

    return getIt.allReady();
  }
}
