import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:post_board/common/common.dart';
import 'package:post_board/models/models.dart';

class LocalRepository {
  final SharedPreferences prefs;

  const LocalRepository(this.prefs);

  void saveFilter(Filter filter) {
    saveObject<Filter>(kFilterLocalKey, filter.toJson());
  }

  Filter loadFilter() {
    final data = loadObject<Filter>(kFilterLocalKey, Filter.fromJson);
    return data ?? Filter.empty();
  }

  void saveProfile(Profile profile) {
    saveObject<Profile>(kProfileLocalKey, profile.toJson());
  }

  Profile loadProfile() {
    final data = loadObject<Profile>(kProfileLocalKey, Profile.fromJson);
    return data ?? Profile.empty();
  }

  void saveObject<T>(String key, Object value) {
    prefs.setString(key, jsonEncode(value));
  }

  T? loadObject<T>(String key, T Function(Map<String, dynamic>) fromJson) {
    final data = prefs.getString(key);
    return data != null ? fromJson(jsonDecode(data)) : null;
  }
}
