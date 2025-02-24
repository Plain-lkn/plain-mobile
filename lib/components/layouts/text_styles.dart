import 'package:flutter/material.dart';
import 'package:flutter_plain_application/components/scheme.dart';

abstract class TextStyles {
  static final title = TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
  static final subTitle = TextStyle(fontSize: 16, color: Scheme.current.foreground2);
  static final description = TextStyle(color: Scheme.current.foreground2);
}