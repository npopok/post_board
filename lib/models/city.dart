import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geolocator/geolocator.dart';

part 'city.freezed.dart';
part 'city.g.dart';

@freezed
class City with _$City {
  const City._();

  const factory City({
    required final int id,
    required final String name,
    required final String region,
    required final double latitude,
    required final double longitude,
  }) = _City;

  @override
  String toString() => isEmpty ? '' : '$name, $region';

  int compareTo(City other) =>
      name == other.name ? region.compareTo(other.region) : name.compareTo(other.name);

  bool get isEmpty => id == 0;
  bool get isNotEmpty => !isEmpty;

  double distanceFrom(double latitude, double longitude) {
    return Geolocator.distanceBetween(latitude, longitude, this.latitude, this.longitude);
  }

  factory City.fromJson(Map<String, dynamic> json) => _$CityFromJson(json);

  factory City.empty() => const City(
        id: 0,
        name: '',
        region: '',
        latitude: 0,
        longitude: 0,
      );
}
