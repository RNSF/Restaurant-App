import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import "package:restaurant_app/pages/main/main_page_base.dart";
import 'package:restaurant_app/pages/main/reservations/reservation_time_picker.dart';
import 'package:restaurant_app/pages/main/reservations/table_data.dart';

import '../../../constants.dart';
import '../../base/app_bar.dart';
import '../../base/location_data.dart';
import 'option_managers.dart';

class ReservationsPage extends StatefulWidget {
  const ReservationsPage({Key? key}) : super(key: key);

  @override
  _ReservationsPageState createState() => _ReservationsPageState();
}

class _ReservationsPageState extends State<ReservationsPage> {

  final TextStyle optionTextStyle = TextStyle(
    color: Palette.lightOne,
    fontWeight: FontWeight.bold,
    shadows: <Shadow>[basicShadow],
  );
  List<TimeOfDay>? reservationTimes;
  String? currentLocationName;

  void getReservationTimes(ReservationData reservationData) async {
    List<RestaurantReservationTable> availableTables = getTableData(reservationData.time, reservationData.locationId as int);
    if(reservationData.locationId is int){
      setState(() {
        reservationTimes = findAvailableTimes(availableTables, TimeOfDay.fromDateTime(reservationData.time), reservationData.partySize, 6);
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    ReservationData reservationDataProvider = Provider.of<ReservationData>(context);
    if(reservationTimes == null && reservationDataProvider.locationId != null){
      getReservationTimes(reservationDataProvider);
    }
    if(locationDatas[reservationDataProvider.locationId] != null){
      currentLocationName = locationDatas[reservationDataProvider.locationId]!.name;
    }


    return MainPageBase(
      title: "Reservations",
      backgroundImage: const AssetImage("images/landing_background.jpg"),
      child: Center(
        child: Column(
          children: [
            BarButton(
              text: currentLocationName == null ? "Select Location" : currentLocationName!,
              disabled: false,
              textColor: Palette.accent,
              backgroundColor: Palette.lightOne,
              fontSize: FontSize.smallHeader,
              onPressed: () async {
                dynamic result = await Navigator.pushNamed(
                    context, "/choose_location_page");
                if(result is LocationData){
                  LocationData locationData = result;
                  currentLocationName = locationData.name;
                  reservationDataProvider.locationId = locationData.id;
                  reservationDataProvider.update();
                }
              }
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: OptionItem(
                      name: "Party Size",
                      optionManager: IntOptionManager(
                        context: context,
                        textFormFieldStyle: optionTextStyle,
                        onValueUpdated: (int value) {
                          reservationDataProvider.partySize = value; reservationTimes = null;
                          reservationDataProvider.update();
                        },
                        initialValue: reservationDataProvider.partySize,
                        min: 1,
                        max: 10,
                      ),
                    ),
                  ),
                  Expanded(
                    child: OptionItem(
                      name: "Time",
                      optionManager: TimeOptionManager(
                        initialValue: TimeOfDay(hour: reservationDataProvider.time.hour, minute: reservationDataProvider.time.minute),
                        context: context,
                        textFormFieldStyle: optionTextStyle,
                        onValueUpdated: (TimeOfDay time) {
                          updateTime(reservationDataProvider, time);
                          reservationTimes = null;
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: OptionItem(
                      name: "Date",
                      optionManager: DateOptionManager(
                        initialValue: reservationDataProvider.time,
                        context: context,
                        textFormFieldStyle: optionTextStyle,
                        onValueUpdated: (DateTime date) {
                          reservationDataProvider.time = DateTime(
                            date.year,
                            date.month,
                            date.day,
                            reservationDataProvider.time.hour,
                            reservationDataProvider.time.minute,
                          );
                          reservationTimes = null;
                          reservationDataProvider.update();
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Expanded(flex: 1, child: SizedBox()),
            SizedBox(
              width: 340,
              height: 120,
              child: ReservationTimePicker(reservationTimes: reservationTimes, reservationData: reservationDataProvider)
            ),
            const Expanded(flex: 1, child: SizedBox()),
          ],
        ),
      ),
    );
  }
}

class ReservationData with ChangeNotifier {
  int? locationId;
  DateTime time;
  int partySize;
  String? seatingType;
  String? menuType;
  String? userEmail;

  ReservationData({this.locationId, required this.time, required this.partySize});

  void update(){
    notifyListeners();
  }
}

class OptionItem extends StatelessWidget {
  final String name;
  final OptionManager optionManager;

  const OptionItem({Key? key, required this.name, required this.optionManager}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          name,
          style: TextStyle(
            color: Palette.lightOne,
            fontWeight: FontWeight.bold,
            fontSize: FontSize.smallHeader,
            shadows: <Shadow>[basicShadow],
          )
        ),
        const SizedBox(height: 10),
        Container(
          width: 110,
          child: optionManager.textFormField,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Palette.lightOne, width: 4.0),
          ),
        ),
      ],
    );
  }
}




List<TimeOfDay> findAvailableTimes(List<RestaurantReservationTable> tables, TimeOfDay requestedTime, int partySize, int numberOfTables) {
  //Generate list of all available times for that day based on available tables
  List<TimeOfDay> totalAvailableTimes = [];
  for(var table in tables) {
    if(table.size >= partySize){
      for(var time in table.availableTimes) {
        if(!totalAvailableTimes.contains(time)) {totalAvailableTimes.add(time);}
      }
    }
  }

  //Find the closest times to the requested time
  Map<TimeOfDay, Duration> availableTimesWithDuration = {};
  DateTime requestedDateTime = DateTime(1, 1, 1, requestedTime.hour, requestedTime.minute);
  for(var time in totalAvailableTimes) {
    DateTime dateTime = DateTime(1, 1, 1, time.hour, time.minute);
    availableTimesWithDuration[time] = dateTime.difference(requestedDateTime);
  }

  List<TimeOfDay> bestTimes = [];
  for(int i=0; i<numberOfTables; i++) {
    int shortestMinuteDuration = 999999999;
    TimeOfDay? bestTime;
    availableTimesWithDuration.forEach((time, duration) {
      if(duration.inMinutes.abs() < shortestMinuteDuration){
        shortestMinuteDuration = duration.inMinutes.abs();
        bestTime = time;
      }
    });
    if(bestTime != null){
      TimeOfDay bT = bestTime as TimeOfDay;
      bool timeAdded = false;
      for(final time in bestTimes) {
         if(bT.hour < time.hour || (bT.hour == time.hour && bT.minute < time.minute)) {
          bestTimes.insert(bestTimes.indexOf(time), bT);
          timeAdded = true;
          break;
        }
      }
      if(!timeAdded) { bestTimes.add(bT); }
      availableTimesWithDuration.remove(bestTime);
    }
  }

  return bestTimes;
}
