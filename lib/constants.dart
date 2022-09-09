import "package:flutter/material.dart";

class FontSize {
  static const double largeHeader = 40;
  static const double mediumHeader = 30;
  static const double smallHeader = 20;
  static const double body = 13;
}

class Palette {
  static const Color lightOne = Colors.white;
  static const Color lightTwo = Color(0xffCDCDCD);
  static const Color accent = Color(0xffD11242);
  static const Color darkTwo = Color(0xff707580);
  static const Color darkOne = Color(0xff333436);
  static const Color red = Color(0xffD11242);
  static const Color green = Color(0xff307141);
}

final basicShadow = Shadow(
  offset: const Offset(0.0, 2.0),
  blurRadius: 3.0,
  color: Colors.black.withOpacity(0.8),
);