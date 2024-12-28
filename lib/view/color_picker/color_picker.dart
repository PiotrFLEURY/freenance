import 'package:flutter/material.dart';
import 'package:freenance/view/common/solid_button.dart';

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
        title: const Text('Choisir une couleur'),
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
            const Text('Rouge'),
            Slider(
              value: red,
              max: 255,
              onChanged: _onRedChanged,
            ),
            const Spacer(),
            const Text('Vert'),
            Slider(
              value: green,
              max: 255,
              onChanged: _onGreenChanged,
            ),
            const Spacer(),
            const Text('Bleu'),
            Slider(
              value: blue,
              max: 255,
              onChanged: _onBlueChanged,
            ),
            const Spacer(),
            SolidButton(
              text: 'Valider',
              action: () {
                Navigator.pop(
                  context,
                  (red, green, blue),
                );
              },
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
