import 'package:location/location.dart';
import 'package:easy_localization/easy_localization.dart';

class LocationException implements Exception {
  final String message;

  const LocationException(this.message);

  @override
  String toString() => message;
}

class LocationHelper {
  static Future<LocationData?> getLocation() async {
    try {
      final location = Location();
      if (!await location.serviceEnabled() && await location.requestService()) {
        throw LocationException('LocationException.AccessError'.tr());
      }
      if ((await location.hasPermission()) == PermissionStatus.denied &&
          await location.requestPermission() != PermissionStatus.granted) {
        throw LocationException('LocationException.AccessError'.tr());
      }
      return await location.getLocation();
    } catch (e) {
      throw LocationException('LocationException.GenericError'.tr());
    }
  }
}
