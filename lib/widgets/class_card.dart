import 'package:flutter/material.dart';
import 'package:flutter_plain_application/components/layouts/spacing.dart';
import 'package:flutter_plain_application/components/scheme.dart';
import 'package:flutter_plain_application/widgets/image_wrapper.dart';
import 'package:flutter_touch_ripple/widgets/touch_ripple.dart';

class ClassCardLabel {
  const ClassCardLabel({
    required this.text,
    required this.color
  });

  final String text;
  final Color color;
}

class ClassCard extends StatelessWidget {
  const ClassCard({
    super.key,
    required this.title,
    required this.details,
    required this.imageURL,
    required this.price,
    required this.discountRate,
    this.labels = const []
  });

  final String title;
  final String details;
  final String imageURL;
  final int price;
  final double discountRate; // 0 ~ 1
  final List<ClassCardLabel> labels;

  Widget createLabelWrap() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Wrap(
        spacing: 5,
        runSpacing: 5,
        children: labels.map((label) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: label.color,
              borderRadius: BorderRadius.circular(1e10),
              boxShadow: [
                BoxShadow(
                  blurRadius: 3,
                  color: Colors.black.withAlpha(50)
                ),
              ],
            ),
            child: Text(label.text, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TouchRipple(
      onTap: () {},
      rippleBorderRadius: BorderRadius.circular(15),
      child: Container(
        width: 220,
        padding: EdgeInsets.all(Spacing.innerPadding) / 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: Spacing.rowItems,
          children: [
            AspectRatio(
              aspectRatio: 200 / 150,
              child: Stack(
                children: [
                  ImageWrapper(
                    radius: 15,
                    child: Image.network(
                      imageURL,
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover
                    ),
                  ),

                  if (labels.isNotEmpty) createLabelWrap()
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: Spacing.textColumn,
              children: [
                Text(title, style: TextStyle(fontWeight: FontWeight.bold), maxLines: 2, overflow: TextOverflow.ellipsis),
                Text(details, style: TextStyle(color: Scheme.current.foreground2), maxLines: 1, overflow: TextOverflow.ellipsis),
              ],
            ),
            Row(
              spacing: Spacing.rowItems,
              children: [
                Text(
                  "${(discountRate * 100).round()}%",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.redAccent)
                ),
                Text(
                  "$price원",
                  style: TextStyle(fontSize: 16, color: Scheme.current.foreground3)
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}