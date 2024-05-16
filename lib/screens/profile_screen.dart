import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:post_board/common/common.dart';
import 'package:post_board/dialogs/dialogs.dart';
import 'package:post_board/helpers/helpers.dart';
import 'package:post_board/models/models.dart';
import 'package:post_board/providers/providers.dart';

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
        actions: [
          IconButton(
            onPressed: () => context.pushRoute(const SettingsRoute()),
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: Column(
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
      title: Text('ProfileScreen.NameList'.tr()),
      subtitle: Text(profile.name),
      onTap: () => showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) => InputDialog(
          title: 'ProfileScreen.NameDialog'.tr(),
          initialValue: profile.name,
          maxLength: FieldSettings.nameMaxLength,
        ),
      ).then((value) => value != null ? _updateName(value) : 0),
    );
  }

  Widget _buildGenderTile(BuildContext context, Profile profile) {
    return ListTile(
      leading: const Icon(Icons.wc),
      title: Text('ProfileScreen.GenderList'.tr()),
      subtitle: Text('${profile.gender}'.tr()),
      onTap: () => showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) => ValueListDialog(
          title: 'ProfileScreen.GenderDialog'.tr(),
          items: List.generate(
            Gender.values.length,
            (index) => '${Gender.values[index]}'.tr(),
          ),
          values: Gender.values,
          initialValue: profile.gender,
        ),
      ).then((value) => value != null ? _updateGender(value) : 0),
    );
  }

  Widget _buildAgeTile(BuildContext context, Profile profile) {
    return ListTile(
      leading: const Icon(Icons.cake),
      title: Text('ProfileScreen.AgeList'.tr()),
      subtitle: Text(profile.age.toString()),
      onTap: () => showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) => SliderDialog(
          title: 'ProfileScreen.AgeDialog'.tr(),
          range: (
            min: FieldSettings.ageMinValue,
            max: FieldSettings.ageMaxValue,
          ),
          initialValue: profile.age,
        ),
      ).then((value) => value != null ? _updateAge(value) : 0),
    );
  }

  Widget _buildCityTile(BuildContext context, Profile profile) {
    return ListTile(
      leading: const Icon(Icons.place),
      title: Text('ProfileScreen.CityList'.tr()),
      subtitle: Text(profile.city.name),
      onTap: () => showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (_) => LocationDialog(
          title: 'ProfileScreen.CityDialog'.tr(),
          initialValue: profile.city,
        ),
      ).then((value) => value != null ? _updateCity(value) : 0),
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

  void _updateCity(City value) {
    ref.read(profileStateProvider.notifier).city = value;
    ref.read(filtersStateProvider.notifier).city = value;
    AnalyticsHelper.logEvent(AnalyticsEvent.profileUpdate, {'profile_city': value.name});
  }
}
