import 'package:flutter/material.dart';
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
      ContactType.whatsapp => const ImageIcon(AssetImage('assets/icons/whatsapp.png')),
      ContactType.telegram => const ImageIcon(AssetImage('assets/icons/telegram.png')),
    };
  }
}
