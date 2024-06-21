import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:post_board/models/models.dart';
import 'package:post_board/common/common.dart';

part 'profile_state.g.dart';

@riverpod
class ProfileState extends _$ProfileState {
  @override
  Profile build() => loadData();

  void saveData() => cachedRepository.saveProfile(state);
  Profile loadData() => localRepository.loadProfile();

  set name(String value) {
    state = state.copyWith(name: value);
    saveData();
  }

  set gender(Gender value) {
    state = state.copyWith(gender: value);
    saveData();
  }

  set age(int value) {
    state = state.copyWith(age: value);
    saveData();
  }

  set city(City value) {
    state = state.copyWith(city: value);
    saveData();
  }

  set contact(Contact value) {
    state = state.copyWith(contact: value);
    saveData();
  }
}
