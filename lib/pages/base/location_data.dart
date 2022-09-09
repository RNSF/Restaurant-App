import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/pages/sub/ammenities.dart';

class Coordinates {
  final double lat;
  final double lng;
  Coordinates({required this.lat, required this.lng});
}

class LocationData {
  final String name;
  final int id;
  final Coordinates mapPosition;
  final String address;
  Map<String, DateTimeRange> operatingHours;
  final String phoneNumber;
  final List<Ammenities> ammenities;
  final String photoUrl;

  LocationData({
    required this.id,
    required this.mapPosition,
    required this.photoUrl,
    this.name = "The Keg - Unknown Location",
    this.address = "Super Street, V5D DJ2",
    this.phoneNumber = "778-888-8888",
    this.operatingHours = const {}, //temp, need to find fix for const
    this.ammenities = const [],
  }) {
    if(operatingHours.isEmpty){
      operatingHours = <String, DateTimeRange>{
        "Monday" : DateTimeRange(start: DateTime(1, 1, 1, 16, 0), end: DateTime(1, 1, 1, 23, 0)),
        "Tuesday" : DateTimeRange(start: DateTime(1, 1, 1, 16, 0), end: DateTime(1, 1, 1, 23, 0)),
        "Wednesday" : DateTimeRange(start: DateTime(1, 1, 1, 16, 0), end: DateTime(1, 1, 1, 23, 0)),
        "Thursday" : DateTimeRange(start: DateTime(1, 1, 1, 16, 0), end: DateTime(1, 1, 1, 23, 0)),
        "Friday" : DateTimeRange(start: DateTime(1, 1, 1, 16, 0), end: DateTime(1, 1, 1, 24, 0)),
        "Saturday" : DateTimeRange(start: DateTime(1, 1, 1, 15, 30), end: DateTime(1, 1, 1, 24, 0)),
        "Sunday" : DateTimeRange(start: DateTime(1, 1, 1, 15, 30), end: DateTime(1, 1, 1, 22, 0)),
      };
    }

  }

  bool get open {
    DateTime now = DateTime.now();
    String dayOfWeek = DateFormat('EEEE').format(now);
    if(operatingHours[dayOfWeek] == null) { return false; }
    return (
      operatingHours[dayOfWeek]!.start.compareTo(DateTime(1, 1, 1, now.hour, now.minute)) < 0
      &&  operatingHours[dayOfWeek]!.end.compareTo(DateTime(1, 1, 1, now.hour, now.minute)) > 0
    );
  }
}

final Map<int, LocationData> locationDatas = {
    0 : LocationData(
      name: "Burnaby",
      id: 0,
      mapPosition: Coordinates(lat: 49.259991, lng: -123.003036),
      address: "4510 Still Creek Ave, Burnaby, BC V5C 0B5",
      phoneNumber: "+1 604 294 4626",
      ammenities: [Ammenities.bar, Ammenities.outdoorSeats],
      photoUrl: "http://www.kegsteakhouse.com/sites/default/files/styles/location_large/public/2019-08/Burnaby.jpg?itok=_1hg6ocu",
    ),
    1 : LocationData(
      name: "Dunsmuir",
      id: 1,
      mapPosition: Coordinates(lat: 49.283360, lng: -123.116379),
      address: "688 Dunsmuir St, Vancouver, BC V6B 1N3",
      phoneNumber: "+1 604 685 7502",
      photoUrl: "http://www.kegsteakhouse.com/sites/default/files/styles/location_large/public/2019-03/description_1920x700_0012_Dunsmuir.jpg?itok=cBb7vnb-",
      operatingHours: <String, DateTimeRange>{
        "Monday" : DateTimeRange(start: DateTime(1, 1, 1, 11, 30), end: DateTime(1, 1, 1, 22, 30)),
        "Tuesday" : DateTimeRange(start: DateTime(1, 1, 1, 11, 30), end: DateTime(1, 1, 1, 22, 30)),
        "Wednesday" : DateTimeRange(start: DateTime(1, 1, 1, 11, 30), end: DateTime(1, 1, 1, 22, 30)),
        "Thursday" : DateTimeRange(start: DateTime(1, 1, 1, 11, 30), end: DateTime(1, 1, 1, 22, 30)),
        "Friday" : DateTimeRange(start: DateTime(1, 1, 1, 11, 30), end: DateTime(1, 1, 1, 23, 30)),
        "Saturday" : DateTimeRange(start: DateTime(1, 1, 1, 15, 0), end: DateTime(1, 1, 1, 23, 30)),
        "Sunday" : DateTimeRange(start: DateTime(1, 1, 1, 15, 0), end: DateTime(1, 1, 1, 22, 30)),
      },
    ),
    2 : LocationData(
      name: "Alberni",
      id: 2,
      mapPosition: Coordinates(lat: 49.285960, lng: -123.124160),
      address: "1121 Alberni Street, Vancouver, British Columbia V6E 4T9",
      phoneNumber: "+1 604 685 4388",
      photoUrl: "http://www.kegsteakhouse.com/sites/default/files/styles/location_large/public/2019-03/description_1920x700_0011_Alberni.jpg?itok=Lo2g1pzk",
      operatingHours: <String, DateTimeRange>{
        "Monday" : DateTimeRange(start: DateTime(1, 1, 1, 15, 0), end: DateTime(1, 1, 1, 23, 0)),
        "Tuesday" : DateTimeRange(start: DateTime(1, 1, 1, 15, 0), end: DateTime(1, 1, 1, 23, 0)),
        "Wednesday" : DateTimeRange(start: DateTime(1, 1, 1, 15, 0), end: DateTime(1, 1, 1, 23, 0)),
        "Thursday" : DateTimeRange(start: DateTime(1, 1, 1, 15, 0), end: DateTime(1, 1, 1, 23, 0)),
        "Friday" : DateTimeRange(start: DateTime(1, 1, 1, 15, 0), end: DateTime(1, 1, 1, 24, 0)),
        "Saturday" : DateTimeRange(start: DateTime(1, 1, 1, 15, 0), end: DateTime(1, 1, 1, 24, 0)),
        "Sunday" : DateTimeRange(start: DateTime(1, 1, 1, 15, 0), end: DateTime(1, 1, 1, 23, 0)),
      },
    ),
  };