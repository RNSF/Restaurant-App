import "package:flutter/material.dart";
import "package:restaurant_app/pages/main/background.dart";

import '../../constants.dart';

class MainPageBase extends StatelessWidget {
  final String title;
  final ImageProvider backgroundImage;
  final Widget child;
  const MainPageBase({Key? key, required this.backgroundImage, required this.child , this.title = ""}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Background(backgroundImage: AssetImage("assets/images/landing_background.jpg")),
          SafeArea(
            child: Column(
              children : [
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        title,
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
                ),
                Expanded(
                  flex: 3,
                  child: child,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}