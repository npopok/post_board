import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:post_board/common/depedencies.dart';

import 'package:post_board/models/models.dart';
import 'package:post_board/helpers/helpers.dart';
import 'package:post_board/repositories/repositories.dart';

class LocationPicker extends ConsumerStatefulWidget {
  final City city;

  const LocationPicker({
    required this.city,
    super.key,
  });

  @override
  ConsumerState<LocationPicker> createState() => _LocationPickerState();
}

class _LocationPickerState extends ConsumerState<LocationPicker> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          initialValue: widget.city.name,
        ),
        FutureBuilder(
          future: getCurrentCity(),
          builder: (context, snapshot) {
            if (snapshot.hasError) return Text(snapshot.error.toString());
            if (snapshot.hasData) return Text(snapshot.data!.name.toString());
            return const CircularProgressIndicator();
          },
        ),
      ],
    );
  }

  Future<City> getCurrentCity() async {
    final pos = await LocationHelper.getCurrentPosition();
    final cities = await getIt<CachedRepository>().loadCities();
    final city = cities.reduce(
      (c1, c2) => c1.distanceFrom(pos.$1, pos.$2) < c2.distanceFrom(pos.$1, pos.$2) ? c1 : c2,
    );
    return city;
  }
}
