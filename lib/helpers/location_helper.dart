import 'dart:async';

import 'package:flutter/foundation.dart';
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
  static Future<Location> getCurrentPosition([bool requestPermission = true]) async {
    final enabled = await Geolocator.isLocationServiceEnabled();
    if (!enabled) {
      throw const LocationException(LocationError.serviceDisabled);
    }

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      if (requestPermission) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.denied) {
        throw const LocationException(LocationError.permissionDenied);
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw const LocationException(LocationError.permissionDenied);
    }

    try {
      final position = await Geolocator.getCurrentPosition();
      return (latitude: position.latitude, longitude: position.longitude);
    } catch (e) {
      throw const LocationException(LocationError.otherError);
    }
  }
}

class LocationListener {
  Location? _location;

  Location get location => _location ?? common.LocationSettings.emptyLocation;

  LocationListener() {
    const settings = LocationSettings(
      distanceFilter: common.LocationSettings.distanceFilter,
    );
    Geolocator.getPositionStream(locationSettings: settings).listen(
      (Position position) {
        _location = (latitude: position.latitude, longitude: position.longitude);
        debugPrint('LocationListener: received location $_location');
      },
    );
  }
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
