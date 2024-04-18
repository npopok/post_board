import 'package:flutter/material.dart';

class MessengerHelper {
  final messengerKey = GlobalKey<ScaffoldMessengerState>();

  void showSnackBar(String text) {
    messengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(text),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
