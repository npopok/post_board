import 'package:freezed_annotation/freezed_annotation.dart';

import 'city.dart';
import 'types.dart';

part 'profile.freezed.dart';
part 'profile.g.dart';

@freezed
class Profile with _$Profile {
  const factory Profile({
    required final String name,
    required final Gender gender,
    required final int age,
    required final City city,
  }) = _Profile;

  factory Profile.fromJson(Map<String, dynamic> json) => _$ProfileFromJson(json);

  factory Profile.empty() => Profile(
        name: '',
        gender: Gender.male,
        age: 18,
        city: City.empty(),
      );
}
