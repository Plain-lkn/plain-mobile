import 'package:flutter/material.dart' hide Theme;
import 'package:flutter_plain_application/components/settings/setting_binding.dart';
import 'package:flutter_plain_application/components/settings/theme.dart';

abstract class Scheme {
  Color get background;
  Color get foreground;
  Color get ripple;

  static final light = LightScheme();
  static final dark = DarkScheme();

  static Scheme get current => SettingBinding.theme.value == Theme.light
    ? light
    : dark;
}

class LightScheme extends Scheme {
  @override
  Color get background => Colors.white;

  @override
  Color get foreground => Colors.black;

  @override
  Color get ripple => const Color.fromRGBO(0, 0, 0, 0.1);
}

class DarkScheme extends Scheme {
  @override
  Color get background => Colors.black;

  @override
  Color get foreground => Colors.white;

  @override
  Color get ripple => const Color.fromRGBO(255, 255, 255, 0.15);
}