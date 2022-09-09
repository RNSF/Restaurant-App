import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/pages/main/reservations/reservations_page.dart';

import '../../../constants.dart';
import '../../base/account_data.dart';

class ReservationTimeButton extends StatelessWidget {
  final TimeOfDay time;
  final ReservationData reservationData;
  const ReservationTimeButton({Key? key, required this.time, required this.reservationData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AccountData accountDataProvider = Provider.of<AccountData>(context);
    return ElevatedButton(
      onPressed: () async {
        if(!accountDataProvider.loggedIn){
          await Navigator.pushNamed(context, "/login_page", arguments: false);
          if(!accountDataProvider.loggedIn){ return; }
        }
        reservationData.menuType = null;
        reservationData.seatingType = null;
        updateTime(reservationData, time);
        Navigator.pushNamed(context, "/reservations_option_page");

      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Palette.accent),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        ),
        fixedSize: MaterialStateProperty.all<Size>(const Size(120, 40))
      ),
      child: Text(
        time.format(context),
        style: TextStyle(
          color: Palette.lightOne,
          letterSpacing: 1.5,
          fontWeight: FontWeight.bold,
          fontSize: FontSize.body,
          shadows: <Shadow>[basicShadow],
        )
      ),
    );
  }
}

class ReservationTimePicker extends StatelessWidget {

  final List<TimeOfDay>? reservationTimes;
  final ReservationData reservationData;

  const ReservationTimePicker({Key? key, this.reservationTimes, required this.reservationData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(reservationData.locationId is int){
      if(reservationTimes != null){
        List<TimeOfDay> rT = reservationTimes as List<TimeOfDay>;
        if(rT.isNotEmpty){
          return GridView.builder(
            itemCount: rT.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 2.0/1.0),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(child: ReservationTimeButton(time: rT[index], reservationData: reservationData)),
              );
            },
          );
        } else {
          return Center(
            child: Text(
              "No available times",
              style: TextStyle(
                fontSize: FontSize.smallHeader,
                color: Palette.lightOne,
                fontStyle: FontStyle.italic,
                shadows: <Shadow>[basicShadow],
              )
            ),
          );
        }

      } else {
        return Center(
          child: Text(
            "Loading...",
            style: TextStyle(
              fontSize: FontSize.smallHeader,
              color: Palette.lightOne,
              fontStyle: FontStyle.italic,
              shadows: <Shadow>[basicShadow],
            )
          ),
        );
      }
    } else {
      return Center(
        child: Text(
          "Select a Location Above",
          style: TextStyle(
            fontSize: FontSize.smallHeader,
            color: Palette.lightOne,
            fontStyle: FontStyle.italic,
            shadows: <Shadow>[basicShadow],
          )
        ),
      );
    }

  }
}


void updateTime(ReservationData reservationData, TimeOfDay time)  {
  reservationData.time = DateTime(
    reservationData.time.year,
    reservationData.time.month,
    reservationData.time.day,
    time.hour,
    time.minute,
  );
  reservationData.update();
}