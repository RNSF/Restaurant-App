import 'package:provider/provider.dart';
import 'package:restaurant_app/pages/sub/choose_location/place_search.dart';
import "package:flutter/material.dart";
import '../../../constants.dart';
import 'location_chooser.dart';

class LocationSearchBar extends StatelessWidget {

  final TextEditingController searchController;
  final LocationChooser locationChooserProvider;

  const LocationSearchBar({Key? key, required this.searchController, required this.locationChooserProvider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: const InputDecoration(
        icon: Icon(Icons.location_city),
        hintText: "Enter Address",
        fillColor: Palette.lightTwo,
        filled: true,
        suffixIcon: Icon(Icons.search),
      ),
      style: const TextStyle(
        color: Palette.darkOne,
      ),
      controller: searchController,
      onChanged: (String input) {
        locationChooserProvider.selectedPlace = null;
        locationChooserProvider.searchPlaces(input);
      },
      onSubmitted: (String input) async {
        if(locationChooserProvider.searchResults.isNotEmpty){
          PlaceSearch placeSearch = locationChooserProvider.searchResults[0];
          locationChooserProvider.selectedPlace = placeSearch;
          locationChooserProvider.selectedLocation = await placeSearch.getCoordinates();
        }
      },
    );
  }
}


class LocationSearchAutocomplete extends StatelessWidget {

  final List<PlaceSearch> searchPlaces;
  final LocationChooser locationChooserProvider;

  const LocationSearchAutocomplete({Key? key, required this.searchPlaces, required this.locationChooserProvider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LocationChooser locationChooserProvider = Provider.of<LocationChooser>(context);
    return ListView.builder(
      itemCount: searchPlaces.length,
      itemBuilder: (context, index) {
        return Container(
          color: Palette.lightTwo,
          child: ListTile(
            title: Text(
              searchPlaces[index].placeTitle,
              style: const TextStyle(
                fontSize: FontSize.body,
                color: Palette.darkOne,
              )
            ),
            onTap: () async {
              PlaceSearch placeSearch = searchPlaces[index];
              locationChooserProvider.selectedPlace = placeSearch;
              locationChooserProvider.selectedLocation = await placeSearch.getCoordinates();
            }
          ),
        );
      },
    );
  }
}