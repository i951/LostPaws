// ignore_for_file: use_full_hex_values_for_flutter_colors

import 'package:flutter/animation.dart';

/// The global default padding for use on most screens in the app - 20
const double defaultPadding = 20;

class ConstColors {
  // The colors for the app
  static const Color lightGreen = Color.fromARGB(237, 231, 244, 232);
  static const Color mediumGreen = Color.fromARGB(195, 0, 124, 95);
  static const Color darkGreen = Color.fromARGB(199, 1, 70, 75);

  static const Color yellowOrange = Color.fromARGB(208, 245, 196, 0);
  static const Color darkOrange = Color.fromARGB(197, 248, 162, 1);
  static const Color lightOrange = Color.fromARGB(255, 255, 244, 202);

  static const Color babyBlue = Color.fromARGB(206, 234, 242, 255);
  static const Color highlightBlue = Color.fromARGB(197, 40, 151, 255);

  static const Color lightGrey = Color.fromARGB(199, 113, 114, 122);
  static const Color red = Color.fromARGB(198, 247, 139, 139);
}

class ApiConstants {
  /// This URI works when the server is being run locally and
  /// the Android emulator is being used
  static String baseUrl = 'http://10.0.2.2:5205';
}
