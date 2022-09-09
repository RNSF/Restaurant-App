import "package:google_maps/google_maps.dart";
import 'package:google_place/google_place.dart';

import '../../../key_data_constants.dart';

class PlaceSearch {
  final String placeTitle;
  final String placeId;
  final String apiKey = googleApiKey;

  PlaceSearch({this.placeTitle = "", this.placeId = ""});

  factory PlaceSearch.fromJson(Map<String, dynamic> json) {
    return PlaceSearch(
      placeTitle: json["description"],
      placeId: json["place_id"]
    );
  }

  factory PlaceSearch.fromAutoCompletePrediction(AutocompletePrediction autocompletePrediction) {
    if(autocompletePrediction.description is String && autocompletePrediction.placeId is String){
      return PlaceSearch(
        placeTitle: autocompletePrediction.description!,
        placeId: autocompletePrediction.placeId!,
      );
    }
    return PlaceSearch(
      placeTitle: "ERROR",
      placeId: "",
    );
  }

  Future<LatLng> getCoordinates() async {
    GooglePlace googlePlace = GooglePlace(apiKey, headers: {
      "Access-Control-Allow-Origin": "https://maps.googleapis.com",
      "Access-Control-Allow-Methods": "GET, POST",
      "Access-Control-Allow-Headers": "X-Requested-With"
    });
    DetailsResponse? result = await googlePlace.details.get(placeId);
    if(result != null && result.result != null && result.result!.geometry != null && result.result!.geometry!.location != null) {
      Location location = result.result!.geometry!.location!;
      return LatLng(location.lat, location.lng);
    }
    return LatLng(0, 0);

    /*
    http.Response response = await http.get(Uri(
      scheme: "https",
      host: "maps.googleapis.com",
      path: "/maps/api/place/details/json",
      queryParameters: {"place_id" : placeId, "key" : apiKey}
    ));

    Map<String, dynamic> json = convert.jsonDecode(response.body);
    Map<String, double> position = Map<String, double>.from(json["result"]["geometry"]["location"]);
    print(position);
    return LatLng(position["lat"], position["lng"]);
     */


  }
}