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
class FilterScreen extends ConsumerStatefulWidget {
  const FilterScreen({super.key});

  @override
  ConsumerState<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends ConsumerState<FilterScreen> {
  @override
  Widget build(BuildContext context) {
    final filter = ref.watch(filterStateProvider);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('FilterScreen.Title'.tr()),
      ),
      body: Column(
        children: [
          _buildGenderTile(context, filter),
          _buildAgeTile(context, filter),
        ],
      ),
    );
  }

  Widget _buildGenderTile(BuildContext context, Filter filter) {
    return ListTile(
      leading: const Icon(Icons.wc),
      title: Text('FilterScreen.Gender'.tr()),
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

  Widget _buildAgeTile(BuildContext context, Filter filter) {
    return ListTile(
      leading: const Icon(Icons.cake),
      title: Text('FilterScreen.Age'.tr()),
      subtitle: Text(
        'FilterScreen.Range'.tr(args: [
          filter.age.min.toString(),
          filter.age.max.toString(),
        ]),
      ),
      onTap: () => showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) => RangeDialog(
          title: 'FilterScreen.Age'.tr(),
          range: (min: kAgeMinValue, max: kAgeMaxValue),
          initialValue: filter.age,
        ),
      ).then((value) => value != null ? _updateAge(value) : 0),
    );
  }

  void _updateGender(Gender value) {
    ref.read(filterStateProvider.notifier).gender = value;
    AnalyticsHelper.logEvent(AnalyticsEvent.filterUpdate, {'filter_gender': value});
  }

  void _updateAge(NumericRange value) {
    ref.read(filterStateProvider.notifier).age = value;
    AnalyticsHelper.logEvent(AnalyticsEvent.filterUpdate, {'filter_age': value.toString()});
  }
}
