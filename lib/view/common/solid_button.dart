import 'package:flutter/material.dart';
import 'package:freenance/view/theme/colors.dart';

class SolidButton extends StatefulWidget {
  const SolidButton({
    super.key,
    required this.text,
    required this.action,
  });

  final String text;
  final void Function() action;

  @override
  State<SolidButton> createState() => _SolidButtonState();
}

class _SolidButtonState extends State<SolidButton> {
  bool _pressed = false;

  _onPress() {
    setState(() {
      _pressed = true;
    });
  }

  _onRelease() {
    setState(() {
      _pressed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.action,
      onTapDown: (_) => _onPress(),
      onTapUp: (_) => _onRelease(),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: mainColor,
          borderRadius: BorderRadius.circular(8),
          boxShadow: _pressed
              ? null
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.2),
                    blurRadius: 16,
                    offset: Offset(0, 8),
                  ),
                ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 24,
          ),
          child: Text(
            widget.text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
