import 'package:flutter_plain_application/components/settings/theme.dart';

class SettingBinding {
  static late final ThemeSetting theme;

  static void initializeAll() {
    theme = ThemeSetting();
  }
}