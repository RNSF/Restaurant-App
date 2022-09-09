import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final ImageProvider backgroundImage;
  const Background({Key? key, required this.backgroundImage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: backgroundImage,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/vignette.png"),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}

