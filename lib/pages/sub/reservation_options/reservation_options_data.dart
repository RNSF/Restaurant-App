import 'package:restaurant_app/pages/sub/reservation_options/reservations_options_base.dart';
import '../../main/reservations/reservations_page.dart';
import '../../main/reservations/table_data.dart';

List<ReservationOptionData> getSeatingOptionData(ReservationData reservationData, List<SeatType> availableSeatTypes){

  List<ReservationOptionData> seatingOptionData = [
    ReservationOptionData(
      title: "Outdoor",
      id: "outdoor",
      description: "",
      disabled: !availableSeatTypes.contains(SeatType.outdoor),
      selected: reservationData.seatingType == "outdoor",
    ),
    ReservationOptionData(
      title: "Hightop",
      id: "hightop",
      description: "",
      disabled: !availableSeatTypes.contains(SeatType.hightop),
      selected: reservationData.seatingType == "hightop",
    ),
    ReservationOptionData(
      title: "Standard",
      id: "standard",
      description: "",
      disabled: !availableSeatTypes.contains(SeatType.standard),
      selected: reservationData.seatingType == "standard",
    ),
    ReservationOptionData(
      title: "Counter",
      id: "counter",
      description: "",
      disabled: !availableSeatTypes.contains(SeatType.counter),
      selected: reservationData.seatingType == "counter",
    ),
  ];

  for(var element in seatingOptionData) {
    if(!element.disabled){
      seatingOptionData.remove(element);
      seatingOptionData.insert(0, element);
    }
  }

  return seatingOptionData;
}

List<ReservationOptionData> getMenuOptionData(ReservationData reservationData) {
  List<ReservationOptionData> menuOptionData = [
    ReservationOptionData(
      title: "Standard",
      id: "standard",
      description: "The classic Keg menu.",
      selected: reservationData.menuType == "standard",
    ),
    ReservationOptionData(
      title: "Anniversary",
      id: "anniversary",
      description: "Indulge in our 50th Anniversary Menu, inspired by classic flavours and guest favourites.",
      selected: reservationData.menuType == "anniversary",
    ),
  ];

  for(var element in menuOptionData) {
    if(!element.disabled){
      menuOptionData.remove(element);
      menuOptionData.insert(0, element);
    }
  }

  return menuOptionData;
}



