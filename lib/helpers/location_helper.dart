import 'package:geolocator/geolocator.dart';
import 'package:easy_localization/easy_localization.dart';

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
  static Future<(double, double)> getCurrentPosition() async {
    final enabled = await Geolocator.isLocationServiceEnabled();
    if (!enabled) {
      throw const LocationException(LocationError.serviceDisabled);
    }

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw const LocationException(LocationError.permissionDenied);
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw const LocationException(LocationError.permissionDenied);
    }

    try {
      final position = await Geolocator.getCurrentPosition();
      return (position.latitude, position.longitude);
    } catch (e) {
      throw const LocationException(LocationError.otherError);
    }
  }
}
