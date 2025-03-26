import 'package:flutter/material.dart';
import 'package:flutter_plain_application/components/layouts/spacing.dart';
import 'package:flutter_plain_application/components/scheme.dart';
import 'package:flutter_plain_application/extensions/color.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_touch_ripple/widgets/touch_ripple.dart';

class CategoryButton extends StatelessWidget {
  const CategoryButton({
    super.key,
    required this.isSelected,
    required this.text,
    this.imgIcon,
    this.svgIcon,
    this.onTap
  });

  final bool isSelected;
  final String text;
  final String? imgIcon;
  final String? svgIcon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final background = isSelected ? Scheme.current.background.reversed : Scheme.current.rearground;
    final foreground = isSelected ? Scheme.current.foreground.reversed : Scheme.current.foreground;

    return TouchRipple(
      onTap: !isSelected ? onTap : null,
      rippleBorderRadius: BorderRadius.circular(1e10),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(1e10),
        ),
        child: Row(
          spacing: Spacing.rowItems,
          children: [
            if (imgIcon != null)
              Image.asset(imgIcon!, width: 18),

            if (svgIcon != null)
              SvgPicture.asset(svgIcon!, width: 18, color: foreground),

            Text(text, style: TextStyle(color: foreground, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}