import 'package:flutter_plain_application/components/settings/landuage.dart';
import 'package:flutter_plain_application/components/settings/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingBinding {
  static late final SharedPreferences prefs;
  static late final ThemeSetting theme;
  static late final LanguageSetting language;

  static Future<void> initializeAll() async {
    prefs = await SharedPreferences.getInstance();
    theme = ThemeSetting();
    language = LanguageSetting();
  }
}