import 'package:flutter/material.dart';

class ColorManager {
  static Color primary = HexColor.fromHex('#03091c');
  static Color secondary = HexColor.fromHex('#262f4b');
  static Color white = HexColor.fromHex('#ffffff');
  static Color pink = HexColor.fromHex('#ea887b');
  static Color purple = HexColor.fromHex('#ce92e3');
  static Color black60 = HexColor.fromHex('#737d9c');
  static Color black = HexColor.fromHex('#5b6279');
  static Color grey = HexColor.fromHex('#d9d9d9');
  static Color grey60 = HexColor.fromHex('#a9a9ac');
  static Color black30 = HexColor.fromHex('#8293a8');
}

extension HexColor on Color {
  static Color fromHex(String hexColorString) {
    hexColorString = hexColorString.replaceAll('#', '');
    if (hexColorString.length == 6) {
      hexColorString = 'FF$hexColorString';
    }

    return Color(int.parse(hexColorString, radix: 16));
  }
}
