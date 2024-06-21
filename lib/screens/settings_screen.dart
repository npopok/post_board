import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:post_board/dialogs/dialogs.dart';
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
          _buildThemeMode(context, settings),
        ],
      ),
    );
  }

  Widget _buildThemeMode(BuildContext context, Settings settings) {
    return ListTile(
      leading: const Icon(Icons.dark_mode_outlined),
      title: Text('SettingsScreen.ThemeMode'.tr()),
      subtitle: Text('${settings.themeMode}'.tr()),
      onTap: () => showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) => ValueListDialog<ThemeMode>(
          values: ThemeMode.values,
          textBuilder: (value) => value.toString().tr(),
          initialValue: settings.themeMode,
        ),
      ).then((value) => value == null ? 0 : _updateThemeMode(value)),
    );
  }

  void _updateThemeMode(ThemeMode value) {
    ref.read(settingsStateProvider.notifier).themeMode = value;
    logEvent(AnalyticsEvent.settingsUpdate, {AnalyticsParameter.settingsThemeMode: value});
  }
}
