import 'package:easy_localization/easy_localization.dart';

extension DateTimeExtension on DateTime {
  int timeSinceNow() {
    return DateTime.now().difference(this).inMicroseconds;
  }
}

extension DurationExtension on Duration {
  String formatTimeAgo() {
    if (inMinutes == 0) {
      return 'Elapsed.Now'.tr();
    } else if (inHours == 0) {
      return 'Elapsed.Minutes'.tr(args: [inMinutes.toString()]);
    } else if (inDays == 0) {
      return 'Elapsed.Hours'.tr(args: [inHours.toString()]);
    } else if (inDays < 7) {
      return 'Elapsed.Days'.tr(args: [inDays.toString()]);
    } else if (inDays < 30) {
      return 'Elapsed.Weeks'.tr(args: [(inDays / 7).round().toString()]);
    } else if (inDays < 356) {
      return 'Elapsed.Months'.tr(args: [(inDays / 30).round().toString()]);
    } else {
      return 'Elapsed.Years';
    }
  }
}
