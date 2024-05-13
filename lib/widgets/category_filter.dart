import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:post_board/models/models.dart';
import 'package:post_board/providers/providers.dart';
import 'package:post_board/helpers/helpers.dart';

class CategoryFilter extends ConsumerWidget {
  const CategoryFilter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ref.watch(filtersStateProvider);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Wrap(
          spacing: 12,
          children: List.generate(
            Category.values.length,
            (index) => ChoiceChip(
              showCheckmark: false,
              label: Text(Category.values[index].toString().tr()),
              selected: filter.category == Category.values[index],
              onSelected: (_) => _updateCategory(Category.values[index], ref),
            ),
          ),
        ),
      ),
    );
  }

  void _updateCategory(Category value, WidgetRef ref) {
    ref.read(filtersStateProvider.notifier).category = value;
    AnalyticsHelper.logEvent(AnalyticsEvent.filtersUpdate, {'filters_category': value});
  }
}
