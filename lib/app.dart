import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freenance/view/home/home_screen.dart';
import 'package:freenance/view/localization/freenance_localization.dart';
import 'package:freenance/view_model/providers.dart';

class Freenance extends ConsumerWidget {
  const Freenance({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(selectedLocaleProvider);
    ref.read(selectedLocaleProvider.notifier).loadPreferedLocale();
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        FreenanceLocalizations.delegate,
      ],
      supportedLocales: FreenanceLocalizations.supportedLocales,
      locale: locale,
      home: HomeScreen(),
    );
  }
}
