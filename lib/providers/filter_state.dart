import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:post_board/models/models.dart';
import 'package:post_board/repositories/repositories.dart';
import 'package:post_board/common/resources.dart';

part 'filter_state.g.dart';

@riverpod
class FilterState extends _$FilterState {
  @override
  Filters build() => loadData();

  void saveData() => getIt<LocalRepository>().saveFilters(state);
  Filters loadData() => getIt<LocalRepository>().loadFilters();

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
