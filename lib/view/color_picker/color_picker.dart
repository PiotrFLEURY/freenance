import 'package:flutter/material.dart';
import 'package:freenance/view/common/solid_button.dart';
import 'package:freenance/view/localization/freenance_localization.dart';

class ColorPicker extends StatefulWidget {
  const ColorPicker({
    super.key,
    required this.red,
    required this.green,
    required this.blue,
  });

  final double red;
  final double green;
  final double blue;

  @override
  State<ColorPicker> createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  double red = 0;
  double green = 0;
  double blue = 255;
  Color actualColor = Colors.blue;

  void _onRedChanged(double value) {
    setState(() {
      red = value;
    });
    _updateColor();
  }

  void _onGreenChanged(double value) {
    setState(() {
      green = value;
    });
    _updateColor();
  }

  void _onBlueChanged(double value) {
    setState(() {
      blue = value;
    });
    _updateColor();
  }

  void _updateColor() {
    setState(() {
      actualColor = Color.fromRGBO(
        red.toInt(),
        green.toInt(),
        blue.toInt(),
        1,
      );
    });
  }

  void _resetDefaultColor() {
    Navigator.pop(
      context,
      null,
    );
  }

  @override
  void initState() {
    super.initState();
    red = widget.red;
    green = widget.green;
    blue = widget.blue;
    _updateColor();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.translate('color_picker_title')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Spacer(),
            // Show the actual color
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.3,
              color: actualColor,
            ),
            const Spacer(),
            Text(context.translate('color_picker_red_color')),
            Slider(
              value: red,
              max: 255,
              onChanged: _onRedChanged,
            ),
            const Spacer(),
            Text(context.translate('color_picker_green_color')),
            Slider(
              value: green,
              max: 255,
              onChanged: _onGreenChanged,
            ),
            const Spacer(),
            Text(context.translate('color_picker_blue_color')),
            Slider(
              value: blue,
              max: 255,
              onChanged: _onBlueChanged,
            ),
            const Spacer(),
            Row(
              children: [
                Flexible(
                  child: SolidButton(
                    text: context.translate('color_picker_reset_button'),
                    action: _resetDefaultColor,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: SolidButton(
                    text: context.translate('color_picker_validate_button'),
                    action: () {
                      Navigator.pop(
                        context,
                        (red, green, blue),
                      );
                    },
                  ),
                ),
              ],
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
