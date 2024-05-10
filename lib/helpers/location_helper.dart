import 'package:geolocator/geolocator.dart';
import 'package:easy_localization/easy_localization.dart';

class LocationException implements Exception {
  final String message;

  const LocationException(this.message);

  @override
  String toString() => message;
}

class LocationHelper {
  static Future<(double, double)> getCurrentPosition() async {
    try {
      final enabled = await Geolocator.isLocationServiceEnabled();
      if (!enabled) {
        throw LocationException('LocationException.AccessError'.tr());
      }

      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw LocationException('LocationException.AccessError'.tr());
        }
      }
      if (permission == LocationPermission.deniedForever) {
        throw LocationException('LocationException.AccessError'.tr());
      }

      final position = await Geolocator.getCurrentPosition();
      return (position.latitude, position.longitude);
    } catch (e) {
      throw LocationException('LocationException.GenericError'.tr());
    }
  }
}
