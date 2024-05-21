import 'package:flutter/material.dart';

class Themes {
  const Themes();

  ThemeData lightTheme(BuildContext context) {
    return _buildTheme(Brightness.light, context);
  }

  ThemeData darkTheme(BuildContext context) {
    return _buildTheme(Brightness.dark, context);
  }

  ThemeData _buildTheme(Brightness brightness, BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    bool isLight = brightness == Brightness.light;

    InputBorder inputEnabledBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Colors.transparent),
    );

    InputBorder errorInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: colorScheme.error),
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
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
      // appBarTheme: AppBarTheme(
      //   elevation: 0,
      //   backgroundColor: Colors.transparent,
      //   systemOverlayStyle: SystemUiOverlayStyle(
      //     systemNavigationBarColor: Colors.transparent,
      //     statusBarColor: Colors.transparent,
      //     statusBarIconBrightness:
      //         brightness == Brightness.light ? Brightness.dark : Brightness.light,
      //   ),
      // ),
      // tabBarTheme: const TabBarTheme(
      //   dividerColor: Colors.transparent,
      // ),
      // navigationBarTheme: const NavigationBarThemeData(
      //   elevation: 0,
      //   backgroundColor: Colors.transparent,
      //   indicatorColor: Colors.transparent,
      // ),
    );
  }
}
