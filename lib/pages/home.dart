import 'package:flutter/material.dart' hide Theme;
import 'package:flutter_plain_application/components/overlays/more_menu.dart';
import 'package:flutter_plain_application/components/settings/setting_binding.dart';
import 'package:flutter_plain_application/components/settings/theme.dart';
import 'package:flutter_plain_application/widgets/appbar_connection_with_header.dart';
import 'package:flutter_rebuildable/flutter_rebuildable.dart';
import 'package:flutter_touch_ripple/widgets/touch_ripple.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return AppBarConnectionWithHeader(
      title: "Header",
      subTitle: "Sub Title",
      onBack: () {},
      onMoreMenu: (renderBox) {
        MoreMenuController.open(context, renderBox, [
            MoreMenuItem(onTap: () {}, title: "Menu 1"),
            MoreMenuItem(onTap: () {}, title: "Menu 2"),
          ]
        );
      },
      child: ListView.builder(
        itemCount: 100,
        itemBuilder: (context, index) {
          return Text("Hello, World! $index");
        },
      ),
    );
  }
}

class ThemeSettingButton extends StatelessWidget {
  const ThemeSettingButton({
    super.key,
    required this.theme
  });

  final Theme theme;

  @override
  Widget build(BuildContext context) {
    return TouchRipple(
      onTap: () {
        SettingBinding.theme.setValue(theme);
        RebuildableApp.rebuild();
      },
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Text(theme.toString()),
      ),
    );
  }
}