import 'package:freezed_annotation/freezed_annotation.dart';

part 'contact.freezed.dart';
part 'contact.g.dart';

enum ContactType { unknown, email, phone, telegram }

@freezed
class Contact with _$Contact {
  const factory Contact({
    required final ContactType type,
    required final String details,
  }) = _Contact;

  factory Contact.fromJson(Map<String, dynamic> json) => _$ContactFromJson(json);

  factory Contact.parse(String text) {
    final emailPattern = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    final phonePattern = RegExp(r'^\+?[0-9 -]+$');
    final telegramPattern = RegExp(r'^@[a-zA-Z0-9]+$');

    if (emailPattern.hasMatch(text)) {
      return Contact(type: ContactType.email, details: text);
    } else if (phonePattern.hasMatch(text)) {
      return Contact(type: ContactType.phone, details: text);
    } else if (telegramPattern.hasMatch(text)) {
      return Contact(type: ContactType.telegram, details: text);
    }
    return Contact(type: ContactType.unknown, details: text);
  }
}
