import 'package:freezed_annotation/freezed_annotation.dart';

part 'city.freezed.dart';
part 'city.g.dart';

@freezed
class City with _$City {
  const factory City({
    required final int id,
    required final String name,
    required final double latitude,
    required final double longitude,
  }) = _City;

  factory City.fromJson(Map<String, dynamic> json) => _$CityFromJson(json);

  factory City.empty() => const City(
        id: 0,
        name: '',
        latitude: 0,
        longitude: 0,
      );
}
