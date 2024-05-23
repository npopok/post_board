import 'package:freezed_annotation/freezed_annotation.dart';

part 'country.freezed.dart';
part 'country.g.dart';

@freezed
class Country with _$Country {
  const Country._();

  const factory Country({
    required final int id,
    required final String name,
  }) = _Country;

  factory Country.fromJson(Map<String, dynamic> json) => _$CountryFromJson(json);

  factory Country.empty() => const Country(
        id: 0,
        name: '',
      );
}
