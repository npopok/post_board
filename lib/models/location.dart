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

  @override
  toString() => '($latitude, $longitude)';

  bool get isEmpty => latitude == 0 && longitude == 0;
  bool get isNotEmpty => !isEmpty;

  double distanceFrom(Location location) {
    if (location.isEmpty || isEmpty) return 0;
    return Geolocator.distanceBetween(location.latitude, location.longitude, latitude, longitude);
  }

  factory Location.fromJson(Map<String, dynamic> json) => _$LocationFromJson(json);

  factory Location.empty() => const Location(latitude: 0, longitude: 0);

  factory Location.parse(String text) {
    try {
      final regex = RegExp(r'^\s*\(?\s*(-?\d+\.?\d*)\s*,\s*(-?\d+\.?\d*)\s*\)?\s*$');
      final match = regex.firstMatch(text);

      if (match != null) {
        final latitude = double.parse(match.group(1)!);
        final longitude = double.parse(match.group(2)!);
        return Location(latitude: latitude, longitude: longitude);
      }
    } on FormatException catch (_) {
      return Location.empty();
    }
    throw const FormatException();
  }
}
