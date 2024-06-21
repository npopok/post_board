import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:post_board/common/common.dart';
import 'package:post_board/models/models.dart';

class LocalRepository {
  final SharedPreferences prefs;

  const LocalRepository({required this.prefs});

  void saveProfile(Profile value) {
    saveObject<Profile>(RepositorySettings.profileLocalKey, value);
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
    saveObject<Settings>(RepositorySettings.settingsLocalKey, value);
  }

  Settings loadSettings() {
    return loadObject<Settings>(
      RepositorySettings.settingsLocalKey,
      Settings.fromJson,
      Settings.empty(),
    );
  }

  void saveSetup(bool value) {
    prefs.setString(RepositorySettings.setupLocalKey, value.toString());
  }

  bool? loadSetup() {
    final oldData = prefs.getString('onboarding'); // TODO: Remove this after migration to 0.2.0
    if (oldData != null) {
      prefs.remove('onboarding');
      return bool.tryParse(oldData);
    }

    final data = prefs.getString(RepositorySettings.setupLocalKey);
    return data != null ? bool.tryParse(data) : null;
  }

  void saveObject<T>(String key, T value) {
    prefs.setString(key, jsonEncode(value));
  }

  void saveObjects<T>(String key, List<T> value) {
    prefs.setStringList(key, value.map((e) => jsonEncode(e)).toList());
  }

  T loadObject<T>(String key, T Function(Map<String, dynamic>) fromJson, T defaultValue) {
    final data = prefs.getString(key);
    try {
      return fromJson(jsonDecode(data!));
    } catch (_) {
      return defaultValue;
    }
  }

  List<T> loadObjects<T>(
      String key, T Function(Map<String, dynamic>) fromJson, List<T> defaultValue) {
    final data = prefs.getStringList(key);
    try {
      return data!.map<T>((e) => fromJson(jsonDecode(e))).toList();
    } catch (_) {
      return defaultValue;
    }
  }
}
