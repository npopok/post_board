import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

class TimestampConverter implements JsonConverter<DateTime, Timestamp> {
  const TimestampConverter();

  @override
  DateTime fromJson(Timestamp timestamp) => timestamp.toDate();

  @override
  Timestamp toJson(DateTime date) => Timestamp.fromDate(date);
}

extension DateTimeExtension on DateTime {
  String formatTimeSinceNow() {
    final elapsed = DateTime.now().difference(this);

    if (elapsed.inMinutes == 0) {
      return 'Elapsed.Now'.tr();
    } else if (elapsed.inHours == 0) {
      return 'Elapsed.Minutues'.tr(args: [elapsed.inMinutes.toString()]);
    } else if (elapsed.inDays == 0) {
      return 'Elapsed.Hours'.tr(args: [elapsed.inHours.toString()]);
    } else if (elapsed.inDays < 7) {
      return 'Elapsed.Days'.tr(args: [elapsed.inDays.toString()]);
    } else if (elapsed.inDays < 30) {
      return 'Elapsed.Weeks'.tr(args: [(elapsed.inDays / 7).round().toString()]);
    } else if (elapsed.inDays < 356) {
      return 'Elapsed.Months'.tr(args: [(elapsed.inDays / 30).round().toString()]);
    } else {
      return 'Elapsed.Years';
    }
  }
}
