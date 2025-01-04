import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class FreenanceLocalizationsDelegate
    extends LocalizationsDelegate<FreenanceLocalizations> {
  // Singleton instance
  static final FreenanceLocalizationsDelegate instance =
      FreenanceLocalizationsDelegate();

  final localizations = FreenanceLocalizations();

  @override
  bool isSupported(Locale locale) {
    return FreenanceLocalizations.supportedLocales.contains(locale);
  }

  @override
  Future<FreenanceLocalizations> load(Locale locale) async {
    await localizations.load(locale);
    return Future.value(localizations);
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate old) {
    return false;
  }
}

abstract class LocalizationsSource {
  Future<String> provideSource(String path);
}

class AssetLocalizationSource implements LocalizationsSource {
  AssetLocalizationSource();

  @override
  Future<String> provideSource(String path) async {
    return await rootBundle.loadString(path);
  }
}

class FreenanceLocalizations {
  final Map<String, String> _localizedStrings = {};

  Future<void> load(Locale locale) async {
    // Load the language file
    final translationFile = await source.provideSource(
      'assets/translations/${locale.languageCode}.json',
    );

    // Decode the JSON
    final Map<String, dynamic> jsonMap = jsonDecode(translationFile);

    // Load the translations
    _localizedStrings.clear();
    jsonMap.forEach((key, value) {
      _localizedStrings[key] = value.toString();
    });
  }

  String translate(String key, [List<String>? args]) {
    var localizedString = _localizedStrings[key];
    if (localizedString == null) {
      debugPrint('Missing translation for key: $key');
    }
    if (args != null) {
      for (var i = 0; i < args.length; i++) {
        localizedString = localizedString?.replaceFirst('{}', args[i]);
      }
    }
    return localizedString ?? '<$key>';
  }

  // of getter
  static FreenanceLocalizations of(BuildContext context) {
    return Localizations.of<FreenanceLocalizations>(
      context,
      FreenanceLocalizations,
    )!;
  }

  static FreenanceLocalizationsDelegate get delegate =>
      FreenanceLocalizationsDelegate.instance;

  static List<Locale> supportedLocales = [
    const Locale('en', 'US'),
    const Locale('fr', 'FR'),
  ];

  static LocalizationsSource source = AssetLocalizationSource();
}

extension FreenanceLocalizationsExtension on BuildContext {
  String translate(String key, [List<String>? args]) =>
      FreenanceLocalizations.of(this).translate(key, args);
}
