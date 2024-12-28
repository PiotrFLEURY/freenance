import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freenance/view/color_picker/color_picker.dart';
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
                  'Freenance',
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
          title: const Text('Mes budgets'),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: const Text('Thème'),
          onTap: () => _changeColorTheme(context),
        ),
        ListTile(
          title: const Text('A propos'),
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
    }
  }
}
