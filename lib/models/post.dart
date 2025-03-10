import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:post_board/models/models.dart';

part 'post.freezed.dart';
part 'post.g.dart';

@freezed
class Post with _$Post {
  const factory Post({
    required final int id,
    @JsonKey(name: 'created_at') required final DateTime createdAt,
    @JsonKey(name: 'created_ago') required final int createdAgo,
    // TODO: Make it non-nullable after removing post scrapper
    @JsonKey(name: 'created_by') required final String? createdBy,
    required final String author,
    required final Gender gender,
    required final int age,
    required final City city,
    required final Category category,
    required final String text,
    @ContactConverter() required final Contact contact,
    @LocationConverter() required final Location location,
  }) = _Post;

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  factory Post.create(
    Profile profile,
    Category category,
    String text,
    Location location,
  ) =>
      Post(
        id: 0,
        createdAt: DateTime.timestamp(),
        createdAgo: 0,
        createdBy: '',
        author: profile.name,
        gender: profile.gender,
        age: profile.age,
        city: profile.city,
        contact: profile.contact,
        category: category,
        text: text,
        location: Location.empty(),
      );
}
