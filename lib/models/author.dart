import 'package:freezed_annotation/freezed_annotation.dart';

import 'profile.dart';

part 'author.freezed.dart';
part 'author.g.dart';

@freezed
class Author with _$Author {
  const factory Author({
    required final String name,
    required final Gender gender,
    required final int age,
    required String city,
    required String contact,
  }) = _Author;

  factory Author.fromJson(Map<String, dynamic> json) => _$AuthorFromJson(json);
}
