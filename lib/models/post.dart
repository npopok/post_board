import 'package:freezed_annotation/freezed_annotation.dart';

import 'types.dart';
import 'profile.dart';

part 'post.freezed.dart';
part 'post.g.dart';

@freezed
class Post with _$Post {
  const factory Post({
    @JsonKey(name: 'created_by', includeToJson: false) final String? createdBy,
    @JsonKey(name: 'created_at', includeToJson: false) final DateTime? createdAt,
    required final String author,
    required final Gender gender,
    required final int age,
    required final String city,
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
        city: profile.city,
        category: category,
        text: text,
        contact: contact,
      );
}
