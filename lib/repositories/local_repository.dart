import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:post_board/common/common.dart';
import 'package:post_board/models/models.dart';

class LocalRepository {
  final SharedPreferences prefs;

  const LocalRepository(this.prefs);

  void saveProfile(Profile value) {
    return saveObject<Profile>(kProfileLocalKey, value);
  }

  Profile loadProfile() {
    return loadObject<Profile>(kProfileLocalKey, Profile.fromJson, Profile.empty());
  }

  void saveCities(List<City> value) {
    saveObjects<City>(kCitiesLocalKey, value);
  }

  List<City> loadCities() {
    return loadObjects<City>(kCitiesLocalKey, City.fromJson, []);
  }

  void saveFilters(Filters value) {
    saveObject<Filters>(kFiltersLocalKey, value);
  }

  Filters loadFilters() {
    return loadObject<Filters>(kFiltersLocalKey, Filters.fromJson, Filters.empty());
  }

  void saveSettings(Settings value) {
    return saveObject<Settings>(kSettingsLocalKey, value);
  }

  Settings loadSettings() {
    return loadObject<Settings>(kSettingsLocalKey, Settings.fromJson, Settings.empty());
  }

  void saveObject<T>(String key, T value) {
    prefs.setString(key, jsonEncode(value));
  }

  void saveObjects<T>(String key, List<T> value) {
    prefs.setStringList(key, value.map((e) => jsonEncode(e)).toList());
  }

  T loadObject<T>(String key, T Function(Map<String, dynamic>) fromJson, T defaultValue) {
    final data = prefs.getString(key);
    if (data != null) {
      return fromJson(jsonDecode(data));
    } else {
      return defaultValue;
    }
  }

  List<T> loadObjects<T>(
      String key, T Function(Map<String, dynamic>) fromJson, List<T> defaultValue) {
    final data = prefs.getStringList(key);
    if (data != null) {
      return data.map<T>((e) => fromJson(jsonDecode(e))).toList();
    } else {
      return defaultValue;
    }
  }
}
