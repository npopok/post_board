import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

final showSnackBar = GetIt.I<MessengerHelper>().showSnackBar;

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
