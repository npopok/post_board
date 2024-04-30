import 'package:freezed_annotation/freezed_annotation.dart';

import 'types.dart';

part 'profile.freezed.dart';
part 'profile.g.dart';

@freezed
class Profile with _$Profile {
  const factory Profile({
    required final String name,
    required final Gender gender,
    required final int age,
    required final String city,
  }) = _Profile;

  factory Profile.fromJson(Map<String, dynamic> json) => _$ProfileFromJson(json);

  factory Profile.empty() => const Profile(
        name: '',
        gender: Gender.male,
        age: 0,
        city: '',
      );
}
