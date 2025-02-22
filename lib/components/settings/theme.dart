import 'package:flutter/foundation.dart';
import 'package:flutter_plain_application/components/settings/setting.dart';

enum Theme {
  device,
  light,
  dark,
}

class ThemeSetting extends Setting<Theme> {
  ThemeSetting() : super();

  @override
  Theme get defaultValue => Theme.device;

  @override
  Theme get value {
    return PlatformDispatcher.instance.platformBrightness == Brightness.light
      ? Theme.light
      : Theme.dark;
  }
}