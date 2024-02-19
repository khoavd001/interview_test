import 'package:flutter/material.dart';

class ColorsApp {
  static Color noteText = HexColor.fromHex('#616161');
  static Color selected = HexColor.fromHex('#FE724C');
  static Color ingredientText = HexColor.fromHex('#616161');
  static Color noteColor = HexColor.fromHex('#F7F7F7');
}

extension HexColor on Color {
  static Color fromHex(String hex) {
    hex = hex.replaceAll('#', '');
    if (hex.length == 6) {
      hex = "FF" + hex; // 8 char with opacity 100%
    }
    return Color(int.parse(hex, radix: 16));
  }
}
