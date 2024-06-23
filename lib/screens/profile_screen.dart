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
          _buildContactTile(context, profile),
        ],
      ),
    );
  }

  Widget _buildNameTile(BuildContext context, Profile profile) {
    return ListTile(
      leading: const Icon(Icons.person),
      title: Text('ProfileScreen.NameTile'.tr()),
      subtitle: Text(
        profile.name.isNotEmpty ? profile.name : 'ProfileScreen.Empty'.tr(),
      ),
      onTap: () => showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) => InputDialog(
          title: 'ProfileScreen.NameDialog'.tr(),
          buttonTitle: 'Button.Save'.tr(),
          initialValue: profile.name,
          maxLength: FieldConstraints.nameMaxLength,
          errorText: '',
        ),
      ).then((value) => value != null ? _updateName(value) : 0),
    );
  }

  Widget _buildGenderTile(BuildContext context, Profile profile) {
    return ListTile(
      leading: const Icon(Icons.wc),
      title: Text('ProfileScreen.GenderTile'.tr()),
      subtitle: Text(
        profile.gender != Gender.unknown
            ? profile.gender.toString().tr()
            : 'ProfileScreen.Empty'.tr(),
      ),
      onTap: () => showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) => ValueListDialog<Gender>(
          title: 'ProfileScreen.GenderDialog'.tr(),
          values: Gender.values.exclude(Gender.unknown),
          textBuilder: (value) => value.toString().tr(),
          initialValue: profile.gender,
        ),
      ).then((value) => value != null ? _updateGender(value) : 0),
    );
  }

  Widget _buildAgeTile(BuildContext context, Profile profile) {
    return ListTile(
      leading: const Icon(Icons.cake),
      title: Text('ProfileScreen.AgeTile'.tr()),
      subtitle: Text(
        profile.age > 0 ? profile.age.toString() : 'ProfileScreen.Empty'.tr(),
      ),
      onTap: () => showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) => SliderDialog(
          title: 'ProfileScreen.AgeDialog'.tr(),
          titleEmpty: 'ProfileScreen.AgeEmpty'.tr(),
          buttonTitle: 'Button.Save'.tr(),
          range: (
            min: FieldConstraints.ageMinValue,
            max: FieldConstraints.ageMaxValue,
          ),
          initialValue: profile.age,
        ),
      ).then((value) => value != null ? _updateAge(value) : 0),
    );
  }

  Widget _buildCityTile(BuildContext context, Profile profile) {
    return ListTile(
      leading: const Icon(Icons.place),
      title: Text('ProfileScreen.CityTile'.tr()),
      subtitle: Text(
        profile.city.isNotEmpty ? profile.city.name : 'ProfileScreen.Empty'.tr(),
      ),
      onTap: () => showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (_) => LocationDialog(
          title: 'ProfileScreen.CityDialog'.tr(),
          buttonTitle: 'Button.Save'.tr(),
          initialValue: profile.city,
          successText: 'ProfileScreen.CitySuccess'.tr(),
        ),
      ).then((value) => value != null ? _updateCity(value) : 0),
    );
  }

  Widget _buildContactTile(BuildContext context, Profile profile) {
    return ListTile(
      leading: const Icon(Icons.alternate_email),
      title: Text('ProfileScreen.ContactTile'.tr()),
      subtitle: Text(
        profile.contact.isNotEmpty ? profile.contact.toString() : 'ProfileScreen.Empty'.tr(),
      ),
      onTap: () => showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (_) => ContactDialog(
          title: 'ProfileScreen.ContactDialog'.tr(),
          buttonTitle: 'Button.Save'.tr(),
          initialValue: profile.contact,
          hintText: 'ProfileScreen.ContactHint'.tr(),
          errorText: '',
        ),
      ).then((value) => value != null ? _updateContact(value) : 0),
    );
  }

  void _updateName(String value) {
    ref.read(profileStateProvider.notifier).name = value;
    logEvent(AnalyticsEvent.profileUpdate, {AnalyticsParameter.profileName: value});
  }

  void _updateGender(Gender value) {
    ref.read(profileStateProvider.notifier).gender = value;
    logEvent(AnalyticsEvent.profileUpdate, {AnalyticsParameter.profileGender: value});
  }

  void _updateAge(int value) {
    ref.read(profileStateProvider.notifier).age = value;
    logEvent(AnalyticsEvent.profileUpdate, {AnalyticsParameter.profileAge: value});
  }

  void _updateCity(City value) {
    ref.read(profileStateProvider.notifier).city = value;
    logEvent(AnalyticsEvent.profileUpdate, {AnalyticsParameter.profileCity: value.name});
  }

  void _updateContact(Contact value) {
    ref.read(profileStateProvider.notifier).contact = value;
    logEvent(AnalyticsEvent.profileUpdate, {AnalyticsParameter.profileContact: value.details});
  }
}
