import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

final logEvent = GetIt.I<AnalyticsHelper>().logEvent;

enum AnalyticsEvent {
  setupComplete,
  postsLoad,
  postsAction,
  postsRefresh,
  postsSubmit,
  profileUpdate,
  filtersUpdate,
  settingsUpdate,
}

enum AnalyticsParameter {
  postAction,
  profileName,
  profileGender,
  profileAge,
  profileCity,
  profileContact,
  filtersCategory,
  filtersGender,
  filtersAge,
  filtersCity,
  settingsThemeMode,
}

class AnalyticsHelper {
  final analytics = FirebaseAnalytics.instance;

  Future<void> logEvent(
    AnalyticsEvent event, [
    Map<AnalyticsParameter, Object> data = const {},
  ]) async {
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
    });

    final name = _camelToSnake(event.name);
    final params = data.map((key, value) => MapEntry(_camelToSnake(key.name), value));

    try {
      await analytics.logEvent(name: name, parameters: params);
      debugPrint('logEvent: event=$name, parameters=$params');
    } catch (e) {
      debugPrint('logEvent: $e}');
    }
  }

  String _camelToSnake(String str) {
    final regex = RegExp(r'(?<=[a-z])(?=[A-Z])');
    return str.split(regex).join('_').toLowerCase();
  }
}
