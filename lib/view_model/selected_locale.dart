import 'dart:ui';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'selected_locale.g.dart';

@riverpod
class SelectedLocale extends _$SelectedLocale {
  @override
  Locale? build() {
    return null;
  }

  Future<void> loadPreferedLocale() async {
    if (state != null) {
      return;
    }
    final preferences = await SharedPreferences.getInstance();
    final languageCode = preferences.getString('languageCode');
    if (languageCode != null) {
      state = Locale(languageCode);
    }
  }

  Future<void> changeLocale(String languageCode) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString('languageCode', languageCode);
    state = Locale(languageCode);
  }
}
