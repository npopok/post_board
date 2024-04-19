import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile.freezed.dart';
part 'profile.g.dart';

enum Gender { male, female, other }

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
        gender: Gender.other,
        age: 0,
        city: '',
      );
}
