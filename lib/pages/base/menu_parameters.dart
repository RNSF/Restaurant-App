import "package:flutter/foundation.dart";

class MenuParameters with ChangeNotifier {
  int? locationId;
  int? tableId;
  int? seatId;
  String? accountToken;
  bool isTakeOut;

  MenuParameters({this.locationId, this.tableId, this.seatId, this.accountToken, this.isTakeOut = false});

  void addMapData(Map<String, String> data) {
    data.forEach((key, value) {
      switch(key) {
        case "locationid":
          locationId = int.parse(value);
          break;
        case "tableid":
          tableId = int.parse(value);
          break;
        case "seatid":
          seatId = int.parse(value);
          break;
        case "accounttoken":
          accountToken = value;
          break;
        case "istakeout":
          isTakeOut = (int.parse(value) == 1);
          break;
      }
    });
    notifyListeners();
  }

  Map<String, String> toMap(){
    Map<String, String> result = {};
    if(locationId != null){ result["locationid"] = locationId.toString(); }
    if(seatId != null){ result["seatid"] = seatId.toString(); }
    if(tableId != null){ result["tableid"] = tableId.toString(); }
    if(isTakeOut){ result["istakeout"] = "1";}
    if(accountToken != null){ result["token"] = accountToken.toString(); }


    return result;
  }
}