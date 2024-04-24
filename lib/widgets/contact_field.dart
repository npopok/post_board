import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactField extends StatelessWidget {
  final String contact;

  const ContactField({required this.contact, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Text(
        contact,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Colors.blue,
            ),
      ),
      onTap: _contactTapHandler,
    );
  }

  bool isValidEmail(String email) {
    RegExp emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegExp.hasMatch(email);
  }

  bool isValidPhone(String phone) {
    RegExp phoneRegExp = RegExp(r'^[0-9 -]+$');
    return phoneRegExp.hasMatch(phone);
  }

  bool isValidTelegram(String telegram) {
    RegExp regExp = RegExp(r'^@[a-zA-Z0-9]+$');
    return regExp.hasMatch(telegram);
  }

  void _contactTapHandler() async {
    if (isValidEmail(contact)) {
      final url = Uri(scheme: 'mailto', path: contact);
      if (await canLaunchUrl(url)) {
        launchUrl(url);
      } else {
        throw 'Cannot launch URL';
      }
    } else if (isValidPhone(contact)) {
      final url = Uri(scheme: 'whatsapp', path: 'send?phone=$contact');
      if (await canLaunchUrl(url)) {
        launchUrl(url);
      } else {
        throw 'Cannot launch URL';
      }
    } else if (isValidTelegram(contact)) {
      final url = Uri(scheme: 'tg', path: 'msg?to=$contact');
      if (await canLaunchUrl(url)) {
        launchUrl(url);
      } else {
        throw 'Cannot launch URL';
      }
    } else {
      // TODO: Copy address to clipboard and show tooltip
    }
  }
}
