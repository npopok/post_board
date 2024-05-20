import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:post_board/common/common.dart';

import 'types.dart';

part 'contact.freezed.dart';
part 'contact.g.dart';

@freezed
class Contact with _$Contact {
  const Contact._();

  const factory Contact({
    required final ContactType type,
    required final String details,
  }) = _Contact;

  bool get isEmpty => type == ContactType.unknown || details.isEmpty;
  bool get isNotEmpty => !isEmpty;

  factory Contact.fromJson(Map<String, dynamic> json) => _$ContactFromJson(json);

  factory Contact.empty() => const Contact(
        type: ContactType.unknown,
        details: '',
      );

  factory Contact.parse(String text) {
    final emailPattern = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    final phonePattern = RegExp(r'^\+?[0-9 -]+$');
    final telegramPattern = RegExp(r'^@[a-zA-Z0-9]+$');

    if (emailPattern.hasMatch(text)) {
      return Contact(type: ContactType.email, details: text);
    } else if (phonePattern.hasMatch(text)) {
      text = text.replaceFirst(
        RegExp('^${RegionalSettings.countryCodeAlt}'),
        RegionalSettings.countryCode,
      );
      return Contact(type: ContactType.phone, details: text);
    } else if (telegramPattern.hasMatch(text)) {
      return Contact(type: ContactType.telegram, details: text);
    }
    return Contact(type: ContactType.unknown, details: text);
  }

  @override
  String toString() => details;
}

class ContactConverter implements JsonConverter<Contact, String> {
  const ContactConverter();

  @override
  Contact fromJson(String text) => Contact.parse(text);

  @override
  String toJson(Contact value) => value.toString();
}
