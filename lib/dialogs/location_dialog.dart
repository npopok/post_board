import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:post_board/common/common.dart';
import 'package:post_board/helpers/helpers.dart';
import 'package:post_board/models/models.dart';
import 'package:post_board/repositories/repositories.dart';

import 'generic_dialog.dart';

enum LocationDialogStatus {
  initial,
  searchStart,
  searchResults,
  searchSelected,
  locationStart,
  locationSuccess,
  locationError,
}

class LocationDialog extends StatefulWidget {
  static const minLength = 3;
  static const searchLimit = 3;
  static const textAreaHeight = 140.0;

  final String? title;
  final String? buttonTitle;
  final City initialValue;
  final String successText;
  final EdgeInsets? contentPadding;
  final Function(City)? onSelected;

  const LocationDialog({
    this.title,
    this.buttonTitle,
    required this.initialValue,
    required this.successText,
    this.contentPadding,
    this.onSelected,
    super.key,
  });

  @override
  State<LocationDialog> createState() => _LocationDialogState();
}

class _LocationDialogState extends State<LocationDialog> {
  late ValueNotifier<LocationDialogStatus> currentStatus;
  late List<City> cities;
  late City selectedValue;
  String enteredText = '';
  String errorText = '';

  @override
  void initState() {
    super.initState();
    selectedValue = widget.initialValue;
    currentStatus = ValueNotifier(LocationDialogStatus.initial);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: GenericDialog(
        title: widget.title,
        contentPadding: widget.contentPadding ?? DialogPaddings.locationContent,
        contentBuilder: (context) => FutureBuilder(
            future: cachedRepository.loadCities(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                cities = snapshot.data!;
                return _buildContent(context);
              }
              if (snapshot.hasError) {
                return context.textError('LocationDialog.ErrorText'.tr());
              }
              return const CircularProgressIndicator();
            }),
        actions: [
          if (widget.buttonTitle != null)
            DialogActionButton.submit(
              context,
              widget.buttonTitle!,
              () => selectedValue.isNotEmpty ? selectedValue : widget.initialValue,
            )
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentStatus,
      builder: (_, value, __) => Column(
        children: [
          TextFormField(
            key: Key(selectedValue.toString()),
            initialValue: selectedValue.toString(),
            readOnly: selectedValue.isNotEmpty,
            onTap: _inputTapHandler,
            onChanged: _inputChangedHandler,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                onPressed: _determineCityHandler,
                icon: const Icon(Icons.near_me),
              ),
            ),
          ),
          SizedBox(
            height: LocationDialog.textAreaHeight,
            child: Center(child: _buildTextArea(context)),
          ),
        ],
      ),
    );
  }

  Widget _buildTextArea(BuildContext context) {
    Widget area = switch (currentStatus.value) {
      LocationDialogStatus.initial => context.textCentered('LocationDialog.SearchText'.tr()),
      LocationDialogStatus.searchStart => context.textCentered('LocationDialog.SearchText'.tr()),
      LocationDialogStatus.searchResults => _buildSearchResults(),
      LocationDialogStatus.searchSelected => context.textCentered(widget.successText),
      LocationDialogStatus.locationStart => const CircularProgressIndicator(),
      LocationDialogStatus.locationSuccess => context.textCentered(widget.successText),
      LocationDialogStatus.locationError => context.textError(errorText),
    };
    if (area is Text) {
      return Padding(padding: const EdgeInsets.all(8), child: area);
    }
    if (area is LocationSearchResults) {
      return Padding(padding: const EdgeInsets.only(top: 12), child: area);
    }
    return area;
  }

  Widget _buildSearchResults() {
    return LocationSearchResults(
      cities: cities,
      text: enteredText,
      searchLimit: LocationDialog.searchLimit,
      emptyText: 'LocationDialog.EmptyText'.tr(),
      onSaved: (value) {
        selectedValue = value;
        widget.onSelected?.call(selectedValue);
        currentStatus.value = LocationDialogStatus.searchSelected;
      },
    );
  }

  void _inputTapHandler() {
    selectedValue = City.empty();
    currentStatus.value = LocationDialogStatus.searchStart;
  }

  void _inputChangedHandler(String value) {
    enteredText = value;
    if (value.length < LocationDialog.minLength) {
      currentStatus.value = LocationDialogStatus.searchStart;
    } else {
      currentStatus.value = LocationDialogStatus.initial;
      currentStatus.value = LocationDialogStatus.searchResults;
    }
  }

  void _determineCityHandler() async {
    try {
      currentStatus.value = LocationDialogStatus.locationStart;
      selectedValue = await _getCurrentCity();
      widget.onSelected?.call(selectedValue);
      currentStatus.value = LocationDialogStatus.locationSuccess;
    } catch (e) {
      errorText = e.toString();
      currentStatus.value = LocationDialogStatus.locationError;
    }
  }

  Future<City> _getCurrentCity() async {
    final pos = await LocationHelper.getCurrentPosition();
    try {
      cities = await cachedRepository.loadCities();
      final city = cities.reduce(
        (c1, c2) => c1.distanceFrom(pos.$1, pos.$2) < c2.distanceFrom(pos.$1, pos.$2) ? c1 : c2,
      );
      return city;
    } catch (e) {
      throw const LocationException(LocationError.otherError);
    }
  }
}

class LocationSearchResults extends StatelessWidget {
  final List<City> cities;
  final String text;
  final int searchLimit;
  final String emptyText;
  final void Function(City) onSaved;

  const LocationSearchResults({
    required this.cities,
    required this.text,
    required this.searchLimit,
    required this.emptyText,
    required this.onSaved,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final matches = cities
        .where((e) => e.name.toLowerCase().startsWith(
              text.trim().toLowerCase(),
            ))
        .toList();
    matches.sort((a, b) => a.compareTo(b));

    final results = matches.take(searchLimit).toList();
    if (results.isNotEmpty) {
      return Column(
        children: results
            .map((e) => ListTile(
                  dense: true,
                  visualDensity: const VisualDensity(vertical: -2),
                  title: Text(e.toString(), overflow: TextOverflow.ellipsis),
                  onTap: () => onSaved(e),
                ))
            .toList(),
      );
    } else {
      return Text(emptyText);
    }
  }
}
