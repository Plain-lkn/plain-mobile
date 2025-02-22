import 'package:flutter/material.dart' hide Theme;
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_plain_application/components/scheme.dart';
import 'package:flutter_plain_application/components/settings/setting_binding.dart';
import 'package:flutter_plain_application/components/settings/theme.dart';
import 'package:flutter_plain_application/pages/home.dart';
import 'package:flutter_plain_application/widgets/environment.dart';
import 'package:flutter_touch_ripple/flutter_touch_ripple.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  /// 해당 함수를 호출한다면 해당 위젯과 그 외 모든 하위 위젯을 재빌드됩니다.
  static late final VoidCallback rebuild;

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  /// 주어진 컨텍스트의 모든 하위 위젯들을 다음 프레임에서 재구성해야할 위젯으로 정의합니다.
  static void rebuildAllChildren(BuildContext context) {
    void rebuild(Element element) {
      element.markNeedsBuild();
      element.visitChildren(rebuild);
    }

    (context as Element).visitChildren(rebuild);
  }

  @override
  void initState() {
    super.initState();

    RootPage.rebuild = () {
      final isFrameRendering = WidgetsBinding.instance.schedulerPhase != SchedulerPhase.idle;

      if (isFrameRendering) {
      	setState(() => rebuildAllChildren(context));
      } else {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          setState(() => rebuildAllChildren(context));
        });
      }
    };
  }

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
      onChangeBrightness: RootPage.rebuild,
      onChangeSetting: RootPage.rebuild,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Scheme.current.background,
          body: DefaultTextStyle(
            style: TextStyle(color: Scheme.current.foreground),
            child: TouchRippleStyle(
              rippleColor: Scheme.current.ripple,
              child: SafeArea(
                child: const HomePage()
              ),
            ),
          ),
        ),
      )
    );
  }
}