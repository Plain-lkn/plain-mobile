import 'package:flutter/material.dart' hide Theme;
import 'package:flutter/services.dart';
import 'package:flutter_plain_application/components/settings/setting_binding.dart';
import 'package:flutter_plain_application/components/settings/theme.dart';
import 'package:flutter_plain_application/pages/navigation.dart';
import 'package:flutter_plain_application/widgets/designed_app.dart';
import 'package:flutter_plain_application/widgets/environment.dart';
import 'package:flutter_rebuildable/widgets/rebuildable_app.dart';

class RootPage extends StatelessWidget {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context) {
    // 상태바 스타일은 테마 또는 사용자 설정 값에 따라 유동적으로 변경될 수 있으므로  
    // 이를 제대로 반영하기 위해서 최상위 위젯의 빌드 시점에서 설정합니다.
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: SettingBinding.theme.current == Theme.dark
        ? Brightness.light
        : Brightness.dark,
    ));

    return EnvironmentListener(
      onChangeBrightness: RebuildableApp.rebuild,
      onChangeSetting: RebuildableApp.rebuild,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: DesignedApp(
          child: const NavigationPage()
        ),
      )
    );
  }
}