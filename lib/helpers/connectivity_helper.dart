import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityHelper {
  late StreamSubscription<List<ConnectivityResult>> subscription;
  bool hasDisconnect = false;

  void subscribe(Function() onConnect, Function() onDisconnect) {
    subscription = Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> result) {
      if (result.contains(ConnectivityResult.none)) {
        onConnect();
        hasDisconnect = true;
      } else {
        if (hasDisconnect) {
          hasDisconnect = false;
          onDisconnect();
        }
      }
    });
  }

  void unsubscribe() {
    subscription.cancel();
  }
}
