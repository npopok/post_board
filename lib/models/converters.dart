import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:post_board/models/models.dart';

class ContactConverter implements JsonConverter<Contact, String> {
  const ContactConverter();

  @override
  Contact fromJson(String json) => Contact.parse(json);

  @override
  String toJson(Contact value) => value.toString();
}

class NumericRangeConverter implements JsonConverter<NumericRange, String> {
  const NumericRangeConverter();

  @override
  NumericRange fromJson(String json) {
    final regex = RegExp(r'\[(\d+),\s*(\d+)\)');

    final match = regex.firstMatch(json);
    if (match == null) throw const FormatException();

    int min = int.parse(match.group(1)!);
    int max = int.parse(match.group(2)!) - 1;

    return (min: min, max: max);
  }

  @override
  String toJson(NumericRange value) => '[${value.min}, ${value.max + 1})';
}
