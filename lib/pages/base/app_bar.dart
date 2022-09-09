import 'package:flutter/material.dart';
import "package:flutter_svg/flutter_svg.dart";
import "package:restaurant_app/constants.dart";

class MainAppBar extends AppBar{

  final Color mainColor;
  final Color logoColor;

  MainAppBar({Key? key, required this.mainColor, required this.logoColor}) : super(
    title: SvgPicture.asset('assets/images/keg-logo.svg', height: 50, width: 50, color: logoColor),
    centerTitle: true,
    toolbarHeight: 60,
    backgroundColor: mainColor,
    key: key,
  );
}


class ReturnBottomNavigation extends StatelessWidget {
  final Widget? child;
  final Function()? alternativeOnPressed;

  const ReturnBottomNavigation({Key? key, this.child, this.alternativeOnPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 4,
              blurRadius: 15,
              offset: const Offset(0, 0),
            ),
          ]
        ),
        child: AppBar(
          backgroundColor: Palette.lightTwo,
          leading: IconButton(
            onPressed: alternativeOnPressed ?? () { Navigator.pop(context); },
            icon: const Icon(Icons.arrow_back, color: Palette.darkOne)
          ),
          centerTitle: true,
          title: child,
        ),
      ),
    );
  }

}

class BasicDivider extends StatelessWidget {

  const BasicDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0),
      child: Divider(
        color: Palette.lightTwo,
        thickness: 4,
      ),
    );
  }
}

class BarButton extends StatelessWidget {
  final Function onPressed;
  final String text;
  final bool disabled;
  final Color backgroundColor;
  final Color textColor;
  final Color disabledBackgroundColor;
  final Color disabledTextColor;
  final double fontSize;

  const BarButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.disabled = false,
    this.backgroundColor = Palette.accent,
    this.textColor = Palette.lightOne,
    this.disabledBackgroundColor = Palette.lightTwo,
    this.disabledTextColor = Palette.darkOne,
    this.fontSize = FontSize.body,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: disabled ? null : () => onPressed(),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(disabled ? disabledBackgroundColor : backgroundColor),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          text,
          style: TextStyle(
            color: disabled ? disabledTextColor : textColor,
            letterSpacing: 1.5,
            fontWeight: FontWeight.bold,
            fontSize: fontSize,
          )
        ),
      ),
    );
  }
}