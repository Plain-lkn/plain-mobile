import 'package:flutter_plain_application/components/settings/setting.dart';
import 'package:flutter_plain_application/components/settings/setting_binding.dart';

enum Language {
  device,
  korean
}

class LanguageSetting extends Setting<Language> {
  @override
  Language getValue() {
    switch (SettingBinding.prefs.getString("")) {
      case "Language.device": return Language.device;
      case "Language.korean": return Language.korean;
    }

    return Language.device;
  }

  @override
  void setValue(Language newValue) {
    SettingBinding.prefs.setString(keyOf("language"), newValue.toString());
  }
}