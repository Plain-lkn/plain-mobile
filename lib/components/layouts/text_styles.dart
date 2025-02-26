import 'package:flutter/material.dart';
import 'package:flutter_plain_application/components/scheme.dart';

abstract class TextStyles {
  static TextStyle get title => TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
  static TextStyle get subTitle => TextStyle(fontSize: 16, color: Scheme.current.foreground2);
  static TextStyle get description => TextStyle(color: Scheme.current.foreground2);
}