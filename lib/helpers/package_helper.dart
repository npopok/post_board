import 'package:package_info_plus/package_info_plus.dart';

class PackageHelper {
  PackageInfo? _info;

  PackageInfo get info => _info!;

  static Future<PackageHelper> getInstance() async {
    final instance = PackageHelper();
    instance._info = await PackageInfo.fromPlatform();
    return instance;
  }
}
