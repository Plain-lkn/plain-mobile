import 'package:flutter/material.dart' hide Theme;
import 'package:flutter_plain_application/components/settings/setting_binding.dart';
import 'package:flutter_plain_application/components/settings/theme.dart';

abstract class Scheme {
  Color get background;
  Color get rearground;
  Color get foreground;
  Color get foreground2;
  Color get moreMenu;
  Color get outline;
  Color get ripple;

  static final light = LightScheme();
  static final dark = DarkScheme();

  static Scheme get current => SettingBinding.theme.current == Theme.light
    ? light
    : dark;
}

class LightScheme extends Scheme {
  @override
  Color get background => Colors.white;

  @override
  Color get rearground => const Color.fromRGBO(245, 245, 245, 1);

  @override
  Color get foreground => Colors.black;

  @override
  Color get foreground2 => const Color.fromRGBO(50, 50, 50, 1);

  @override
  Color get moreMenu => const Color.fromRGBO(240, 240, 240, 1);

  @override
  Color get outline => const Color.fromRGBO(220, 220, 220, 1);

  @override
  Color get ripple => const Color.fromRGBO(0, 0, 0, 0.1);
}

class DarkScheme extends Scheme {
  @override
  Color get background => Colors.black;

  @override
  Color get rearground => const Color.fromRGBO(30, 31, 33, 1);

  @override
  Color get foreground => Colors.white;

  @override
  Color get foreground2 => const Color.fromRGBO(180, 180, 180, 1);

  @override
  Color get moreMenu => const Color.fromRGBO(40, 41, 43, 1);

  @override
  Color get outline => const Color.fromRGBO(60, 61, 63, 1);

  @override
  Color get ripple => const Color.fromRGBO(255, 255, 255, 0.15);
}