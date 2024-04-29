import 'package:url_launcher/url_launcher.dart';

class LaunchHelper {
  static Future<bool> openUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      return launchUrl(uri, mode: LaunchMode.externalNonBrowserApplication);
    } else {
      return false;
    }
  }

  static Future<bool> openEmail(String address) async {
    return openUrl('mailto:$address');
  }

  static Future<bool> openWhatsApp(String phone) async {
    phone = phone.replaceFirst(RegExp(r'^8'), '+7');
    return openUrl('https://wa.me/$phone');
  }

  static Future<bool> openTelegram(String name) async {
    name = name.replaceFirst(RegExp('^@'), '');
    return openUrl('https://t.me/$name');
  }
}
