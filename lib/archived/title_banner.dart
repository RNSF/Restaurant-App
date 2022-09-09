import "package:flutter/material.dart";

import '../constants.dart';

class TitleBanner extends StatelessWidget {

  final String titleText;
  const TitleBanner({Key? key, this.titleText = ""}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.secondary,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 0.0),
        child: Center(
          child: Text(
            titleText,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: FontSize.largeHeader,
              fontWeight: FontWeight.bold,
              color: Palette.lightOne,
              shadows: <Shadow>[
                basicShadow
              ],
            ),
          ),
        ),
      ),
    );
  }

}