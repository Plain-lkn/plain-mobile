import 'package:flutter/material.dart' hide Theme;
import 'package:flutter_plain_application/components/app_page_route.dart';
import 'package:flutter_plain_application/components/layouts/spacing.dart';
import 'package:flutter_plain_application/components/layouts/text_styles.dart';
import 'package:flutter_plain_application/components/localization.dart';
import 'package:flutter_plain_application/components/overlays/more_menu.dart';
import 'package:flutter_plain_application/pages/sign_in.dart';
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
    return SafeArea(
      child: AppBarConnectionWithHeader(
        title: L10n.current.settings,
        onBack: () {},
        onMoreMenu: (renderBox) {
          MoreMenuController.open(context, renderBox, [
              MoreMenuItem(onTap: () {}, title: "Menu 1"),
              MoreMenuItem(onTap: () {}, title: "Menu 2 2"),
              MoreMenuItem(onTap: () {}, title: "Menu 3 3 3"),
            ]
          );
        },
        child: ListView(
          children: [
            ColumnList(
              items: [
                TestItem(
                  title: "로그인",
                  description: "임시: 로그인 페이지로 이동",
                  onTap: () {
                    Navigator.push(context, AppPageRoute(SignInPage()));
                  },
                ),
                TestItem(
                  title: "회원가입",
                  description: "임시: 회원가입 페이지로 이동",
                  onTap: () {},
                ),
              ]
            ),
          ],
        ),
      ),
    );
  }
}

class TestItem extends StatelessWidget {
  const TestItem({
    super.key,
    required this.title,
    required this.description,
    required this.onTap
  });

  final String title;
  final String description;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return TouchRipple(
      onTap: onTap,
      tapBehavior: TouchRippleBehavior(eventCallBackableMinPercent: 1),
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