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

  static Future<bool> openEmail(String contact) async {
    return openUrl('mailto:$contact');
  }

  static Future<bool> openWhatsApp(String contact) async {
    return openUrl('https://wa.me/$contact');
  }

  static Future<bool> openTelegram(String contact) async {
    return openUrl('https://t.me/${contact.substring(1)}');
  }
}
