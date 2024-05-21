import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Themes {
  const Themes();

  ThemeData get lightTheme => _buildTheme(Brightness.light);
  ThemeData get darkTheme => _buildTheme(Brightness.dark);

  ThemeData _buildTheme(Brightness brightness) {
    final themeData = ThemeData(useMaterial3: true, brightness: brightness);
    final colorScheme = themeData.colorScheme;

    bool isLight = brightness == Brightness.light;

    InputBorder inputEnabledBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Colors.transparent),
    );

    InputBorder errorInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: colorScheme.error),
    );

    return themeData.copyWith(
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: isLight ? Colors.white : Colors.black,
        isDense: true,
        border: InputBorder.none,
        errorStyle: const TextStyle(height: 0),
        enabledBorder: inputEnabledBorder,
        focusedBorder: inputEnabledBorder,
        errorBorder: errorInputBorder,
        focusedErrorBorder: errorInputBorder,
      ),
      sliderTheme: const SliderThemeData(
        valueIndicatorShape: DropSliderValueIndicatorShape(),
        rangeValueIndicatorShape: PaddleRangeSliderValueIndicatorShape(),
        showValueIndicator: ShowValueIndicator.never,
      ),
      appBarTheme: AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle(
          systemNavigationBarColor: colorScheme.surface,
        ),
      ),
    );
  }
}
