import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

final logEvent = GetIt.I<AnalyticsHelper>().logEvent;

enum AnalyticsEvent {
  onboardingComplete,
  postsRefresh,
  postsSubmit,
  profileUpdate,
  filtersUpdate,
  settingsUpdate,
}

enum AnalyticsParameter {
  profileName,
  profileGender,
  profileAge,
  profileCity,
  filtersCategory,
  filtersGender,
  filtersAge,
  settingsThemeMode,
}

class AnalyticsHelper {
  void logEvent(AnalyticsEvent event, [Map<AnalyticsParameter, Object?> data = const {}]) {
    data.forEach((key, value) {
      if (value is DateTime) {
        DateTime date = value;
        data.update(key, (value) => DateFormat('yyyy-MM-dd').format(date));
      }
      if (value is TimeOfDay) {
        TimeOfDay time = value;
        data.update(key, (value) => '${time.hour}:${time.minute}');
      }
      if (value is Color) {
        data.update(key, (value) => value.toString().toUpperCase());
      }
      if (value is Enum) {
        data.update(key, (value) => (value as Enum).name);
      }
      if (value == null) {
        data.update(key, (value) => 'null');
      }
    });

    final name = _camelToSnake(event.toString());
    final params = data.map((key, value) => MapEntry(_camelToSnake(key.toString()), value));

    FirebaseAnalytics.instance.logEvent(name: name, parameters: params);
    debugPrint('logEvent: event=$name parameters=$params');
  }

  String _camelToSnake(String str) {
    final regex = RegExp(r'(?<=[a-z])(?=[A-Z])');
    return str.split(regex).join('_').toLowerCase();
  }
}
