import 'package:flutter/material.dart';

class Themes {
  const Themes();

  ThemeData get lightTheme => _buildTheme(Brightness.light);
  ThemeData get darkTheme => _buildTheme(Brightness.dark);

  ThemeData _buildTheme(Brightness brightness) {
    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
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
