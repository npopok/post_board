import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:post_board/common/common.dart';
import 'package:post_board/helpers/helpers.dart';
import 'package:post_board/providers/providers.dart';

import 'firebase_options.dart';

void main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    await initializeFirebase();
    await initializeSupabase();
    await Depedencies.initialize();

    EasyLocalization.logger.enableBuildModes = [];
    await EasyLocalization.ensureInitialized();

    runApp(
      ProviderScope(
        child: EasyLocalization(
          supportedLocales: const [Locale('en'), Locale('ru')],
          path: 'assets/translations',
          startLocale: const Locale('ru'),
          fallbackLocale: const Locale('ru'),
          child: const MainApp(),
        ),
      ),
    );
  }, (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
  });
}

Future<void> initializeSupabase() async {
  await Supabase.initialize(
    url: RepositorySettings.supabaseUrl,
    anonKey: RepositorySettings.supabaseKey,
  );
}

Future<void> initializeFirebase() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(kReleaseMode);
  await FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(kReleaseMode);

  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
}

class MainApp extends ConsumerStatefulWidget {
  const MainApp({super.key});

  @override
  ConsumerState<MainApp> createState() => _MainAppState();
}

class _MainAppState extends ConsumerState<MainApp> {
  final themes = Themes();
  final routes = Routes();
  final connectivity = ConnectivityHelper();

  @override
  void initState() {
    super.initState();

    connectivity.subscribe(
      onConnect: () {
        print('onConnect: invalidate Posts');
        ref.invalidate(postsStateProvider);
        routes.popForced();
      },
      onDisconnect: () {
        if (routes.currentHierarchy().isEmpty) routes.push(const HomeRoute());
        routes.push(const OfflineRoute());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsStateProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      onGenerateTitle: (_) => 'App.Title'.tr(),
      themeMode: settings.themeMode,
      theme: themes.lightTheme,
      darkTheme: themes.darkTheme,
      scaffoldMessengerKey: getIt<MessengerHelper>().messengerKey,
      routerConfig: routes.config(
        navigatorObservers: () => [
          FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance),
        ],
      ),
    );
  }
}
