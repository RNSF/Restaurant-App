class CurrentLocationData {
  final int table;
  final String restuarantName;
  final int restaurantId;

  const CurrentLocationData({this.table = 0, this.restaurantId = 0, this.restuarantName = "Nameless Resataurant"});
}

/*
class TableData {
  int id = -1;
  String restaurant = "";


  Future<void> getData() async {
    try{
      String json_string = await rootBundle.rootBundle.loadString("assets/data/table_data.json");
      Map<String, dynamic> json_data = jsonDecode(json_string);
      id = json_data["table"];
      restaurant = json_data["restaurant"];
      print("table id: $id");
    }
    catch (e){
      print("DEBUG ERROR: $e");
      return jsonDecode("");
    }
  }


}
*/
