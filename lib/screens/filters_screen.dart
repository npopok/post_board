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
class FiltersScreen extends ConsumerStatefulWidget {
  const FiltersScreen({super.key});

  @override
  ConsumerState<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends ConsumerState<FiltersScreen> {
  @override
  Widget build(BuildContext context) {
    final filters = ref.watch(filtersStateProvider);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('FiltersScreen.Title'.tr()),
      ),
      body: Column(
        children: [
          _buildGenderTile(context, filters),
          _buildAgeTile(context, filters),
          _buildCityTile(context, filters),
          _buildDistanceTile(context, filters),
        ],
      ),
    );
  }

  Widget _buildGenderTile(BuildContext context, Filters filter) {
    final values = Gender.values.exclude(Gender.unknown);

    return ListTile(
      leading: const Icon(Icons.wc),
      title: Text('FiltersScreen.GenderTile'.tr()),
      subtitle: Text('${filter.gender}'.tr()),
      onTap: () => showModalBottomSheet<Gender>(
        isScrollControlled: true,
        context: context,
        builder: (context) => ValueListDialog<Gender>(
          values: values,
          title: 'FiltersScreen.GenderDialog'.tr(),
          textBuilder: (value) => value.toString().tr(),
          initialValue: filter.gender,
        ),
      ).then((value) => value == null ? 0 : _updateGender(value)),
    );
  }

  Widget _buildAgeTile(BuildContext context, Filters filter) {
    return ListTile(
      leading: const Icon(Icons.cake),
      title: Text('FiltersScreen.AgeTile'.tr()),
      subtitle: Text(
        'FiltersScreen.AgeText'.tr(args: [
          filter.age.min.toString(),
          filter.age.max.toString(),
        ]),
      ),
      onTap: () => showModalBottomSheet<NumericRange>(
        isScrollControlled: true,
        context: context,
        builder: (context) => RangeDialog(
          title: 'FiltersScreen.AgeDialog'.tr(),
          buttonTitle: 'Button.Save'.tr(),
          range: (
            min: FieldConstraints.ageMinValue,
            max: FieldConstraints.ageMaxValue,
          ),
          initialValue: filter.age,
        ),
      ).then((value) => value != null ? _updateAge(value) : 0),
    );
  }

  Widget _buildCityTile(BuildContext context, Filters filters) {
    return ListTile(
      leading: const Icon(Icons.place),
      title: Text('FiltersScreen.CityTile'.tr()),
      subtitle: Text(filters.city.name),
      onTap: () => showModalBottomSheet<City>(
        isScrollControlled: true,
        context: context,
        builder: (_) => LocationDialog(
          title: 'FiltersScreen.CityDialog'.tr(),
          buttonTitle: 'Button.Save'.tr(),
          initialValue: filters.city,
          successText: 'FiltersScreen.CitySuccess'.tr(),
        ),
      ).then((value) => value != null ? _updateCity(value) : 0),
    );
  }

  Widget _buildDistanceTile(BuildContext context, Filters filters) {
    return ListTile(
      leading: const Icon(Icons.straighten_outlined),
      title: Text('FiltersScreen.DistanceTile'.tr()),
      subtitle: Text('FiltersScreen.DistanceText'.tr(args: [
        filters.distance!.toString(),
      ])),
      onTap: () => showModalBottomSheet<int>(
        isScrollControlled: true,
        context: context,
        builder: (_) => SliderDialog(
          title: 'FiltersScreen.DistanceDialog'.tr(),
          titleEmpty: 'FiltersScreen.DistanceDialog'.tr(),
          buttonTitle: 'Button.Save'.tr(),
          range: (min: FieldConstraints.distanceMinValue, max: FieldConstraints.distanceMaxValue),
          initialValue: filters.distance!,
        ),
      ).then((value) => value != null ? _updateDistnace(value) : 0),
    );
  }

  void _updateGender(Gender value) {
    ref.read(filtersStateProvider.notifier).gender = value;
    logEvent(AnalyticsEvent.filtersUpdate, {AnalyticsParameter.filtersGender: value});
  }

  void _updateAge(NumericRange value) {
    ref.read(filtersStateProvider.notifier).age = value;
    logEvent(AnalyticsEvent.filtersUpdate, {AnalyticsParameter.filtersAge: value.toString()});
  }

  void _updateCity(City value) {
    ref.read(filtersStateProvider.notifier).city = value;
    logEvent(AnalyticsEvent.profileUpdate, {AnalyticsParameter.filtersCity: value.name});
  }

  void _updateDistnace(int value) {
    ref.read(filtersStateProvider.notifier).distance = value;
    logEvent(AnalyticsEvent.profileUpdate, {AnalyticsParameter.fitlersDistance: value});
  }
}
