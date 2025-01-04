import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freenance/view/color_picker/color_picker.dart';
import 'package:freenance/view/localization/freenance_localization.dart';
import 'package:freenance/view_model/providers.dart';
import 'package:package_info_plus/package_info_plus.dart';

class FreenanceDrawer extends ConsumerStatefulWidget {
  const FreenanceDrawer({super.key});

  @override
  ConsumerState<FreenanceDrawer> createState() => _FreenanceDrawerState();
}

class _FreenanceDrawerState extends ConsumerState<FreenanceDrawer> {
  String version = '';

  @override
  void initState() {
    super.initState();
    fetchVersion().then((value) {
      setState(() {
        version = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final mainColor = ref.watch(colorNotifierProvider).mainColor;
    final selectedLocale = ref.watch(selectedLocaleProvider);
    return Column(
      children: [
        DrawerHeader(
          decoration: BoxDecoration(
            color: mainColor,
          ),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  context.translate('app_name'),
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
                Text(
                  version,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
        ListTile(
          title: Text(
            context.translate(
              'drawer_menu_home',
            ),
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: Text(
            context.translate('drawer_menu_color_theme'),
          ),
          onTap: () => _changeColorTheme(context),
        ),
        ListTile(
          title: Text(
            context.translate('drawer_menu_about'),
          ),
          onTap: () {
            showAboutDialog(
              context: context,
              applicationIcon: FlutterLogo(),
              applicationName: 'Freenance',
              applicationVersion: version,
              applicationLegalese: '© 2024 Piotr FLEURY',
            );
          },
        ),
        Divider(),
        Text(
          context.translate('drawer_menu_language'),
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
        ListTile(
          leading: selectedLocale?.languageCode == 'fr'
              ? const Icon(
                  Icons.check,
                  size: 16,
                )
              : SizedBox(width: 16),
          title: Text(
            context.translate('drawer_menu_french'),
          ),
          onTap: () {
            ref.read(selectedLocaleProvider.notifier).changeLocale('fr');
          },
        ),
        ListTile(
          leading: selectedLocale?.languageCode == 'en'
              ? const Icon(
                  Icons.check,
                  size: 16,
                )
              : SizedBox(width: 16),
          title: Text(
            context.translate('drawer_menu_english'),
          ),
          onTap: () {
            ref.read(selectedLocaleProvider.notifier).changeLocale('en');
          },
        ),
      ],
    );
  }

  Future<String> fetchVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  Future<void> _changeColorTheme(BuildContext context) async {
    final colorTheme = ref.read(colorNotifierProvider);
    final mainColorRgb = colorTheme.asRgb(colorTheme.mainColorHex);
    final (double, double, double)? rgb =
        await Navigator.push<(double, double, double)>(
      context,
      MaterialPageRoute(
        builder: (context) => ColorPicker(
          red: mainColorRgb.$1,
          green: mainColorRgb.$2,
          blue: mainColorRgb.$3,
        ),
      ),
    );

    if (rgb != null) {
      // Change the color theme.
      final colorNotifier = ref.read(colorNotifierProvider.notifier);
      colorNotifier.changeMainColor(rgb.$1, rgb.$2, rgb.$3);
    } else {
      // Reset the color theme.
      final colorNotifier = ref.read(colorNotifierProvider.notifier);
      colorNotifier.resetMainColor();
    }
  }
}
