import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityHelper {
  late StreamSubscription<List<ConnectivityResult>> subscription;
  bool hasDisconnect = false;

  void subscribe({
    required Function() onConnect,
    required Function() onDisconnect,
  }) {
    final stream = Connectivity().onConnectivityChanged;
    subscription = stream.listen((List<ConnectivityResult> result) {
      if (result.contains(ConnectivityResult.none)) {
        onDisconnect();
        hasDisconnect = true;
      } else {
        if (hasDisconnect) {
          hasDisconnect = false;
          onConnect();
        }
      }
    });
  }

  void unsubscribe() {
    subscription.cancel();
  }
}
