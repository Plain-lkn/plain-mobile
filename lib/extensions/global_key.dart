import 'package:flutter/material.dart';

extension GlobalKeyExtension on GlobalKey {
  RenderBox? get renderBox {
    return currentContext?.findRenderObject() as RenderBox?;
  }
}