import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:post_board/models/models.dart';
import 'package:post_board/common/common.dart';

part 'settings_state.g.dart';

@riverpod
class SettingsState extends _$SettingsState {
  @override
  Settings build() => loadData();

  void saveData() => localRepository.saveSettings(state);
  Settings loadData() => localRepository.loadSettings();

  set themeMode(ThemeMode value) {
    state = state.copyWith(themeMode: value);
    saveData();
  }
}
