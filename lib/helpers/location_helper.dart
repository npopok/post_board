import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:post_board/models/models.dart';
import 'package:post_board/common/common.dart' as common;

enum LocationError { serviceDisabled, permissionDenied, otherError }

class LocationException implements Exception {
  final LocationError error;

  const LocationException(this.error);

  @override
  String toString() => switch (error) {
        LocationError.serviceDisabled => 'LocationException.ServiceDisabled'.tr(),
        LocationError.permissionDenied => 'LocationException.PermissionDenied'.tr(),
        LocationError.otherError => 'LocationException.OtherError'.tr(),
      };
}

class LocationHelper {
  static Future<void> checkPermission({required bool requestPermission}) async {
    final enabled = await Geolocator.isLocationServiceEnabled();
    if (!enabled) {
      throw const LocationException(LocationError.serviceDisabled);
    }

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      if (requestPermission) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw const LocationException(LocationError.permissionDenied);
        }
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw const LocationException(LocationError.permissionDenied);
    }
  }

  static Future<Location> getCurrentPosition({required bool requestPermission}) async {
    await checkPermission(requestPermission: requestPermission);

    try {
      final position = await Geolocator.getCurrentPosition();
      return Location(latitude: position.latitude, longitude: position.longitude);
    } catch (e) {
      throw const LocationException(LocationError.otherError);
    }
  }
}

class LocationListener with ChangeNotifier {
  static const settings = LocationSettings(
    distanceFilter: common.LocationSettings.listenerDistance,
  );

  StreamSubscription? _subscription;
  Location _location = Location.empty();

  Location get location => _location;

  static Future<LocationListener> getInstance() async {
    final listener = LocationListener();
    await listener.initialize(requestPermission: true);
    return listener;
  }

  Future<void> initialize({required bool requestPermission}) async {
    Geolocator.getServiceStatusStream().listen(
      (status) {
        _debugLog(status.toString());
        if (status == ServiceStatus.enabled) _subscribe();
      },
    );

    try {
      _location = await LocationHelper.getCurrentPosition(requestPermission: requestPermission);
      _debugLog('initial location $_location');
    } on LocationException catch (e) {
      _debugLog('Failed to get current position: ${e.error}');
    }

    try {
      _subscribe();
    } catch (e) {
      _debugLog('Failed to subscribe to position stream: $e}');
    }
  }

  void _subscribe() {
    _subscription?.cancel();
    _subscription = Geolocator.getPositionStream(locationSettings: settings).listen(
      (position) {
        _location = Location(latitude: position.latitude, longitude: position.longitude);
        _debugLog('updated location $_location');
        notifyListeners();
      },
      onError: (error) => _debugLog('Failed to subscribe: $error'),
    );
  }

  void _debugLog(String message) => debugPrint('LocationListener: $message');
}

class DistanceFormatter {
  static String format(double distance) {
    if (distance < 100) {
      return 'Distance.Near'.tr();
    } else if (distance < 1000) {
      return 'Distance.Meters'.tr(args: [((distance ~/ 100) * 100).toString()]);
    } else if (distance < 100000) {
      return 'Distance.Kilometers'.tr(args: [(distance ~/ 1000).toString()]);
    } else if (distance < 1000000) {
      return 'Distance.Kilometers'.tr(args: [((distance ~/ 10000) * 10).toString()]);
    } else {
      return 'Distance.Far'.tr();
    }
  }
}
