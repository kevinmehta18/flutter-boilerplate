import 'package:boilerplate/constants/colors.dart';
import 'package:boilerplate/constants/fonts.dart';
import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
    textTheme: lightThemeFonts,
    scaffoldBackgroundColor: kWhite,
    useMaterial3: false);

ThemeData darkTheme = ThemeData.dark(
  useMaterial3: false,
).copyWith(
  textTheme: darkThemeFonts,
  scaffoldBackgroundColor: kBlack,
);
