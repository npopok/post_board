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

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  EasyLocalization.logger.enableBuildModes = [];
  await EasyLocalization.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(kReleaseMode);
  await FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(kReleaseMode);

  await Supabase.initialize(
    url: 'https://zqbppqfqagxfoqlclkxg.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXB'
        'hYmFzZSIsInJlZiI6InpxYnBwcWZxYWd4Zm9xbGNsa3hnIiwicm9'
        'sZSI6ImFub24iLCJpYXQiOjE3MTQyMjUwOTIsImV4cCI6MjAyOTg'
        'wMTA5Mn0.H7Oyi29HRKAGClZmLQYE9o8dKUwXRjwr3bbgrH4s3Yg',
  );
  await Supabase.instance.client.auth.signInAnonymously();

  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  Resources.initialize();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ru')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final routes = Routes();

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: Consumer(
        builder: (context, ref, _) => _buildApp(context, ref),
      ),
    );
  }

  Widget _buildApp(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      onGenerateTitle: (_) => 'App.Title'.tr(),
      //themeMode: settings.themeMode,
      themeMode: ThemeMode.dark,
      theme: getIt<Themes>().lightTheme,
      darkTheme: getIt<Themes>().darkTheme,
      scaffoldMessengerKey: getIt<MessengerHelper>().messengerKey,
      routerConfig: routes.config(
        navigatorObservers: () => [
          FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance),
        ],
      ),
    );
  }
}
