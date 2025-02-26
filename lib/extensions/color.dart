import 'package:flutter/widgets.dart';

extension ColorExtension on Color {
  Color get reversed {
    return Color.fromARGB(
      alpha,
      255 - red,
      255 - green,
      255 - blue,
    );
  }
}