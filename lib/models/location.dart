import 'package:freezed_annotation/freezed_annotation.dart';

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

  factory Location.fromJson(Map<String, dynamic> json) => _$LocationFromJson(json);
  factory Location.empty() => const Location(latitude: 0, longitude: 0);
}
