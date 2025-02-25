# Plain Application
Plain 프로젝트의 Flutter 모바일 애플리케이션 소스 코드입니다.

## 설명
### 모든 위젯을 재구성하는 방법
> 모든 페이지 및 위젯은 RebuildableApp의 하위 위젯이며 RebuildableApp는 단 하나만 존재합니다. 따라서 아래와 같이 BuildContext 인스턴스를 별도로 참조하지 않아도 강제로 모든 위젯을 재구성할 수 있습니다.

```dart
// Context 없이 전역적으로 호출하는 경우.
RebuildableApp.rebuild();

// Context으로 참조하여 호출하는 경우.
Reuilbdable.of(context).rebuild();
```

### 더보기 메뉴
```dart
// 열기
MoreMenuController.open(context, renderBox, [
    MoreMenuItem(onTap: () {}, title: "Menu 1"),
    MoreMenuItem(onTap: () {}, title: "Menu 2"),
]);

// 닫기
MoreMenuController.close();
```