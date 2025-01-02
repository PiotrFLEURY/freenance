import 'package:flutter/material.dart';
import 'package:freenance/model/objects/envelope.dart';
import 'package:freenance/view/confirmation/confirmation_dialog.dart';
import 'package:freenance/view/edition/edition_screen.dart';
import 'package:freenance/view/color_picker/color_picker.dart';
import 'package:freenance/view/envelope/envelope_screen.dart';

/// Wapper class to navigate between screens
/// Guarantees a consistent navigation experience
/// and a better code readability
class Voyager {
  /// Back to the previous screen
  static void pop(BuildContext context, [dynamic result]) {
    Navigator.of(context).pop(result);
  }

  /// Show the color picker screen
  static Future showColorPicker(
    BuildContext context,
    double red,
    double green,
    double blue,
  ) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ColorPicker(
          red: red,
          green: green,
          blue: blue,
        ),
      ),
    );
  }

  /// Show the edition screen
  /// Returns the new label and amount
  static Future<(String, double)?> pushEdition(
    BuildContext context,
    String title,
    String label,
    double amount,
  ) {
    return Navigator.of(context).push<(String, double)>(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return EditionScreen(
            title: title,
            label: label,
            amount: amount,
          );
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 1),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
      ),
    );
  }

  /// Show the envelope screen
  static Future pushEnvelope(BuildContext context, Envelope envelope) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EnvelopeScreen(
          envelopeId: envelope.id,
        ),
      ),
    );
  }

  /// Show a confirmation dialog
  /// Returns true if the user confirms
  static Future<bool> confirm(
    BuildContext context,
    String title,
    String message,
  ) {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return ConfirmationDialog(
          title: title,
          message: message,
          onCancel: () => Voyager.pop(context, false),
          onConfirm: () => Voyager.pop(context, true),
        );
      },
    ).then((value) => value ?? false);
  }
}
