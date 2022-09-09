import "package:flutter/material.dart";
import '../../base/location_data.dart';
import "google_map.dart";
import "package:restaurant_app/constants.dart";
import "package:restaurant_app/pages/base/app_bar.dart";
import "package:provider/provider.dart";
import 'location_chooser.dart';
import 'location_picker.dart';
import 'location_search.dart';

class ChooseLocationPage extends StatefulWidget {
  const ChooseLocationPage({Key? key}) : super(key: key);

  @override
  _ChooseLocationPageState createState() => _ChooseLocationPageState();
}

class _ChooseLocationPageState extends State<ChooseLocationPage> {


  TextEditingController searchController = TextEditingController();
  List<int> closestRestaurantIds = [];


  @override
  Widget build(BuildContext context) {
    LocationChooser locationChooserProvider = Provider.of<LocationChooser>(context);

    if(locationChooserProvider.selectedPlace != null){
      searchController.text = locationChooserProvider.selectedPlace!.placeTitle;
    }

    return Scaffold(
      appBar: MainAppBar(mainColor: Palette.darkOne, logoColor: Palette.lightOne),
      bottomNavigationBar: ReturnBottomNavigation(
        child: BarButton(
          text: "Select Location",
          disabled: locationChooserProvider.selectedRestaurantData == null,
          onPressed: () {
            LocationData data = locationChooserProvider.selectedRestaurantData!;
            locationChooserProvider.selectedRestaurantData = null;
            locationChooserProvider.selectedPlace = null;
            Navigator.pop(context, data);
          },
        ),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: LocationSearchBar(searchController: searchController, locationChooserProvider: locationChooserProvider)
          ),
          SizedBox(
            height: 300,
            child: Stack(
              children: [
                GoogleMap(
                  locationDatas: locationDatas,
                ),
                SizedBox(
                  height: 300,
                  child: LocationSearchAutocomplete(searchPlaces: locationChooserProvider.searchResults, locationChooserProvider: locationChooserProvider),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: LocationPicker(locationDistances: findClosestRestaurants(
                locationDatas.values.toList(),
                locationChooserProvider.selectedLocation,
              ), locationChooserProvider: locationChooserProvider,),
            ),
          ),
        ],
      ),
    );
  }
}



