import 'package:flutter/material.dart';

import 'package:post_board/common/common.dart';
import 'package:post_board/helpers/helpers.dart';
import 'package:post_board/models/models.dart';
import 'package:post_board/repositories/repositories.dart';

import 'generic_dialog.dart';

class LocationDialog extends StatefulWidget {
  final String title;
  final String successText;
  final City initialValue;

  const LocationDialog({
    required this.title,
    required this.successText,
    required this.initialValue,
    super.key,
  });

  @override
  State<LocationDialog> createState() => _LocationDialogState();
}

class _LocationDialogState extends State<LocationDialog> {
  late City selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: GenericDialog(
        title: widget.title,
        contentPadding: kInputContentPadding,
        contentBuilder: (_) => FutureBuilder(
          future: getCurrentCity(),
          builder: (context, snapshot) {
            if (snapshot.hasData) selectedValue = snapshot.data!;
            return _buildContent(context, snapshot);
          },
        ),
        actions: [
          DialogActionButton.cancel(context),
          DialogActionButton.okay(context, () => selectedValue),
        ],
      ),
    );
  }

  Future<City> getCurrentCity() async {
    final pos = await LocationHelper.getCurrentPosition();
    try {
      final cities = await getIt<CachedRepository>().loadCities();
      final city = cities.reduce(
        (c1, c2) => c1.distanceFrom(pos.$1, pos.$2) < c2.distanceFrom(pos.$1, pos.$2) ? c1 : c2,
      );
      return city;
    } catch (e) {
      throw const LocationException(LocationError.otherError);
    }
  }

  Widget _buildContent(BuildContext context, AsyncSnapshot<City> snapshot) {
    return Column(
      children: [
        TextFormField(
          key: Key(selectedValue.toString()),
          initialValue: selectedValue.toString(),
          readOnly: !snapshot.hasData,
          onTap: () => setState(() => selectedValue = City.empty()),
        ),
        SizedBox(
          height: 200,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: _buildTextArea(
                context,
                snapshot.error,
                snapshot.data,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextArea(BuildContext context, Object? error, City? data) {
    if (error != null) {
      return Text(
        error.toString(),
        style: TextStyle(color: Theme.of(context).colorScheme.error),
        textAlign: TextAlign.center,
      );
    } else if (data != null) {
      return Text(
        widget.successText,
        textAlign: TextAlign.center,
      );
    } else {
      return const CircularProgressIndicator();
    }
  }
}
