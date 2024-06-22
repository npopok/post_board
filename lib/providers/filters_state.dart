import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:post_board/models/models.dart';
import 'package:post_board/common/common.dart';

part 'filters_state.g.dart';

@riverpod
class FiltersState extends _$FiltersState {
  @override
  Filters build() => loadData();

  void saveData() => cachedRepository.saveFilters(state);
  Filters loadData() => localRepository.loadFilters();

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

  set city(City value) {
    state = state.copyWith(city: value);
    saveData();
  }

  set distance(int value) {
    state = state.copyWith(distance: value);
    saveData();
  }
}
