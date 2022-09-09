import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/pages/sub/reservation_options/reservation_options_data.dart';
import 'package:restaurant_app/pages/sub/reservation_options/reservations_options_base.dart';
import 'package:restaurant_app/pages/main/reservations/reservations_page.dart';
import 'package:restaurant_app/pages/main/reservations/table_data.dart';
import 'confirm_reservation_page.dart';

class ReservationsOptionPage extends StatefulWidget {
  const ReservationsOptionPage({Key? key}) : super(key: key);

  @override
  _ReservationsOptionPageState createState() => _ReservationsOptionPageState();
}

class _ReservationsOptionPageState extends State<ReservationsOptionPage> {
  
   PageController pageController = PageController();
  
  @override
  Widget build(BuildContext context) {

    ReservationData reservationDataProvider = Provider.of<ReservationData>(context);
    List<SeatType> availableSeatTypes = getAvailableSeatTypes(
      getTableData(reservationDataProvider.time, reservationDataProvider.locationId ?? 0),
      TimeOfDay.fromDateTime(reservationDataProvider.time),
      reservationDataProvider.partySize,
    );

    List<ReservationOptionData> seatingOptionData = getSeatingOptionData(reservationDataProvider, availableSeatTypes);
    List<ReservationOptionData> menuOptionData = getMenuOptionData(reservationDataProvider);



    return Scaffold(
      body: SafeArea(
        child: PageView(
          controller: pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            ReservationOptionsBase(
              reservationOptionDatas: seatingOptionData,
              title: "Select a Seating Type",
              onSelectionMade: ((ReservationOptionData reservationOptionData) {
                reservationDataProvider.seatingType = reservationOptionData.id;
                reservationDataProvider.update();
              }),
              selectionMade: reservationDataProvider.seatingType != null,
              onConfirmationMade: () {animateToPage(pageController, pageController.page!.toInt()+1); },
            ),
            ReservationOptionsBase(
              reservationOptionDatas: menuOptionData,
              title: "Select a Menu",
              onSelectionMade: ((ReservationOptionData reservationOptionData) {
                reservationDataProvider.menuType = reservationOptionData.id;
                reservationDataProvider.update();
              }),
              selectionMade: reservationDataProvider.menuType != null,
              onConfirmationMade: (() { animateToPage(pageController, pageController.page!.toInt()+1); }),
              alternativeBottomBackArrowOnPressed: (() { animateToPage(pageController, pageController.page!.toInt()-1); })
            ),
            ConfirmReservationPage(alternativeBottomBackArrowOnPressed: (() { animateToPage(pageController, pageController.page!.toInt()-1); })),
          ],
        ),
      ),
    );
  }
}

List<SeatType> getAvailableSeatTypes(List<RestaurantReservationTable> tables, TimeOfDay requestedTime, int partySize) {
  List<SeatType> seatTypes = [];
  for(var table in tables) {
    bool isCorrectTime = false;
    for(var time in table.availableTimes) {
      if(time.hour == requestedTime.hour && time.minute == requestedTime.minute) {
        isCorrectTime = true;
      }
    }
    if(isCorrectTime && table.size >= partySize && !seatTypes.contains(table.seatType)){
      seatTypes.add(table.seatType);
    }
  }
  return seatTypes;
}

void animateToPage(PageController pageController, int pageIndex) {
  pageController.animateToPage(pageIndex, duration: const Duration(milliseconds: 200), curve: Curves.easeOut);
}
