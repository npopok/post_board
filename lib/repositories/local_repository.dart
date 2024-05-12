import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:get_it/get_it.dart';

import 'package:post_board/common/common.dart';
import 'package:post_board/models/models.dart';

final localRepository = GetIt.I<LocalRepository>();

class LocalRepository {
  final SharedPreferences prefs;

  const LocalRepository({required this.prefs});

  void saveProfile(Profile value) {
    return saveObject<Profile>(RepositorySettings.profileLocalKey, value);
  }

  Profile loadProfile() {
    return loadObject<Profile>(
      RepositorySettings.profileLocalKey,
      Profile.fromJson,
      Profile.empty(),
    );
  }

  void saveCities(List<City> value) {
    saveObjects<City>(RepositorySettings.citiesLocalKey, value);
  }

  List<City> loadCities() {
    return loadObjects<City>(
      RepositorySettings.citiesLocalKey,
      City.fromJson,
      const [],
    );
  }

  void saveFilters(Filters value) {
    saveObject<Filters>(RepositorySettings.filtersLocalKey, value);
  }

  Filters loadFilters() {
    return loadObject<Filters>(
      RepositorySettings.filtersLocalKey,
      Filters.fromJson,
      Filters.empty(),
    );
  }

  void saveSettings(Settings value) {
    return saveObject<Settings>(RepositorySettings.settingsLocalKey, value);
  }

  Settings loadSettings() {
    return loadObject<Settings>(
      RepositorySettings.settingsLocalKey,
      Settings.fromJson,
      Settings.empty(),
    );
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
