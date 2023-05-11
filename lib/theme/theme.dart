import 'package:flutter/material.dart';

///colors
const kLightColor = Colors.white;
const kDarkItem = Color(0xff0c0c0c);
const kDarkBackground = Color(0xff111010);

const kItemColor = Color(0xff06C149);

///theme
final darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  scaffoldBackgroundColor: kDarkBackground,
  hintColor: Colors.white,
  iconTheme: const IconThemeData(color: Colors.white, size: 8),
  primaryColorLight: kDarkItem,
  fontFamily: 'Georgia',
  checkboxTheme: CheckboxThemeData(
      checkColor: MaterialStateProperty.all(Colors.white),
      fillColor: MaterialStateProperty.all(kItemColor)),
  focusColor: Colors.white,
  textTheme: const TextTheme(
    displayLarge: TextStyle(
        fontSize: 50.0, fontWeight: FontWeight.bold, color: kLightColor),
    titleLarge: TextStyle(
        fontSize: 22.0, fontStyle: FontStyle.italic, color: kLightColor),
    titleMedium: TextStyle(
        fontSize: 18.0, fontStyle: FontStyle.italic, color: kLightColor),
    titleSmall: TextStyle(
        fontSize: 16.0, fontStyle: FontStyle.normal, color: kLightColor),
    bodyMedium:
        TextStyle(fontSize: 12.0, fontFamily: 'Hind', color: kLightColor),
  ),
);

final lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  scaffoldBackgroundColor: Colors.white,
  hintColor: Colors.white,
  primaryColorLight: Colors.white,
  fontFamily: 'Georgia',
  textTheme: const TextTheme(
    displayLarge: TextStyle(fontSize: 50.0, fontWeight: FontWeight.bold),
    titleLarge: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
    bodyMedium: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
  ),
);
