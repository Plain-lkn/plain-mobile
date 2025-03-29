import 'package:flutter/material.dart' hide AppBar, IconButton, Icons;
import 'package:flutter_appbar/flutter_appbar.dart';
import 'package:flutter_plain_application/components/app_page_route.dart';
import 'package:flutter_plain_application/components/icons.dart';
import 'package:flutter_plain_application/components/layouts/dimensions.dart';
import 'package:flutter_plain_application/components/layouts/spacing.dart';
import 'package:flutter_plain_application/components/scheme.dart';
import 'package:flutter_plain_application/pages/navigation.dart';
import 'package:flutter_plain_application/pages/sign_in.dart';
import 'package:flutter_plain_application/widgets/category_button.dart';
import 'package:flutter_plain_application/widgets/class_card.dart';
import 'package:flutter_plain_application/widgets/icon_button.dart';
import 'package:flutter_plain_application/widgets/image_wrapper.dart';
import 'package:flutter_plain_application/widgets/segmented_control.dart';
import 'package:flutter_plain_application/widgets/user_profile.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_touch_ripple/flutter_touch_ripple.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  // [강의/클래스] 세그먼트 레이아웃의 인덱스를 정의합니다.
  int segmentedIndex = 0;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return AppBarConnection(
      appBars: [
        AppBar(
          behavior: MaterialAppBarBehavior(floating: true),
          body: Container(
            height: 50,
            padding: EdgeInsets.only(left: Spacing.innerPadding),
            child: Row(
              children: [
                Text("PLAIN", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(icon: Icons.notification, onTap: () {}),
                      IconButton(icon: Icons.search, onTap: () {}),
                      TouchRipple(
                        rippleBorderRadius: BorderRadius.circular(1e10),
                        onTap: () {
                          Navigator.push(context, AppPageRoute((_) => SignInPage()));
                        },
                        child: Container(
                          width: 50,
                          height: 50,
                          alignment: Alignment.center,
                          child: UserProfile.offline(size: 30),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
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
        padding: EdgeInsets.symmetric(vertical: Spacing.outerPadding)
               + EdgeInsets.only(bottom: BottomNavigation.height),
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
            padding: EdgeInsets.symmetric(vertical: Spacing.outerPadding) + EdgeInsets.all(Spacing.innerPadding) / 2,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClassCard(
                  title: "라파는 정실이다, 라파는 정실이다, 라파는 정실이다, 라파는 정실이다 (1)",
                  details: "Dev Ttangkong",
                  imageURL: "https://nng-phinf.pstatic.net/MjAyNDAyMTRfMjAg/MDAxNzA3ODg2NjY1NzQx.QYEZM21IqLghz4Zbwa1TBxWsxoVIhl2_WFOr-ZLd6pwg.NOQdbcl1Hb-KHchBRxU2do1uT7xErLlbTcSfRo4ECTEg.JPEG/IMG_1850.jpeg?type=w1678",
                  price: 123456,
                  discountRate: 0.3,
                  labels: [ClassCardLabel(text: "1위", color: Colors.redAccent)],
                ),
                ClassCard(
                  title: "땅콩의 한방클래스: 한 달 만에 끝내는 플러터 기초부터 실전까지 (1)",
                  details: "Dev Ttangkong",
                  imageURL: "https://na-nikke-aws.playerinfinite.com/cms/nrft/feeds/pic/_7ebff1d531a78fc07b2a1961e65b01bdb908b22e-3840x2160-ori_s_80_50_ori_q_80.webp",
                  price: 654321,
                  discountRate: 0.6,
                  labels: [ClassCardLabel(text: "2위", color: Colors.redAccent)],
                ),
                ClassCard(
                  title: "땅콩의 한방클래스: 한 달 만에 끝내는 플러터 기초부터 실전까지 (2)",
                  details: "Dev Ttangkong",
                  imageURL: "https://na-nikke-aws.playerinfinite.com/cms/nrft/feeds/pic/_077d711e50a7bc35393d555d340efe9e877fa48f-3840x2160-ori_s_80_50_ori_q_80.webp",
                  price: 654321,
                  discountRate: 0.4,
                  labels: [ClassCardLabel(text: "3위", color: Colors.redAccent)],
                )
              ],
            ),
          ),
          _SeparationLine(),
          SizedBox(height: Spacing.innerPadding),
          Center(
            child: SegmentedControl(
              index: segmentedIndex,
              items: ["강의", "클래스"],
              onChange: (newValue) => setState(() => segmentedIndex = newValue)
            ),
          ),
          SizedBox(height: Spacing.innerPadding),
          _SectionHeader(title: "지금 가장 핫한 클래스", details: "요즘 뜨는 핫한 클래스, 실시간으로 만나보세요!"),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.all(Spacing.innerPadding) / 2,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClassCard(
                  title: "땅콩의 한방클래스: 한 달 만에 끝내는 플러터 기초부터 실전까지 (3)",
                  details: "Dev Ttangkong",
                  imageURL: "https://na-nikke-aws.playerinfinite.com/cms/nrft/feeds/pic/_f735878df51f6c63db53662da58922917a256c69-3840x2160-ori_s_80_50_ori_q_80.webp",
                  price: 123456,
                  discountRate: 0.3,
                  labels: [ClassCardLabel(text: "모집중", color: Colors.redAccent)],
                ),
                ClassCard(
                  title: "땅콩의 한방클래스: 한 달 만에 끝내는 플러터 기초부터 실전까지 (4)",
                  details: "Dev Ttangkong",
                  imageURL: "https://na-nikke-aws.playerinfinite.com/cms/nrft/feeds/pic/_0143681bca31ca601aaed8cef49335f0b9fa4812-3840x2160-ori_s_80_50_ori_q_80.webp",
                  price: 234567,
                  discountRate: 0.6,
                  labels: [
                    ClassCardLabel(text: "모집중", color: Colors.redAccent),
                    ClassCardLabel(text: "NEW", color: Colors.blue)
                  ],
                ),
                ClassCard(
                  title: "땅콩의 한방클래스: 한 달 만에 끝내는 플러터 기초부터 실전까지 (5)",
                  details: "Dev Ttangkong",
                  imageURL: "https://na-nikke-aws.playerinfinite.com/cms/nrft/feeds/pic/_a1883c603085f0415c3e4ccb3f458ab165e8aaab-3840x2160-ori_s_80_50_ori_q_80.webp",
                  price: 345678,
                  discountRate: 0.4,
                  labels: [ClassCardLabel(text: "무료특강", color: Colors.green)],
                )
              ],
            ),
          ),
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

// TODO: 임시 코드.
class HeaderPage {
  const HeaderPage({
    required this.label,
    required this.imageURL
  });

  final Widget label;
  final String imageURL;
}

class _HeaderPageView extends StatefulWidget {
  const _HeaderPageView({super.key});

  @override
  State<_HeaderPageView> createState() => _HeaderPageViewState();
}

class _HeaderPageViewState extends State<_HeaderPageView> {
  PageController? _controller;

  // TODO: 임시 코드.
  List<HeaderPage> get items => [
    HeaderPage(
      label: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        spacing: 10,
        children: [
          Text(
            "최고의 스마트 학습 솔루션 지금 바로 새로운 AI 클래스를 경험하세요.",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          createOutlineLabel("BEST OR BEST")
        ],
      ),
      imageURL: "https://na-nikke-aws.playerinfinite.com/cms/nrft/feeds/pic/_33464a6f361513f833b3363d06cb0e69e64f421d-3840x2160-ori_s_80_50_ori_q_80.webp"
    ),
    HeaderPage(
      label: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        spacing: 10,
        children: [
          Text(
            "땅콩의 최고의 솔루션! 플러터 기초부터 심화까지! 지금부터 여러분의 뇌를 태워드리므니다!",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          createOutlineLabel("TTANGKONG IS BEST")
        ],
      ),
      imageURL: "https://na-nikke-aws.playerinfinite.com/cms/nrft/feeds/pic/_48ece32af89c41fbd10c2cc30d992b02114572ff-3840x2160-ori_s_80_50_ori_q_80.webp"
    ),
    HeaderPage(
      label: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        spacing: 10,
        children: [
          Text(
            "도로시는 정실이다, 도로시는 정실이다, 도로시는 정실이다, 도로시는 정실이다.",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          createOutlineLabel("DOROTHY IS BEST")
        ],
      ),
      imageURL: "https://na-nikke-aws.playerinfinite.com/cms/nrft/feeds/pic/_3bb1f65e182ba340ef35b3937100c314b5b2ff4d-1920x1080-ori_s_80_50_ori_q_80.webp"
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;
        final viewport = maxWidth - Spacing.outerPadding * 2;
        final viewGaps = Spacing.rowItems;
        final fraction = viewGaps / maxWidth + viewport / maxWidth;

        _controller?.dispose();
        _controller = PageController(viewportFraction: fraction);

        return SizedBox(
          height: 200,
          child: PageView.builder(
            controller: _controller,
            clipBehavior: Clip.none,
            itemCount: items.length,
            itemBuilder: (context, index) {
              return createPageItem(items[index], viewGaps / maxWidth);
            }
          ),
        );
      },
    );
  }
  
  Widget createOutlineLabel(String text) {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(5)
      ),
      child: Text(text, style: TextStyle(color: Colors.white)),
    );
  }

  Widget createPageItem(HeaderPage info, double gapFraction) {
    return FractionallySizedBox(
      widthFactor: 1 - gapFraction,
      child: ClipRRect(
        borderRadius: Dimensions.borderRadius,
        child: Stack(
          children: [
            ImageWrapper(
              child: Image.network(info.imageURL, width: double.infinity, height: double.infinity, fit: BoxFit.cover),
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
                child: info.label
              ),
            ),
          ],
        ),
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
        borderRadius: Dimensions.borderRadius,
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