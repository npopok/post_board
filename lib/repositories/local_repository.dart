import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class LocalRepository {
  final SharedPreferences prefs;

  const LocalRepository(this.prefs);

  void saveObject<T>(String key, Object value) {
    prefs.setString(key, jsonEncode(value));
  }

  T? loadObject<T>(String key, T Function(Map<String, dynamic>) fromJson) {
    final data = prefs.getString(key);
    return data != null ? fromJson(jsonDecode(data)) : null;
  }
}
