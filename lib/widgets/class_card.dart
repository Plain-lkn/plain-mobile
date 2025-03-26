import 'package:flutter/material.dart';
import 'package:flutter_plain_application/components/layouts/spacing.dart';
import 'package:flutter_plain_application/components/scheme.dart';
import 'package:flutter_plain_application/widgets/image_wrapper.dart';
import 'package:flutter_touch_ripple/widgets/touch_ripple.dart';

class ClassCard extends StatelessWidget {
  const ClassCard({
    super.key,
    required this.title,
    required this.details,
    required this.imageURL,
    required this.price,
    required this.discountRate
  });

  final String title;
  final String details;
  final String imageURL;
  final int price;
  final double discountRate; // 0 ~ 1

  @override
  Widget build(BuildContext context) {
    return TouchRipple(
      onTap: () {},
      rippleBorderRadius: BorderRadius.circular(15),
      child: Container(
        width: 220,
        padding: EdgeInsets.all(Spacing.innerPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: Spacing.rowItems,
          children: [
            AspectRatio(
              aspectRatio: 200 / 150,
              child: ImageWrapper(
                radius: 15,
                child: Image.network(
                  imageURL,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover
                ),
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