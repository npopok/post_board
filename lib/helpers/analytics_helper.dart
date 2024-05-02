import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum AnalyticsEvent {
  //
  // Event Name | Parameters
  //
  profileUpdate, // profile_name | profile_gender | profile_age | profile_city
  filtersUpdate, // filters_category | filters_gender | filters_age
  settingsUpdate, // settings_theme_mode
}

class AnalyticsHelper {
  static Map<AnalyticsEvent, String> eventNames = {
    AnalyticsEvent.profileUpdate: 'profile_update',
    AnalyticsEvent.filtersUpdate: 'filters_update',
    AnalyticsEvent.settingsUpdate: 'settings_update',
  };

  static logEvent(AnalyticsEvent event, [Map<String, Object?> parameters = const {}]) {
    parameters.forEach((key, value) {
      if (value is DateTime) {
        DateTime date = value;
        parameters.update(key, (value) => DateFormat('yyyy-MM-dd').format(date));
      }
      if (value is TimeOfDay) {
        TimeOfDay time = value;
        parameters.update(key, (value) => '${time.hour}:${time.minute}');
      }
      if (value is Color) {
        parameters.update(key, (value) => value.toString().toUpperCase());
      }
      if (value is Enum) {
        parameters.update(key, (value) => (value as Enum).name);
      }
      if (value == null) {
        parameters.update(key, (value) => 'null');
      }
    });
    FirebaseAnalytics.instance.logEvent(
      name: eventNames[event]!,
      parameters: parameters,
    );
    debugPrint('logEvent: event=$event parameters=$parameters');
  }
}
