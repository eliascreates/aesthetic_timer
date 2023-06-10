import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static Color lightBackgroundColor = const Color(0xffC34854);
  static Color lightAccentColor = const Color(0xff7b272f);
  static Color lightDisabledColor = const Color(0xff48161b);
  static Color lightPrimaryColor = const Color(0xff7b272f);

  static Color darkBackgroundColor = const Color(0xff3B3649);
  static Color darkAccentColor = const Color(0xff008f00);
  static Color darkDisabledColor = const Color(0xff005c00);
  static Color darkPrimaryColor = const Color(0xff4C4750);

  static final ThemeData lightTheme = ThemeData(
    primaryColor: lightPrimaryColor,
    floatingActionButtonTheme:
        FloatingActionButtonThemeData(backgroundColor: lightAccentColor),
    colorScheme: ColorScheme.light(
      background: lightBackgroundColor,
      secondary: lightDisabledColor,
    ),
  );

  static Brightness get currentSystemBrightness =>
      PlatformDispatcher.instance.platformBrightness;

  static final ThemeData darkTheme = ThemeData(
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: darkAccentColor, disabledElevation: 0),
    primaryColor: darkPrimaryColor,
    colorScheme: ColorScheme.dark(
      secondary: darkDisabledColor,
      background: darkBackgroundColor,
    ),
  );
}
