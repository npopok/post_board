import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

final showSnackBar = GetIt.I<MessengerHelper>().showSnackBar;

class MessengerHelper {
  final messengerKey = GlobalKey<ScaffoldMessengerState>();

  void showSnackBar(String text, [bool permanent = false]) {
    messengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(text),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.zero,
        duration: Duration(seconds: permanent ? 1000 : 2),
        showCloseIcon: permanent,
      ),
    );
  }
}

extension BuildContextExtension on BuildContext {
  Text textCentered(String text) => Text(
        text,
        textAlign: TextAlign.center,
      );

  Text textError(String text) => Text(
        text,
        style: TextStyle(color: Theme.of(this).colorScheme.error),
        textAlign: TextAlign.center,
      );
}
