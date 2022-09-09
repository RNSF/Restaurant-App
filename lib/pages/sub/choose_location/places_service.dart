import '../../../key_data_constants.dart';
import "place_search.dart";
import "package:google_place/google_place.dart";

class PlacesService {

  final String apiKey = googleApiKey;


  Future<List<PlaceSearch>> getAutocomplete(String search) async {
    if(search == "") { return []; }

    GooglePlace googlePlace = GooglePlace(apiKey, headers: {
      "Access-Control-Allow-Origin": "https://maps.googleapis.com",
      "Access-Control-Allow-Methods": "GET, POST",
      "Access-Control-Allow-Headers": "X-Requested-With"
    });
    dynamic result = await googlePlace.autocomplete.get(search);
    if(result != null && result.predictions != null) {
      List<AutocompletePrediction> resultsList = result.predictions as List<AutocompletePrediction>;
      List<PlaceSearch> placeSearches = [];
      for(var element in resultsList) {
        placeSearches.add(PlaceSearch.fromAutoCompletePrediction(element));
      }
      return placeSearches;
    }
    return [];
    /*
    http.Response response = await http.get(Uri(
      scheme: "https",
      host: "maps.googleapis.com",
      path: "/maps/api/place/autocomplete/json",
      queryParameters: {"input" : search, "types" : "geocode", "key": apiKey }
    ));
    Map<String, dynamic> json = convert.jsonDecode(response.body);
    List<dynamic> jsonResults = json["predictions"] as List;
    List<PlaceSearch> placeSearches = [];

    return placeSearches;
     */

  }
}