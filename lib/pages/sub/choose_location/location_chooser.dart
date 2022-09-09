

import 'package:flutter/cupertino.dart';
import 'package:restaurant_app/pages/sub/choose_location/place_search.dart';
import 'package:restaurant_app/pages/sub/choose_location/places_service.dart';
import "package:google_maps/google_maps.dart";
import '../../base/location_data.dart';

class LocationChooser with ChangeNotifier {
  LocationData? _selectedRestaurantData;
  PlacesService placesService = PlacesService();
  LatLng _selectedLocation = LatLng(49.2827, -123.1207);
  List<PlaceSearch> searchResults = [];
  PlaceSearch? _selectedPlace;

  set selectedRestaurantData(LocationData? newSelectedRestaurantData) {
    _selectedRestaurantData = newSelectedRestaurantData;
    notifyListeners();
  }
  LocationData? get selectedRestaurantData {
    return _selectedRestaurantData;
  }

  set selectedPlace(PlaceSearch? newSelectedPlace) {
    _selectedPlace = newSelectedPlace;
    searchResults.clear();
    notifyListeners();
  }
  PlaceSearch? get selectedPlace {
    return _selectedPlace;
  }

  void searchPlaces(String searchTerm) async {
    searchResults = await placesService.getAutocomplete(searchTerm);
    notifyListeners();
  }

  set selectedLocation(LatLng newSelectedLocation) {
    _selectedLocation = newSelectedLocation;
    notifyListeners();
  }

  LatLng get selectedLocation {
    return _selectedLocation;
  }
}