import 'package:flutter/material.dart' hide Theme;
import 'package:flutter_plain_application/components/settings/setting_binding.dart';
import 'package:flutter_plain_application/components/settings/theme.dart';

abstract class Scheme {
  Color get primary;
  Color get background;
  Color get rearground;
  Color get foreground;
  Color get foreground2;
  Color get foreground3;
  Color get moreMenu;
  Color get outline;
  Color get separationLine;
  Color get ripple;
  Color get translucent;
  Color get bottomNavigation;

  static final light = LightScheme();
  static final dark = DarkScheme();

  static Scheme get current => SettingBinding.theme.current == Theme.light
    ? light
    : dark;
}

class LightScheme extends Scheme {
  @override Color get primary => Color.fromRGBO(0, 100, 220, 1);
  @override Color get background => Colors.white;
  @override Color get rearground => const Color.fromRGBO(245, 245, 245, 1);
  @override Color get foreground => Colors.black;
  @override Color get foreground2 => const Color.fromRGBO(100, 100, 100, 1);
  @override Color get foreground3 => const Color.fromRGBO(150, 150, 150, 1);
  @override Color get moreMenu => const Color.fromRGBO(235, 235, 235, 1);
  @override Color get outline => const Color.fromRGBO(230, 230, 230, 1);
  @override Color get separationLine => const Color.fromRGBO(240, 240, 240, 1);
  @override Color get ripple => const Color.fromRGBO(0, 0, 0, 0.1);
  @override Color get translucent => Colors.black.withAlpha(100);
  @override Color get bottomNavigation => rearground.withAlpha(200);
}

class DarkScheme extends Scheme {
  @override Color get primary => Color.fromRGBO(0, 150, 220, 1);
  @override Color get background => const Color.fromRGBO(17, 18, 20, 1);
  @override Color get rearground => const Color.fromRGBO(40, 41, 44, 1);
  @override Color get foreground => Colors.white;
  @override Color get foreground2 => const Color.fromRGBO(150, 150, 150, 1);
  @override Color get foreground3 => const Color.fromRGBO(100, 100, 100, 1);
  @override Color get moreMenu => const Color.fromRGBO(46, 47, 50, 1);
  @override Color get outline => const Color.fromRGBO(60, 61, 63, 1);
  @override Color get separationLine => const Color.fromRGBO(10, 11, 13, 1);
  @override Color get ripple => const Color.fromRGBO(255, 255, 255, 0.15);
  @override Color get translucent => Colors.black.withAlpha(150);
  @override Color get bottomNavigation => rearground.withAlpha(230);
}