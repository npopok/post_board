import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geolocator/geolocator.dart';

part 'location.freezed.dart';
part 'location.g.dart';

@freezed
class Location with _$Location {
  const Location._();

  const factory Location({
    required final double latitude,
    required final double longitude,
  }) = _Location;

  bool get isEmpty => latitude == 0 && longitude == 0;
  bool get isNotEmpty => !isEmpty;

  double distanceFrom(Location location) {
    if (isNotEmpty && location.isNotEmpty) {
      return Geolocator.distanceBetween(location.latitude, location.longitude, latitude, longitude);
    } else {
      return 0;
    }
  }

  factory Location.fromJson(Map<String, dynamic> json) => _$LocationFromJson(json);

  factory Location.empty() => const Location(
        latitude: 0,
        longitude: 0,
      );

  factory Location.parse(dynamic latitude, dynamic longitude) => Location(
        latitude: _checkDouble(latitude),
        longitude: _checkDouble(longitude),
      );

  static double _checkDouble(dynamic value) {
    if (value is int) {
      return value.toDouble();
    } else if (value is double?) {
      return value ?? 0;
    } else {
      throw UnimplementedError();
    }
  }
}
