import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/pages/main/reservations/reservations_page.dart';

import '../../../constants.dart';
import '../../base/app_bar.dart';
import '../../base/location_data.dart';
import "package:intl/intl.dart";

class ConfirmReservationPage extends StatelessWidget {

  final Function()? alternativeBottomBackArrowOnPressed;

  const ConfirmReservationPage({Key? key, this.alternativeBottomBackArrowOnPressed}) : super(key: key);



  @override
  Widget build(BuildContext context) {

    ReservationData reservationDataProvider = Provider.of<ReservationData>(context);

    List<ReservationOptionDisplayData> reservationOptionDisplayDatas = [
      ReservationOptionDisplayData(optionName: "Location", valueName: locationDatas[reservationDataProvider.locationId]!.name),
      ReservationOptionDisplayData(optionName: "Party Size", valueName: reservationDataProvider.partySize.toString()),
      ReservationOptionDisplayData(optionName: "Time", valueName: TimeOfDay.fromDateTime(reservationDataProvider.time).format(context)),
      ReservationOptionDisplayData(optionName: "Date", valueName: DateFormat("yyyy-MM-dd").format(reservationDataProvider.time)),
      ReservationOptionDisplayData(optionName: "Seating Type", valueName: {
        "outdoor" : "Outdoor",
        "hightop" : "Hightop",
        "standard" : "Standard",
        "counter" : "Counter",
      }[reservationDataProvider.seatingType] as String),
      ReservationOptionDisplayData(optionName: "Menu Type", valueName: {
        "standard" : "Standard",
        "anniversary" : "Anniversary",
      }[reservationDataProvider.menuType] as String),
    ];

    return Scaffold(
      appBar: MainAppBar(mainColor: Palette.darkOne, logoColor: Palette.lightOne),
      bottomNavigationBar: ReturnBottomNavigation(
        child: BarButton(
          text: "Confirm",
          onPressed: () {
            confirmReservation();
            Navigator.pop(context);
          },
        ),
        alternativeOnPressed: alternativeBottomBackArrowOnPressed,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  "Confirm your Reservation",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: FontSize.mediumHeader,
                    fontWeight: FontWeight.bold,
                    color: Palette.darkOne,
                    shadows: <Shadow>[
                      basicShadow
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: ListView.builder(
                itemCount: reservationOptionDisplayDatas.length,
                itemBuilder: (context, index) {
                  ReservationOptionDisplayData reservationOptionDisplayData = reservationOptionDisplayDatas[index];
                  return Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            reservationOptionDisplayData.optionName,
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                              color: Palette.darkOne,
                              fontSize: FontSize.smallHeader,
                            ),
                          ),
                          const Expanded(child: SizedBox()),
                          Text(
                            reservationOptionDisplayData.valueName,
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                              color: Palette.darkOne,
                              fontSize: FontSize.smallHeader,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                      const BasicDivider(),
                    ]
                  );
                }
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ReservationOptionDisplayData {
  final String optionName;
  final String valueName;
  ReservationOptionDisplayData({this.optionName = "Option", this.valueName = "Value"});
}

void confirmReservation() {
  //dummy function
}