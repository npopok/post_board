import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:post_board/common/common.dart';
import 'package:post_board/dialogs/dialogs.dart';
import 'package:post_board/helpers/helpers.dart';
import 'package:post_board/models/models.dart';
import 'package:post_board/providers/profile_state.dart';

@RoutePage()
class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final profile = ref.watch(profileStateProvider);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('ProfileScreen.Title'.tr()),
      ),
      body: ListView(
        children: [
          _buildNameTile(context, profile),
          _buildGenderTile(context, profile),
          _buildAgeTile(context, profile),
          _buildCityTile(context, profile),
        ],
      ),
    );
  }

  Widget _buildNameTile(BuildContext context, Profile profile) {
    return ListTile(
      leading: const Icon(Icons.person),
      title: Text('ProfileScreen.Name'.tr()),
      subtitle: Text(profile.name),
      onTap: () => showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) => InputDialog(
          initialValue: profile.name,
          maxLength: kMaxNameLength,
        ),
      ).then((value) => value == null ? 0 : _updateName(value)),
    );
  }

  Widget _buildGenderTile(BuildContext context, Profile profile) {
    return ListTile(
      leading: const Icon(Icons.wc),
      title: Text('ProfileScreen.Gender'.tr()),
      subtitle: Text('${profile.gender}'.tr()),
      onTap: () => showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) => ValueListDialog(
          items: List.generate(
            Gender.values.length,
            (index) => '${Gender.values[index]}'.tr(),
          ),
          values: Gender.values,
          initialValue: profile.gender,
        ),
      ).then((value) => value == null ? 0 : _updateGender(value)),
    );
  }

  Widget _buildAgeTile(BuildContext context, Profile profile) {
    final ages = List.generate(81 - 18, (index) => index + 18);

    return ListTile(
      leading: const Icon(Icons.cake),
      title: Text('ProfileScreen.Age'.tr()),
      subtitle: Text(profile.age.toString()),
      onTap: () => showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) => ValueListDialog(
          items: List.generate(
            ages.length,
            (index) => ages[index].toString(),
          ),
          values: ages,
          initialValue: profile.age,
          alignment: Alignment.center,
        ),
      ).then((value) => value == null ? 0 : _updateAge(value)),
    );
  }

  Widget _buildCityTile(BuildContext context, Profile profile) {
    return ListTile(
      leading: const Icon(Icons.place),
      title: Text('ProfileScreen.City'.tr()),
      subtitle: Text(profile.city),
      onTap: () => showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) => ValueListDialog(
          items: ['Москва', 'Новосибирск'],
          values: ['Москва', 'Новосибирск'],
          initialValue: profile.city,
        ),
      ).then((value) => value == null ? 0 : _updateCity(value)),
    );
  }

  void _updateName(String value) {
    ref.read(profileStateProvider.notifier).name = value;
    AnalyticsHelper.logEvent(AnalyticsEvent.profileUpdate, {'profile_name': value});
  }

  void _updateGender(Gender value) {
    ref.read(profileStateProvider.notifier).gender = value;
    AnalyticsHelper.logEvent(AnalyticsEvent.profileUpdate, {'profile_gender': value});
  }

  void _updateAge(int value) {
    ref.read(profileStateProvider.notifier).age = value;
    AnalyticsHelper.logEvent(AnalyticsEvent.profileUpdate, {'profile_age': value});
  }

  void _updateCity(String value) {
    ref.read(profileStateProvider.notifier).city = value;
    AnalyticsHelper.logEvent(AnalyticsEvent.profileUpdate, {'profile_city': value});
  }
}
