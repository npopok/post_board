import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ConnectivityHelper {
  late final StreamSubscription<List<ConnectivityResult>> _subscription;
  bool _connected = true;

  bool get isConnected => _connected;
  bool get isDisconnected => !_connected;

  void subscribe({Function()? onConnect, Function()? onDisconnect}) {
    final stream = Connectivity().onConnectivityChanged;
    _subscription = stream.listen((List<ConnectivityResult> result) {
      debugPrint('ConnectivityHelper: received event $result');
      if (result.contains(ConnectivityResult.none)) {
        _connected = false;
        onDisconnect?.call();
      } else {
        if (isDisconnected) {
          _connected = true;
          onConnect?.call();
        }
      }
    });
  }

  void unsubscribe() {
    _subscription.cancel();
  }
}
