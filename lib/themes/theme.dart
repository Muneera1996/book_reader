import 'package:flutter/material.dart';
import 'light_color.dart';

class AppTheme {
  const AppTheme();

  static ColorScheme colorScheme = const ColorScheme(
    brightness: Brightness.light,
    primary: LightColor.primaryColor,
    onPrimary: LightColor.onPrimary,
    secondary: LightColor.secondaryColor,
    onSecondary: LightColor.onSecondary,
    error: LightColor.error,
    onError: LightColor.onError,
    background: LightColor.background,
    onBackground: LightColor.onBackground,
    surface: LightColor.surface,
    onSurface: LightColor.onSurface,
  );

  static ThemeData lightTheme = ThemeData(
    colorScheme: colorScheme,
    useMaterial3: true,
    splashColor: LightColor.primaryLightColor,
    primaryColor: LightColor.primaryColor,
    backgroundColor: LightColor.background,
    buttonTheme: const ButtonThemeData(buttonColor: LightColor.secondaryColor),
    cardTheme: const CardTheme(color: LightColor.surface),
    textTheme: const TextTheme(
      headline1: TextStyle(color: LightColor.black),
      subtitle1: TextStyle(color: LightColor.lightGrey),
    ),
    iconTheme: const IconThemeData(color: LightColor.secondaryColor),
    dividerColor: LightColor.lightGrey,
  );

  static TextStyle titleStyle = const TextStyle(color: LightColor.titleTextColor, fontSize: 16);
  static TextStyle subTitleStyle = const TextStyle(color: LightColor.subTitleTextColor, fontSize: 12);

  static TextStyle h1Style = const TextStyle(fontSize: 24, fontWeight: FontWeight.bold);
  static TextStyle h2Style = const TextStyle(fontSize: 22, fontWeight: FontWeight.bold);
  static TextStyle h3Style = const TextStyle(fontSize: 20);
  static TextStyle h4Style = const TextStyle(fontSize: 15, color: LightColor.primaryColor, letterSpacing: 1.0);
  static TextStyle h5Style = const TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
  static TextStyle h6Style = const TextStyle(fontSize: 16);

  static const padding = 10.0;
  static EdgeInsets aPadding = const EdgeInsets.all(padding);
  static EdgeInsets hPadding = const EdgeInsets.symmetric(horizontal: padding);
  static EdgeInsets vPadding = const EdgeInsets.symmetric(vertical: padding);
  static EdgeInsets bPadding = const EdgeInsets.symmetric(vertical: padding, horizontal: 20);

  static double fullWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double fullHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }
}
