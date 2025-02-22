import 'package:flutter/material.dart';
import 'package:flutter_touch_ripple/widgets/touch_ripple.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: TouchRipple(
        onTap: () {},
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Text("Hello, World!"),
        ),
      ),
    );
  }
}