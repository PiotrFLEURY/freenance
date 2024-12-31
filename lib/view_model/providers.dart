import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freenance/model/logic/freenance_db.dart';
import 'package:freenance/model/objects/budget.dart';
import 'package:freenance/model/logic/budget_repository.dart';
import 'package:freenance/model/objects/color_theme.dart';
import 'package:freenance/model/objects/envelope.dart';
import 'package:freenance/view/theme/colors.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'providers.g.dart';

@riverpod
FreenanceDb database(Ref ref) {
  return FreenanceDb()..init();
}

@riverpod
BudgetRepository budgetRepository(Ref ref) {
  final db = ref.watch(databaseProvider);
  return BudgetRepository(db);
}

@riverpod
Future<List<Budget>> budgetList(Ref ref) async {
  final repo = ref.watch(budgetRepositoryProvider);
  return repo.fetchBudgets();
}

@riverpod
Future<Envelope> envelope(Ref ref, int envelopeId) async {
  final budgetRepository = ref.watch(budgetRepositoryProvider);
  final envelope = await budgetRepository.fetchEnvelope(envelopeId);
  return envelope;
}

@riverpod
class ColorNotifier extends _$ColorNotifier {
  @override
  ColorTheme build() {
    final mainColor = defaultColorHex;
    return ColorTheme(
      mainColorHex: mainColor,
      envelopeColors: {},
    );
  }

  Future<void> refreshColorTheme() async {
    // Obtain shared preferences.
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    state = ColorTheme.fromPrefs(prefs);
  }

  void changeMainColor(double red, double green, double blue) async {
    // Convert the RGB values to a hexadecimal string.
    final newColor = rgbToHex(red, green, blue);

    // Obtain shared preferences.
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // Save the new color.
    await prefs.setString('mainColor', newColor);

    refreshColorTheme();
  }

  void changeEnvelopeColor(
    int envelopeId,
    double red,
    double green,
    double blue,
  ) async {
    // Convert the RGB values to a hexadecimal string.
    final newColor = rgbToHex(red, green, blue);

    // Obtain shared preferences.
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final currentTheme = ColorTheme.fromPrefs(prefs);

    // Update the color for the envelope.
    currentTheme.envelopeColors[envelopeId] = newColor;

    // Save the updated theme.
    currentTheme.toPrefs(prefs);

    refreshColorTheme();
  }

  String rgbToHex(double red, double green, double blue) {
    final int r = red.toInt();
    final int g = green.toInt();
    final int b = blue.toInt();
    return '${_toHex(r)}${_toHex(g)}${_toHex(b)}';
  }

  String _toHex(int value) {
    return value.toRadixString(16).padLeft(2, '0');
  }
}
