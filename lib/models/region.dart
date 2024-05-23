import 'package:freezed_annotation/freezed_annotation.dart';

import 'country.dart';

part 'region.freezed.dart';
part 'region.g.dart';

@freezed
class Region with _$Region {
  const Region._();

  const factory Region({
    required final int id,
    required final String name,
    required final Country country,
  }) = _Region;

  @override
  String toString() => name;

  int compareTo(Region other) => name.compareTo(other.name);

  factory Region.fromJson(Map<String, dynamic> json) => _$RegionFromJson(json);

  factory Region.empty() => Region(
        id: 0,
        name: '',
        country: Country.empty(),
      );
}
