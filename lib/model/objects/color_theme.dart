import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ColorTheme {
  final String mainColorHex;
  final Map<int, String> envelopeColors;

  ColorTheme({
    required this.mainColorHex,
    required this.envelopeColors,
  });

  factory ColorTheme.fromPrefs(SharedPreferences prefs) {
    final mainColorHex = prefs.getString('mainColor') ?? '0000FF';

    final prefsEnvelopeColors = prefs.getStringList('envelopeColors') ?? [];

    final Map<int, String> envelopeColors = Map.fromIterable(
      prefsEnvelopeColors,
      key: (e) {
        final parts = e.split(':');
        return int.parse(parts[0]);
      },
      value: (e) {
        final parts = e.split(':');
        return parts[1];
      },
    );

    return ColorTheme(
      mainColorHex: mainColorHex,
      envelopeColors: envelopeColors,
    );
  }

  void toPrefs(SharedPreferences prefs) {
    prefs.setString('mainColor', mainColorHex);

    final envelopeColorsList = envelopeColors.entries
        .map(
          (e) => '${e.key}:${e.value}',
        )
        .toList();
    prefs.setStringList('envelopeColors', envelopeColorsList);
  }

  Color get mainColor => _fromString(mainColorHex);

  Color envelopeColor(int envelopeId) {
    final color = envelopeColors[envelopeId];
    if (color == null) {
      return mainColor;
    }
    return _fromString(color);
  }

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

  (double, double, double) envelopeRgb(int envelopeId) {
    final color = envelopeColors[envelopeId];
    if (color == null) {
      return (0, 0, 0);
    }
    return asRgb(color);
  }

  ColorTheme copyWith({
    String? mainColorHex,
    Map<int, String>? envelopeColors,
  }) {
    return ColorTheme(
      mainColorHex: mainColorHex ?? this.mainColorHex,
      envelopeColors: envelopeColors ?? this.envelopeColors,
    );
  }
}
