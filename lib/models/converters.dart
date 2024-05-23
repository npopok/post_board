import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:post_board/models/models.dart';

class ContactConverter implements JsonConverter<Contact, String> {
  const ContactConverter();

  @override
  Contact fromJson(String json) => Contact.parse(json);

  @override
  String toJson(Contact value) => value.toString();
}
