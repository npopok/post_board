import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile.freezed.dart';
part 'profile.g.dart';

enum Gender { unknown, male, female }

@freezed
class Profile with _$Profile {
  const factory Profile({
    @Default('') final String name,
    @Default(Gender.unknown) final Gender gender,
    @Default(0) final int age,
    @Default('') final String city,
  }) = _Profile;

  factory Profile.fromJson(Map<String, dynamic> json) => _$ProfileFromJson(json);
}
