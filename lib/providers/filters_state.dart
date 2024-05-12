import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:post_board/models/models.dart';
import 'package:post_board/repositories/repositories.dart';

part 'filters_state.g.dart';

@riverpod
class FiltersState extends _$FiltersState {
  @override
  Filters build() => loadData();

  void saveData() => localRepository.saveFilters(state);
  Filters loadData() => localRepository.loadFilters();

  set city(City value) {
    state = state.copyWith(city: value);
    saveData();
  }

  set category(Category value) {
    state = state.copyWith(category: value);
    saveData();
  }

  set gender(Gender value) {
    state = state.copyWith(gender: value);
    saveData();
  }

  set age(NumericRange value) {
    state = state.copyWith(age: value);
    saveData();
  }
}
