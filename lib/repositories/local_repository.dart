import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:post_board/common/common.dart';
import 'package:post_board/models/models.dart';

class LocalRepository {
  final SharedPreferences prefs;

  const LocalRepository(this.prefs);

  void saveProfile(Profile value) {
    return saveObject<Profile>(kProfileLocalKey, value.toJson());
  }

  Profile loadProfile() {
    return loadObject<Profile>(kProfileLocalKey, Profile.fromJson, Profile.empty());
  }

  void saveFilters(Filters value) {
    saveObject<Filters>(kFiltersLocalKey, value.toJson());
  }

  Filters loadFilters() {
    return loadObject<Filters>(kFiltersLocalKey, Filters.fromJson, Filters.empty());
  }

  void saveSettings(Settings value) {
    return saveObject<Settings>(kSettingsLocalKey, value.toJson());
  }

  Settings loadSettings() {
    return loadObject<Settings>(kSettingsLocalKey, Settings.fromJson, Settings.empty());
  }

  void saveObject<T>(String key, Object value) {
    prefs.setString(key, jsonEncode(value));
  }

  T loadObject<T>(String key, T Function(Map<String, dynamic>) fromJson, T defaultValue) {
    final data = prefs.getString(key);
    return data != null ? fromJson(jsonDecode(data)) : defaultValue;
  }
}
