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
        ],
      ),
    );
  }

  Widget _buildGenderTile(BuildContext context, Filters filter) {
    return ListTile(
      leading: const Icon(Icons.wc),
      title: Text('FiltersScreen.Gender'.tr()),
      subtitle: Text('${filter.gender}'.tr()),
      onTap: () => showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) => ValueListDialog(
          items: List.generate(
            Gender.values.length,
            (index) => '${Gender.values[index]}'.tr(),
          ),
          values: Gender.values,
          initialValue: filter.gender,
        ),
      ).then((value) => value == null ? 0 : _updateGender(value)),
    );
  }

  Widget _buildAgeTile(BuildContext context, Filters filter) {
    return ListTile(
      leading: const Icon(Icons.cake),
      title: Text('FiltersScreen.Age'.tr()),
      subtitle: Text(
        'FiltersScreen.Range'.tr(args: [
          filter.age.min.toString(),
          filter.age.max.toString(),
        ]),
      ),
      onTap: () => showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) => RangeDialog(
          title: 'FiltersScreen.Age'.tr(),
          range: (
            min: FieldSettings.ageMinValue,
            max: FieldSettings.ageMaxValue,
          ),
          initialValue: filter.age,
        ),
      ).then((value) => value != null ? _updateAge(value) : 0),
    );
  }

  void _updateGender(Gender value) {
    ref.read(filtersStateProvider.notifier).gender = value;
    AnalyticsHelper.logEvent(AnalyticsEvent.filtersUpdate, {'filters_gender': value});
  }

  void _updateAge(NumericRange value) {
    ref.read(filtersStateProvider.notifier).age = value;
    AnalyticsHelper.logEvent(AnalyticsEvent.filtersUpdate, {'filters_age': value.toString()});
  }
}
