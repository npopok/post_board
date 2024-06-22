import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:post_board/helpers/analytics_helper.dart';

import 'package:post_board/helpers/helpers.dart';
import 'package:post_board/models/models.dart';
import 'package:post_board/providers/providers.dart';
import 'package:post_board/common/common.dart';

@RoutePage()
class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsStateProvider);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('SettingsScreen.Title'.tr()),
      ),
      body: ListView(
        children: [
          _buildDarkTheme(context, settings),
          _buildShowDistance(context, settings),
        ],
      ),
    );
  }

  Widget _buildDarkTheme(BuildContext context, Settings settings) {
    return SwitchListTile.adaptive(
      value: settings.darkTheme,
      secondary: const Icon(Icons.dark_mode_outlined),
      title: Text('SettingsScreen.DarkTheme'.tr()),
      onChanged: (value) => _updateDarkTheme(value),
    );
  }

  Widget _buildShowDistance(BuildContext context, Settings settings) {
    return SwitchListTile.adaptive(
      value: settings.showDistance,
      secondary: const Icon(Icons.location_on_outlined),
      title: Text('SettingsScreen.ShowDistance'.tr()),
      onChanged: (value) => _updateShowDistance(value),
    );
  }

  void _updateDarkTheme(bool value) {
    ref.read(settingsStateProvider.notifier).darkTheme = value;
    logEvent(AnalyticsEvent.settingsUpdate, {AnalyticsParameter.settingsDarkTheme: value});
  }

  void _updateShowDistance(bool value) {
    ref.read(settingsStateProvider.notifier).showDistance = value;
    logEvent(AnalyticsEvent.settingsUpdate, {AnalyticsParameter.settingsShowDistance: value});
  }
}
