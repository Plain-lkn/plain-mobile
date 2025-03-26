import 'package:flutter/material.dart' hide AppBar, Icons;
import 'package:flutter_appbar/flutter_appbar.dart';
import 'package:flutter_plain_application/components/icons.dart';
import 'package:flutter_plain_application/components/layouts/spacing.dart';
import 'package:flutter_plain_application/components/scheme.dart';
import 'package:flutter_plain_application/widgets/category_button.dart';
import 'package:flutter_plain_application/widgets/class_card.dart';
import 'package:flutter_plain_application/widgets/image_wrapper.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_touch_ripple/flutter_touch_ripple.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return AppBarConnection(
      appBars: [
        AppBar(
          behavior: MaterialAppBarBehavior(floating: true),
          body: Container(
            height: 50,
            padding: EdgeInsets.symmetric(horizontal: Spacing.innerPadding),
            child: Row(
              children: [
                Text("PLAIN", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))
              ],
            ),
          )
        ),
        AppBar(
          behavior: MaterialAppBarBehavior(floating: true),
          body: Container(
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Scheme.current.outline)),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: Spacing.innerPadding / 2
                ),
                child: Row(
                  spacing: Spacing.rowItems,
                  children: [
                    CategoryButton(text: "카테고리", svgIcon: Icons.application, isSelected: true),
                    CategoryButton(text: "강의", imgIcon: Icons.playPerspectiveMatte, isSelected: false),
                    CategoryButton(text: "클래스", imgIcon: Icons.booksPerspectiveMatte, isSelected: false),
                    CategoryButton(text: "AI 플러그인", imgIcon: Icons.codePerspectiveMatte, isSelected: false)
                  ],
                ),
              ),
            ),
          )
        ),
      ],
      child: ListView(
        padding: EdgeInsets.symmetric(vertical: Spacing.outerPadding),
        children: [
          _HeaderPageView(),
          SizedBox(height: Spacing.innerPadding),
          _LimitedEventNotice(),
          SizedBox(height: Spacing.innerPadding),
          _SeparationLine(),
          _SectionHeader(title: "카테고리별 BEST", details: "PLAIN의 베스트를 만나보세요!"),
          _SectionCategorys(
            items: [
              CategoryButton(isSelected: false, text: "필터", svgIcon: Icons.filterList),
              Container(
                width: 1,
                height: 15,
                color: Scheme.current.outline,
              ),
              CategoryButton(isSelected: true, text: "추천하는 강의"),
              CategoryButton(isSelected: false, text: "인기있는 클래스")
            ],
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(vertical: Spacing.outerPadding),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClassCard(
                  title: "라파는 정실이다, 라파는 정실이다, 라파는 정실이다, 라파는 정실이다 (1)",
                  details: "Dev Ttangkong",
                  imageURL: "https://nng-phinf.pstatic.net/MjAyNDAyMTRfMjAg/MDAxNzA3ODg2NjY1NzQx.QYEZM21IqLghz4Zbwa1TBxWsxoVIhl2_WFOr-ZLd6pwg.NOQdbcl1Hb-KHchBRxU2do1uT7xErLlbTcSfRo4ECTEg.JPEG/IMG_1850.jpeg?type=w1678",
                  price: 123456,
                  discountRate: 0.3
                ),
                ClassCard(
                  title: "땅콩의 한방클래스: 한 달 만에 끝내는 플러터 기초부터 실전까지 (2)",
                  details: "Dev Ttangkong",
                  imageURL: "https://static.inven.co.kr/column/2024/04/11/news/i8220885588.jpg",
                  price: 654321,
                  discountRate: 0.6
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _SeparationLine extends StatelessWidget {
  const _SeparationLine();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10,
      color: Scheme.current.separationLine,
    );
  }
}

class _HeaderPageView extends StatelessWidget {
  const _HeaderPageView();

  @override
  Widget build(BuildContext context) {
    final coverURL = "https://cdn.gameinsight.co.kr/news/photo/202211/25171_64125_5958.jpg";

    return Container(
      margin: EdgeInsets.symmetric(horizontal: Spacing.outerPadding),
      height: 200,
      child: PageView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Stack(
              children: [
                ImageWrapper(
                  child: Image.network(coverURL, width: double.infinity, height: double.infinity, fit: BoxFit.cover),
                ),
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.transparent,
                          Colors.black.withAlpha(100),
                          Colors.black.withAlpha(200)
                        ],
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: EdgeInsets.all(Spacing.innerPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      spacing: 10,
                      children: [
                        Text(
                          "최고의 스마트 학습 솔루션 지금 바로 새로운 AI 클래스를 경험하세요.",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(5)
                          ),
                          child: Text("BEST OR BEST", style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _LimitedEventNotice extends StatelessWidget {
  const _LimitedEventNotice();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: Spacing.outerPadding),
      padding: EdgeInsets.all(Spacing.innerPadding),
      decoration: BoxDecoration(
        color: Scheme.current.rearground,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Scheme.current.outline)
      ),
      child: Row(
        spacing: Spacing.innerPadding,
        children: [
          Image.asset(Icons.heartOnHand, width: 32),
          Expanded(
            child: Text(
              "첫 만남 수강생 한정! PLAIN이 준비한 특별 선물을 만나볼 기회",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.title,
    required this.details
  });

  final String title;
  final String details;

  @override
  Widget build(BuildContext context) {
    return TouchRipple(
      onTap: () {},
      child: Padding(
        padding: EdgeInsets.all(Spacing.outerPadding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: Spacing.textColumn,
              children: [
                Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text(details, style: TextStyle(color: Scheme.current.foreground2))
              ],
            ),
            SvgPicture.asset(Icons.arrowRight, height: 14, color: Scheme.current.foreground3)
          ],
        ),
      ),
    );
  }
}

class _SectionCategorys extends StatelessWidget {
  const _SectionCategorys({
    this.padding,
    required this.items
  });

  final EdgeInsets? padding;
  final List<Widget> items;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: padding ?? EdgeInsets.symmetric(horizontal: Spacing.outerPadding),
      scrollDirection: Axis.horizontal,
      child: Row(
        spacing: Spacing.rowItems,
        children: items,
      ),
    );
  }
}