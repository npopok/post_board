import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:post_board/common/common.dart';

import 'types.dart';

part 'filter.freezed.dart';
part 'filter.g.dart';

@freezed
class Filter with _$Filter {
  const factory Filter({
    required final Category category,
    required final Gender gender,
    required final NumericRange age,
  }) = _Filter;

  factory Filter.fromJson(Map<String, dynamic> json) => _$FilterFromJson(json);

  factory Filter.empty() => const Filter(
        category: Category.sex,
        gender: Gender.male,
        age: (min: kAgeMinValue, max: kAgeMaxValue),
      );
}
