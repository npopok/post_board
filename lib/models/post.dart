import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:post_board/models/models.dart';

part 'post.freezed.dart';
part 'post.g.dart';

@freezed
class Post with _$Post {
  const factory Post({
    required final int id,
    required final DateTime createdAt,
    required final Duration createdAgo,
    required final String? createdBy, // TODO: Make it non-nullable after removing post scrapper
    required final String author,
    required final Gender gender,
    required final int age,
    required final City city,
    required final Category category,
    required final String text,
    @ContactConverter() required Contact contact,
    required final double? latitude, // TODO: Make it non-nullable after full migration to 0.3.0
    required final double? longitude, // TODO: Make it non-nullable after full migration to 0.3.0
    required final double distance,
  }) = _Post;

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  factory Post.create(
    Profile profile,
    Category category,
    String text,
    Contact contact,
    Location location,
  ) =>
      Post(
        id: 0,
        createdAt: DateTime.timestamp(),
        createdAgo: Duration.zero,
        createdBy: '',
        author: profile.name,
        gender: profile.gender,
        age: profile.age,
        city: profile.city,
        category: category,
        text: text,
        contact: contact,
        latitude: location.latitude,
        longitude: location.longitude,
        distance: 0,
      );
}
