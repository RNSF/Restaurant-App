import 'package:flutter/material.dart';
import 'package:restaurant_app/pages/sub/checklist_item.dart';

import '../../../constants.dart';
import '../../base/app_bar.dart';

class ReservationOptionsBase extends StatelessWidget {

  final List<ReservationOptionData> reservationOptionDatas;
  final Function onSelectionMade;
  final bool selectionMade;
  final String title;
  final Function onConfirmationMade;
  final Function()? alternativeBottomBackArrowOnPressed;
  final ReservationOptionData? selectedReservationOptionData;

  const ReservationOptionsBase({required this.reservationOptionDatas, required this.onSelectionMade, required this.title, required this.onConfirmationMade, this.alternativeBottomBackArrowOnPressed, this.selectionMade = false, this.selectedReservationOptionData, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(mainColor: Palette.darkOne, logoColor: Palette.lightOne),
      bottomNavigationBar: ReturnBottomNavigation(
        alternativeOnPressed: alternativeBottomBackArrowOnPressed,
        child: BarButton(
          text: "Confirm",
          disabled: !selectionMade,
          onPressed: () {
            onConfirmationMade();
          },
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  title,
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
            child: ListView.builder(
              itemCount: reservationOptionDatas.length,
              itemBuilder: (context, index) {
                ReservationOptionData reservationOptionData = reservationOptionDatas[index];
                return Column(
                  children: [
                    Container(
                      constraints: const BoxConstraints(
                        minHeight: 50,
                      ),
                      child: ChecklistItem(
                        selected: reservationOptionData.selected,
                        disabled: reservationOptionData.disabled,
                        onTap: () => onSelectionMade(reservationOptionData),
                        body: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              reservationOptionData.title,
                              style: TextStyle(
                                color: reservationOptionData.disabled ? Palette.lightTwo : Palette.darkOne,
                                fontSize: FontSize.smallHeader,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            if (!(reservationOptionData.description == "" || reservationOptionData.disabled)) SizedBox(
                              width: 300,
                              child: Text(
                                reservationOptionData.description,
                                style: const TextStyle(
                                  color: Palette.darkTwo,
                                  fontSize: FontSize.body,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const BasicDivider(),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ReservationOptionData {
  String title;
  String description = "";
  String id;
  bool disabled;
  bool selected;

  ReservationOptionData({required this.title, required this.id, this.description = "", this.disabled = false, this.selected = false});
}