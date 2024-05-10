import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:post_board/models/models.dart';
import 'package:post_board/helpers/helpers.dart';

class LocationPicker extends StatefulWidget {
  final City city;

  const LocationPicker({
    required this.city,
    super.key,
  });

  @override
  State<LocationPicker> createState() => _LocationPickerState();
}

class _LocationPickerState extends State<LocationPicker> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          initialValue: widget.city.name,
        ),
        FutureBuilder(
          future: LocationHelper.getLocation(),
          builder: (context, snapshot) {
            if (snapshot.hasError) return Text(snapshot.error.toString());
            if (snapshot.hasData) return Text(snapshot.data!.latitude.toString());
            return const CircularProgressIndicator();
          },
        ),
      ],
    );
  }
}
