import 'package:flutter/material.dart';

@immutable

/// A class that holds all the color constants used in the app.

class ColorConstants {
  const ColorConstants();

  /// The color constant used in the app.
  static const Color colorPrimary = Colors.black;
  static const Color colorSecondary = Colors.white;
  static const Color colorGray = Color.fromRGBO(216, 216, 216, 1);
  static const Color colorTertiary = Color.fromRGBO(173, 173, 173, 1);
  static const Color backgroundColor = Color.fromRGBO(246, 246, 246, 1);
  static const Color grey = Color.fromRGBO(122, 122, 122, 1);
  static const Color grey100 = Color.fromRGBO(209, 213, 219, 1);
  static const Color grey200 = Color.fromRGBO(156, 163, 175, 1);
  static const Color grey300 = Color.fromRGBO(212, 212, 216, 1);
  static const Color grey400 = Color.fromRGBO(228, 228, 231, 1);
  static const Color grey500 = Color.fromRGBO(113, 113, 122, 1);
  static const Color grey2000 = Color.fromRGBO(228, 228, 231, 1);
  static const Color unavailableCell = Color.fromRGBO(240, 241, 246, 1);
  static const Color selectedCell = Color.fromRGBO(34, 34, 34, 1);
  static const Color rangeCell = Color.fromRGBO(206, 206, 210, 1);
}
