import 'package:flutter/material.dart';

class ColorTheme {
  final String mainColorHex;

  ColorTheme({
    required this.mainColorHex,
  });

  Color get mainColor => _fromString(mainColorHex);

  Color _fromString(String radixString) {
    final r16 = radixString.substring(0, 2);
    final g16 = radixString.substring(2, 4);
    final b16 = radixString.substring(4, 6);

    final r = int.parse(r16, radix: 16);
    final g = int.parse(g16, radix: 16);
    final b = int.parse(b16, radix: 16);

    return Color.fromRGBO(r, g, b, 1);
  }

  (double, double, double) asRgb(String radixString) {
    final r16 = radixString.substring(0, 2);
    final g16 = radixString.substring(2, 4);
    final b16 = radixString.substring(4, 6);

    final r = int.parse(r16, radix: 16);
    final g = int.parse(g16, radix: 16);
    final b = int.parse(b16, radix: 16);

    return (r.toDouble(), g.toDouble(), b.toDouble());
  }
}
