import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:post_board/common/common.dart';

import 'types.dart';

part 'filters.freezed.dart';
part 'filters.g.dart';

@freezed
class Filters with _$Filters {
  const factory Filters({
    required final Category category,
    required final Gender gender,
    required final NumericRange age,
  }) = _Filters;

  factory Filters.fromJson(Map<String, dynamic> json) => _$FiltersFromJson(json);

  factory Filters.empty() => const Filters(
        category: Category.sex,
        gender: Gender.male,
        age: (min: kAgeMinValue, max: kAgeMaxValue),
      );
}
