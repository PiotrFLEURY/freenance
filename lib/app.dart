import 'package:flutter/material.dart';
import 'package:freenance/view/home/home_screen.dart';

class Freenance extends StatelessWidget {
  const Freenance({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}
