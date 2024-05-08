import 'package:flutter/material.dart';

class Themes {
  const Themes();

  ThemeData get lightTheme => _buildTheme(Brightness.light);
  ThemeData get darkTheme => _buildTheme(Brightness.dark);

  ThemeData _buildTheme(Brightness brightness) {
    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.black,
        isDense: true,
        border: InputBorder.none,
        errorStyle: const TextStyle(height: 0),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
      ),
      // sliderTheme: const SliderThemeData(
      //   valueIndicatorShape: DropSliderValueIndicatorShape(),
      //   rangeValueIndicatorShape: PaddleRangeSliderValueIndicatorShape(),
      // ),
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
