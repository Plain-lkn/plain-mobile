import 'package:flutter/material.dart';
import 'package:flutter_plain_application/components/scheme.dart';

class UserProfile extends StatelessWidget {
  const UserProfile.offline({
    super.key,
    required this.size
  });

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Scheme.current.rearground,
        shape: BoxShape.circle,
      ),
    );
  }
}