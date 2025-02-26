
/// 코드 가독성을 위해 별도로 [Localization] 클래스의 축약형 타입을 선언하였습니다.
typedef L10n = Localization;

abstract class Localization {
  String get settings;
  String get signIn;
  String get id;
  String get password;
  String get signInWithGoogle;
  String get signInWithNaver;
  String get signInWithKakao;

  static final korean = KoreanLocalization();

  // TODO: 추후 여러 언어가 추가될 때는 수정되어야 함.
  static Localization get current => korean;
}

class KoreanLocalization extends Localization {
  @override
  String get settings => "설정";

  @override
  String get signIn => "로그인";

  @override
  String get id => "아이디";

  @override
  String get password => "비밀번호";
  
  @override
  String get signInWithGoogle => "구글 계정으로 로그인";

  @override
  String get signInWithNaver => "네이버 계정으로 로그인";

  @override
  String get signInWithKakao => "카카오 계정으로 로그인";
}