import 'package:flutter/material.dart';

import '../../constants.dart';

class StartButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  const StartButton({Key? key, required this.onPressed, this.text = ""}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Palette.lightOne),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        ),
        fixedSize: MaterialStateProperty.all<Size>(const Size(180, 50))
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Palette.accent,
          letterSpacing: 1.5,
          fontWeight: FontWeight.bold,
          fontSize: FontSize.smallHeader,
        )
      ),
    );
  }
}
