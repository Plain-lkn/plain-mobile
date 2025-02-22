import 'package:flutter/foundation.dart';
import 'package:flutter_plain_application/components/settings/setting.dart';
import 'package:flutter_plain_application/components/settings/setting_binding.dart';

enum Theme {
  device,
  light,
  dark,
}

class ThemeSetting extends Setting<Theme> {
  Theme get device {
    return PlatformDispatcher.instance.platformBrightness == Brightness.light
      ? Theme.light
      : Theme.dark;
  }

  Theme get current {
    final value = getValue();
    return value == Theme.device ? device : value;
  }

  @override
  Theme getValue() {
    switch (SettingBinding.prefs.getString(keyOf("theme"))) {
      case "Theme.device": return Theme.device;
      case "Theme.light": return Theme.light;
      case "Theme.dark": return Theme.dark;
    }

    return Theme.device;
  }

  @override
  void setValue(Theme newValue) {
    SettingBinding.prefs.setString(keyOf("theme"), newValue.toString());
  }
}