import 'package:flutter/services.dart';

final class HapticFeedbackUtil {
  static void warning() {
    HapticFeedback.vibrate();
    Future.delayed(Duration(milliseconds: 200), HapticFeedback.vibrate);
  }
}