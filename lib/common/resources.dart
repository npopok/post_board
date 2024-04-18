import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:post_board/common/common.dart';
import 'package:post_board/repositories/repositories.dart';
import 'package:post_board/helpers/helpers.dart';

final getIt = GetIt.I;

class Resources {
  static void initialize() {
    getIt.registerSingletonAsync<SharedPreferences>(
      () => SharedPreferences.getInstance(),
    );
    getIt.registerSingletonWithDependencies<LocalRepository>(
      () => LocalRepository(getIt.get<SharedPreferences>()),
      dependsOn: [SharedPreferences],
    );
    getIt.registerSingleton<MessengerHelper>(MessengerHelper());
    getIt.registerSingleton<CloudRepository>(const CloudRepository());
    getIt.registerSingleton<Themes>(const Themes());
    getIt.allReady();
  }
}
