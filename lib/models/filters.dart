import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:post_board/common/common.dart';
import 'package:post_board/models/models.dart';

part 'filters.freezed.dart';
part 'filters.g.dart';

@freezed
class Filters with _$Filters {
  const Filters._();

  const factory Filters({
    required final City city,
    required final Category category,
    required final Gender gender,
    @NumericRangeConverter() required final NumericRange age,
  }) = _Filters;

  bool get isComplete => gender != Gender.unknown && city.isNotEmpty;

  factory Filters.fromJson(Map<String, dynamic> json) => _$FiltersFromJson(json);

  factory Filters.empty() => Filters(
        city: City.empty(),
        category: Category.sex,
        gender: Gender.unknown,
        age: (min: FieldConstraints.ageMinValue, max: FieldConstraints.ageMaxValue),
      );
}
