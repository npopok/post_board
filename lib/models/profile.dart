import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:post_board/models/models.dart';

part 'profile.freezed.dart';
part 'profile.g.dart';

@freezed
class Profile with _$Profile {
  const Profile._();

  const factory Profile({
    required final String name,
    required final Gender gender,
    required final int age,
    required final City city,
    @ContactConverter() required final Contact contact,
  }) = _Profile;

  bool get isComplete =>
      name.isNotEmpty &&
      gender != Gender.unknown &&
      age > 0 &&
      city.isNotEmpty &&
      contact.isNotEmpty;

  factory Profile.fromJson(Map<String, dynamic> json) => _$ProfileFromJson(json);

  factory Profile.empty() => Profile(
        name: '',
        gender: Gender.unknown,
        age: 0,
        city: City.empty(),
        contact: Contact.empty(),
      );
}
