import 'package:flutter/material.dart';

import 'light_color.dart';


class AppTheme {
  const AppTheme();
  static ThemeData lightTheme = ThemeData(
    splashColor: LightColor.background,
    //primarySwatch: LightColor.background,
    backgroundColor: LightColor.background,
    primaryColor: LightColor.primaryColor,
    primaryColorDark: LightColor.primaryDarkColor,
    primaryColorLight: LightColor.primaryLightColor,
    buttonTheme: ButtonThemeData(buttonColor: LightColor.secondaryColor),
    cardTheme: CardTheme(color: LightColor.background),
    textTheme: TextTheme(subtitle1: TextStyle(color: LightColor.black)),
    iconTheme: IconThemeData(color: LightColor.secondaryColor),
    bottomAppBarColor: LightColor.background,
    dividerColor: LightColor.lightGrey,
    primaryTextTheme: TextTheme(
      bodySmall: TextStyle(color:LightColor.titleTextColor)
    )
  );

  static TextStyle titleStyle = const TextStyle(color: LightColor.titleTextColor, fontSize: 16);
  static TextStyle subTitleStyle = const TextStyle(color: LightColor.subTitleTextColor, fontSize: 12);

  static TextStyle h1Style = const TextStyle(fontSize: 24, fontWeight: FontWeight.bold);
  static TextStyle h2Style = const TextStyle(fontSize: 22, fontWeight: FontWeight.bold);
  static TextStyle h3Style = const TextStyle(fontSize: 20);
  static TextStyle h4Style = const TextStyle(fontSize: 15,color: LightColor.primaryColor,letterSpacing: 1.0); //button with secondary color
  static TextStyle h5Style = const TextStyle(fontSize: 16,fontWeight: FontWeight.bold);//price
  static TextStyle h6Style = const TextStyle(fontSize: 16);//normal least text


  
  static const padding = 10.0;
  static EdgeInsets aPadding = const EdgeInsets.all(padding);
  static EdgeInsets hPadding = const EdgeInsets.symmetric(horizontal: padding,);
  static EdgeInsets vPadding = const EdgeInsets.symmetric(vertical: padding,);
  static EdgeInsets bPadding = const EdgeInsets.symmetric(vertical: padding,horizontal: 20);

  static double fullWidth(BuildContext context){
    return MediaQuery.of(context).size.width;
  }
  static double fullHeight(BuildContext context){
    return MediaQuery.of(context).size.height;
  }
}
