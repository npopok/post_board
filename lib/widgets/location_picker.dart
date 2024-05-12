import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:post_board/models/models.dart';
import 'package:post_board/helpers/helpers.dart';
import 'package:post_board/repositories/repositories.dart';

class LocationPicker extends ConsumerStatefulWidget {
  final City city;
  final Function(City) onSaved;

  const LocationPicker({
    required this.city,
    required this.onSaved,
    super.key,
  });

  @override
  ConsumerState<LocationPicker> createState() => _LocationPickerState();
}

class _LocationPickerState extends ConsumerState<LocationPicker> {
  late City selectedCity;

  @override
  void initState() {
    super.initState();
    selectedCity = widget.city;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getCurrentCity(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          selectedCity = snapshot.data!;
          widget.onSaved(selectedCity);
        }
        return _buildContent(context, snapshot);
      },
    );
  }

  Future<City> getCurrentCity() async {
    final pos = await LocationHelper.getCurrentPosition();
    final cities = await cachedRepository.loadCities();
    final city = cities.reduce(
      (c1, c2) => c1.distanceFrom(pos.$1, pos.$2) < c2.distanceFrom(pos.$1, pos.$2) ? c1 : c2,
    );
    return city;
  }

  Widget _buildContent(BuildContext context, AsyncSnapshot<City> snapshot) {
    return Column(
      children: [
        TextFormField(
          key: Key(selectedCity.name),
          initialValue: selectedCity.name,
        ),
        if (snapshot.hasError) Text(snapshot.error.toString()),
        if (!snapshot.hasData) const CircularProgressIndicator(),
      ],
    );
  }
}
