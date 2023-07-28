import 'package:flutter/material.dart';

extension BaseTextStyle on TextStyle {
  static TextStyle baseSimilarText(Color color) {
    return TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: color);
  }

  static TextStyle baseTitleText(Color color) {
    return TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: color);
  }

  static TextStyle baseSimilarBoldText(Color color) {
    return TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: color);
  }
}

