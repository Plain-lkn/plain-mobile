import 'package:flutter/material.dart' hide Theme;
import 'package:flutter_plain_application/components/layouts/spacing.dart';
import 'package:flutter_plain_application/components/layouts/text_styles.dart';
import 'package:flutter_plain_application/components/localization.dart';
import 'package:flutter_plain_application/components/overlays/more_menu.dart';
import 'package:flutter_plain_application/widgets/appbar_connection_with_header.dart';
import 'package:flutter_plain_application/widgets/column_list.dart';
import 'package:flutter_touch_ripple/flutter_touch_ripple.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return AppBarConnectionWithHeader(
      title: L10n.current.settings,
      onBack: () {},
      onMoreMenu: (renderBox) {
        MoreMenuController.open(context, renderBox, [
            MoreMenuItem(onTap: () {}, title: "Menu 1"),
            MoreMenuItem(onTap: () {}, title: "Menu 2"),
            MoreMenuItem(onTap: () {}, title: "Menu 3"),
          ]
        );
      },
      child: ListView(
        children: [
          ColumnList(
            items: [
              TestItem(title: "Hello, World! 1", description: "Description 1"),
              TestItem(title: "Hello, World! 2", description: "Description 2"),
              TestItem(title: "Hello, World! 3", description: "Description 3"),
            ]
          ),
        ],
      ),
    );
  }
}

class TestItem extends StatelessWidget {
  const TestItem({
    super.key,
    required this.title,
    required this.description
  });

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return TouchRipple(
      onTap: () {},
      child: Padding(
        padding: EdgeInsets.all(Spacing.innerPadding),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            spacing: Spacing.textColumn,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(title, style: TextStyles.title),
              Text(description, style: TextStyles.description)
            ],
          ),
        )
      ),
    );
  }
}