import 'package:freezed_annotation/freezed_annotation.dart';

import 'types.dart';
import 'profile.dart';

part 'post.freezed.dart';
part 'post.g.dart';

@freezed
class Post with _$Post {
  const factory Post({
    @JsonKey(name: 'created_at', includeToJson: false) final DateTime? createdAt,
    @JsonKey(name: 'created_by', includeToJson: false) final String? createdBy,
    required final String author,
    required final Gender gender,
    required final int age,
    @JsonKey(name: 'city_id') required final int cityId,
    required Category category,
    required String text,
    required String contact,
  }) = _Post;

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  factory Post.create(
    Profile profile,
    Category category,
    String text,
    String contact,
  ) =>
      Post(
        author: profile.name,
        gender: profile.gender,
        age: profile.age,
        cityId: profile.city.id,
        category: category,
        text: text,
        contact: contact,
      );
}
