
/// 코드 가독성을 위해 별도로 [Localization] 클래스의 축약형 타입을 선언하였습니다.
typedef L10n = Localization;

abstract class Localization {
  String get settings;

  static final korean = KoreanLocalization();

  // TODO: 추후 여러 언어가 추가될 때는 수정되어야 함.
  static Localization get current => korean;
}

class KoreanLocalization extends Localization {
  @override
  String get settings => "설정";
}