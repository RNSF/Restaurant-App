import "package:flutter/material.dart";

import '../../../constants.dart';
import '../../base/app_bar.dart';
import '../../base/location_data.dart';
import '../checklist_item.dart';
import 'location_chooser.dart';

class LocationPicker extends StatelessWidget {

  final Map<LocationData, double> locationDistances;
  final LocationChooser locationChooserProvider;
  const LocationPicker({Key? key, required this.locationDistances, required this.locationChooserProvider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: locationDistances.length,
      itemBuilder: (context, index) {
        LocationData locationData = locationDistances.keys.toList()[index];
        double distance = locationDistances[locationData]!;
        return Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: ChecklistItem(
                    onTap: () { locationChooserProvider.selectedRestaurantData = locationData;},
                    selected: locationChooserProvider.selectedRestaurantData is LocationData ? locationChooserProvider.selectedRestaurantData!.id == locationData.id : false,
                    body: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          locationData.name,
                          style: const TextStyle(
                            color: Palette.darkOne,
                            fontSize: FontSize.smallHeader,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        RichText(
                          textAlign: TextAlign.left,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: locationData.open ? "Open" : "Closed",
                                style: TextStyle(
                                  color: locationData.open ? Palette.green : Palette.red,
                                  fontSize: FontSize.body,
                                ),
                              ),
                              TextSpan(
                                text: " - " + ((distance*100).round()/100).toString() + "km",
                                style: const TextStyle(
                                  color: Palette.darkTwo,
                                  fontSize: FontSize.body,
                                ),
                              ),
                            ]
                          ),
                        ),
                      ],
                    ),
                   ),
                ),
                 Container(
                   alignment: const Alignment(1.0, 1.0),
                   child: TextButton(
                     onPressed: () { Navigator.pushNamed(context, "/location_info_page", arguments: locationData); },
                     child: const Text(
                       "Info",
                       style: TextStyle(
                         color: Palette.darkTwo,
                         decoration: TextDecoration.underline,
                         fontSize: FontSize.body,
                         ),
                       ),
                     ),
                   ),
                ],
            ),
            const BasicDivider(),
          ],
        );
      }
    );
  }
}
