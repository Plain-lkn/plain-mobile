import 'package:flutter/material.dart';
import 'package:flutter_plain_application/components/settings/setting_binding.dart';
import 'package:flutter_plain_application/pages/root.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SettingBinding.initializeAll();

  runApp(const RootPage());
}