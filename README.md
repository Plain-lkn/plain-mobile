# Plain Application
Plain 프로젝트의 Flutter 모바일 애플리케이션 소스 코드입니다.

## 설명
### 모든 위젯을 재구성하는 방법
> 모든 페이지 및 위젯은 RootPage의 하위 위젯이며 RootPage는 단 하나만 존재합니다. 따라서 아래와 같이 BuildContext 인스턴스를 별도로 참조하지 않아도 강제로 모든 위젯을 재구성할 수 있습니다.
```dart
RootPage.rebuild();
```
