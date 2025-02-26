import 'package:flutter/material.dart' hide Icons;
import 'package:flutter_plain_application/components/icons.dart';
import 'package:flutter_plain_application/components/layouts/spacing.dart';
import 'package:flutter_plain_application/components/localization.dart';
import 'package:flutter_plain_application/components/overlays/more_menu.dart';
import 'package:flutter_plain_application/components/scheme.dart';
import 'package:flutter_plain_application/widgets/appbar_connection_with_header.dart';
import 'package:flutter_plain_application/widgets/column_list.dart';
import 'package:flutter_plain_application/widgets/designed_app.dart';
import 'package:flutter_plain_application/widgets/bottom_primary_button.dart';
import 'package:flutter_plain_application/widgets/text_input.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_touch_ripple/flutter_touch_ripple.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return DesignedApp(
      child: Column(
        children: [
          Expanded(
            child: AppBarConnectionWithHeader(
              onBack: () => Navigator.pop(context),
              title: L10n.current.signIn,
              onMoreMenu: (renderBox) {
                MoreMenuController.open(context, renderBox, [
                  MoreMenuItem(onTap: () {}, title: "아이디 찾기"),
                  MoreMenuItem(onTap: () {}, title: "비밀번호 찾기"),
                  MoreMenuItem(onTap: () {}, title: "회원가입")
                ]);
              },
              child: ListView(
                padding: EdgeInsets.all(Spacing.outerPadding),
                children: [
                  Column(
                    spacing: Spacing.inputColumn,
                    children: [
                      TextInput(hintText: L10n.current.id, position: TextInputPosition.top),
                      TextInput(hintText: L10n.current.password, position: TextInputPosition.bottom),
                    ],
                  ),
                  SizedBox(height: Spacing.innerPadding),
                  OutlineWithOR(),
                  SizedBox(height: Spacing.innerPadding),
                  ColumnList(
                    padding: 0,
                    items: [
                      MoreItem(icon: Icons.googleLogo, text: L10n.current.signInWithGoogle),
                      MoreItem(icon: Icons.naverLogo, text: L10n.current.signInWithNaver),
                      MoreItem(icon: Icons.kakaoLogo, text: L10n.current.signInWithKakao),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: Spacing.outerPadding,
              right: Spacing.outerPadding,
              bottom: Spacing.outerPadding
            ),
            child: BottomPrimaryButton(text: L10n.current.summit, onTap: () {}),
          ),
        ],
      ),
    );
  }
}

class OutlineWithOR extends StatelessWidget {
  const OutlineWithOR({
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: double.infinity,
          height: 1,
          color: Scheme.current.outline,
        ),
        Container(
          padding: EdgeInsets.all(Spacing.outerPadding),
          color: Scheme.current.background,
          child: Text("OR", style: TextStyle(color: Scheme.current.foreground2)),
        )
      ],
    );
  }
}

class MoreItem extends StatelessWidget {
  const MoreItem({
    super.key,
    required this.icon,
    required this.text,
  });

  final String icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return TouchRipple(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.all(Spacing.innerPadding),
        child: Row(
          spacing: Spacing.innerPadding,
          children: [
            SvgPicture.asset(icon, width: 24, color: Scheme.current.foreground),
            Text(text, style: TextStyle(fontSize: 16))
          ],
        ),
      ),
    );
  }
}