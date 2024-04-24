import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:post_board/helpers/helpers.dart';

import 'author.dart';
import 'profile.dart';

part 'post.freezed.dart';
part 'post.g.dart';

enum Category { sex, love, services, jobs, other }

@freezed
class Post with _$Post {
  const factory Post({
    required final Author author,
    required Category category,
    required String text,
    @TimestampConverter() required final DateTime timestamp,
  }) = _Post;

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  factory Post.create(Profile profile, Category category, String text) => Post(
        author: Author(
          name: profile.name,
          gender: profile.gender,
          age: profile.age,
          city: profile.city,
        ),
        category: category,
        text: text,
        timestamp: DateTime.timestamp(),
      );
}
