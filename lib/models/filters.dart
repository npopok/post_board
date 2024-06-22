import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:post_board/common/common.dart';
import 'package:post_board/models/models.dart';

part 'filters.freezed.dart';
part 'filters.g.dart';

@freezed
class Filters with _$Filters {
  const Filters._();

  const factory Filters({
    required final Category category,
    required final Gender gender,
    @NumericRangeConverter() required final NumericRange age,
    required final City city,
    @Default(DefaultSettings.distance)
    final int? distance, // TODO: Make it not-nullable after full migration to 0.3.0
  }) = _Filters;

  bool get isComplete => gender != Gender.unknown && city.isNotEmpty;

  factory Filters.fromJson(Map<String, dynamic> json) => _$FiltersFromJson(json);

  factory Filters.empty() => Filters(
        category: DefaultSettings.category,
        gender: Gender.unknown,
        age: (min: FieldConstraints.ageMinValue, max: FieldConstraints.ageMaxValue),
        city: City.empty(),
        distance: DefaultSettings.distance,
      );
}
