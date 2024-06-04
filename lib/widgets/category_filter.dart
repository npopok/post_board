import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:post_board/helpers/analytics_helper.dart';

import 'package:post_board/models/models.dart';
import 'package:post_board/providers/providers.dart';
import 'package:post_board/helpers/helpers.dart';
import 'package:post_board/widgets/widgets.dart';

class CategoryFilter extends ConsumerWidget implements PreferredSizeWidget {
  const CategoryFilter({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filters = ref.watch(filtersStateProvider);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: ChoiceField<Category>(
          key: ValueKey(filters.category),
          initialValue: filters.category,
          values: Category.values,
          textBuilder: (value) => value.toString().tr(),
          onChanged: (value) => _updateCategory(value, ref),
        ),
      ),
    );
  }

  void _updateCategory(Category value, WidgetRef ref) {
    ref.read(filtersStateProvider.notifier).category = value;
    logEvent(AnalyticsEvent.filtersUpdate, {AnalyticsParameter.filtersCategory: value});
  }
}
