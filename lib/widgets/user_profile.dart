import 'package:flutter/material.dart' hide Icons;
import 'package:flutter_plain_application/components/icons.dart';
import 'package:flutter_plain_application/components/scheme.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UserProfile extends StatelessWidget {
  const UserProfile.offline({
    super.key,
    required this.size
  });

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(size / 5),
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Scheme.current.rearground,
        shape: BoxShape.circle,
      ),
      child: SvgPicture.asset(Icons.userFilled, color: Scheme.current.foreground3),
    );
  }
}