//@JS()
//library jslocation;

import 'dart:math';
import "package:google_maps/google_maps.dart";
import "dart:html";
import "dart:ui" as ui;
import "package:flutter/material.dart";
import "package:provider/provider.dart";
import '../../base/location_data.dart';
import 'location_chooser.dart';


class GoogleMap extends StatelessWidget {
  final String htmlId = "774636"; //this is arbitrary
  final Map<int, LocationData> locationDatas;
  const GoogleMap({Key? key, required this.locationDatas}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    //TODO get map location to update when selected location updates
    LocationChooser locationChooserProvider = Provider.of<LocationChooser>(context);

    ui.platformViewRegistry.registerViewFactory(htmlId, (int viewId) {
      final LatLng latLng = locationChooserProvider.selectedLocation;

      final mapOptions = MapOptions()
        ..zoom = 10
        ..center = latLng
        ..disableDefaultUI = true;

      final DivElement element = DivElement()
        ..id = htmlId
        ..style.width = "100%"
        ..style.height = "100%"
        ..style.border = "none";

      final GMap map = GMap(element, mapOptions);

      for(final LocationData locationData in locationDatas.values){
         Marker marker = Marker(MarkerOptions()
            ..map = map
            ..position = LatLng(locationData.mapPosition.lat, locationData.mapPosition.lng)
            ..clickable = true
         );
         marker.onClick.listen((event) => {
           locationChooserProvider.selectedRestaurantData = locationData,
           locationChooserProvider.selectedLocation = LatLng(locationData.mapPosition.lat, locationData.mapPosition.lng),
         });
      }

      map.moveCamera(CameraOptions()
        ..center = locationChooserProvider.selectedLocation
      );

      return element;
    });

    return HtmlElementView(viewType: htmlId);
  }
}


//https://stackoverflow.com/questions/54138750/total-distance-calculation-from-latlng-list
double calculateDistance(LatLng start, LatLng end) {
  double p = 0.017453292519943295;
  var a = 0.5 - cos((end.lat - start.lat) * p)/2 +
        cos(start.lat * p) * cos(end.lat * p) *
        (1 - cos((end.lng - start.lng) * p))/2;
  return 12742 * asin(sqrt(a));
}

Map<LocationData, double> findClosestRestaurants(List<LocationData> locationDatas, LatLng position) {
  Map<LocationData, double> locationDistances = {};

  for(var locationData in locationDatas) {
    locationDistances[locationData] = calculateDistance(position, LatLng(locationData.mapPosition.lat, locationData.mapPosition.lng));
  }
  Map<LocationData, double> orderedLocations = {};

  while(locationDistances.isNotEmpty){
    double shortestDistance = double.infinity;
    LocationData? closestLocation;
    locationDistances.forEach((locationData, distance) {
      if(shortestDistance > distance){
        shortestDistance = distance;
        closestLocation = locationData;
      }
    });
    if(closestLocation != null){
      locationDistances.remove(closestLocation);
      orderedLocations[closestLocation!] = shortestDistance;
    }
  }

  return orderedLocations;
}