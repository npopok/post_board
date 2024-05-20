import 'package:flutter/material.dart';
import 'package:post_board/common/common.dart';
import 'package:post_board/models/models.dart';

class ContactIcon extends StatelessWidget {
  final ContactType type;

  const ContactIcon({
    required this.type,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return switch (type) {
      ContactType.unknown => const Icon(Icons.arrow_drop_down, size: 24),
      ContactType.email => const Icon(Icons.email_outlined),
      ContactType.phone => const Icon(Icons.phone_outlined),
      ContactType.telegram => CommonIcons.telegram,
    };
  }
}
