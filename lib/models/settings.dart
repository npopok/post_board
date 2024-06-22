import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:post_board/common/common.dart';

part 'settings.freezed.dart';
part 'settings.g.dart';

@freezed
class Settings with _$Settings {
  const factory Settings({
    required final bool darkTheme,
    required final bool showDistance,
  }) = _Settings;

  factory Settings.fromJson(Map<String, dynamic> json) => _$SettingsFromJson(json);

  factory Settings.empty() => const Settings(
        darkTheme: DefaultSettings.darkTheme,
        showDistance: DefaultSettings.showDistance,
      );
}
