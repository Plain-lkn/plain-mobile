import 'package:flutter/material.dart';
import 'package:flutter_plain_application/components/settings/setting_binding.dart';
import 'package:flutter_plain_application/pages/root.dart';

void main() {
  SettingBinding.initializeAll();

  runApp(const RootPage());
}