import "package:flutter/material.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";

enum Ammenities {
  outdoorSeats,
  highTopSeats,
  counterSeats,
  standardSeats,
  bar,
}

IconData? getAmmenityIcon(Ammenities ammenity) {
  final Map<Ammenities, IconData> icons = {
    Ammenities.outdoorSeats : Icons.umbrella,
    Ammenities.bar : FontAwesomeIcons.beerMugEmpty,
  };
  return icons[ammenity];
}

String? getAmmenityName(Ammenities ammenity) {
  final Map<Ammenities, String> names = {
    Ammenities.outdoorSeats : "Outdoor Dining",
    Ammenities.bar : "Bar",
  };
  return names[ammenity];
}