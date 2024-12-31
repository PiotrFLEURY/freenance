import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:freenance/model/objects/color_theme.dart';
import 'package:freenance/view/theme/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('ColorTheme', () {
    late SharedPreferences prefs;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      prefs = await SharedPreferences.getInstance();
    });

    test('should load default values when no preferences are set', () {
      final colorTheme = ColorTheme.fromPrefs(prefs);

      expect(colorTheme.mainColorHex, defaultColorHex);
      expect(colorTheme.envelopeColors, {});
    });

    test('should save and load mainColorHex', () async {
      const mainColorHex = 'ff0000';
      final colorTheme =
          ColorTheme(mainColorHex: mainColorHex, envelopeColors: {});

      colorTheme.toPrefs(prefs);

      final loadedColorTheme = ColorTheme.fromPrefs(prefs);

      expect(loadedColorTheme.mainColorHex, mainColorHex);
    });

    test('should save and load envelopeColors', () async {
      final envelopeColors = {1: '00ff00', 2: '0000ff'};
      final colorTheme =
          ColorTheme(mainColorHex: 'ff0000', envelopeColors: envelopeColors);

      colorTheme.toPrefs(prefs);

      final loadedColorTheme = ColorTheme.fromPrefs(prefs);

      expect(loadedColorTheme.envelopeColors, envelopeColors);
    });

    test('should return mainColor when envelopeColor is not found', () {
      final colorTheme = ColorTheme(mainColorHex: 'ff0000', envelopeColors: {});

      final envelopeColor = colorTheme.envelopeColor(1);

      expect(envelopeColor, colorTheme.mainColor);
    });

    test('should return correct envelopeColor when found', () {
      final envelopeColors = {1: '00ff00'};
      final colorTheme =
          ColorTheme(mainColorHex: 'ff0000', envelopeColors: envelopeColors);

      final envelopeColor = colorTheme.envelopeColor(1);

      expect(envelopeColor, Color(0xff00ff00));
    });

    test('should return correct RGB values for mainColor', () {
      final colorTheme = ColorTheme(mainColorHex: 'ff0000', envelopeColors: {});

      final rgb = colorTheme.asRgb('ff0000');

      expect(rgb, (255.0, 0.0, 0.0));
    });

    test('should return correct RGB values for envelopeColor', () {
      final envelopeColors = {1: '00ff00'};
      final colorTheme =
          ColorTheme(mainColorHex: 'ff0000', envelopeColors: envelopeColors);

      final rgb = colorTheme.envelopeRgb(1);

      expect(rgb, (0.0, 255.0, 0.0));
    });

    test('should return (0, 0, 0) when envelopeColor is not found', () {
      final colorTheme = ColorTheme(mainColorHex: 'ff0000', envelopeColors: {});

      final rgb = colorTheme.envelopeRgb(1);

      expect(rgb, (0.0, 0.0, 0.0));
    });

    test('should copy with new values', () {
      final colorTheme =
          ColorTheme(mainColorHex: 'ff0000', envelopeColors: {1: '00ff00'});

      final newColorTheme = colorTheme
          .copyWith(mainColorHex: '0000ff', envelopeColors: {2: 'ff00ff'});

      expect(newColorTheme.mainColorHex, '0000ff');
      expect(newColorTheme.envelopeColors, {2: 'ff00ff'});
    });

    test('should copy with same values when no new values are provided', () {
      final colorTheme =
          ColorTheme(mainColorHex: 'ff0000', envelopeColors: {1: '00ff00'});

      final newColorTheme = colorTheme.copyWith();

      expect(newColorTheme.mainColorHex, 'ff0000');
      expect(newColorTheme.envelopeColors, {1: '00ff00'});
    });
  });
}
