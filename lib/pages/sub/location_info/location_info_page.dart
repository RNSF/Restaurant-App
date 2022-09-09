import 'package:flutter/material.dart';
import 'package:restaurant_app/pages/base/app_bar.dart';
import 'package:restaurant_app/pages/sub/ammenities.dart';
import 'package:intl/intl.dart';

import '../../../constants.dart';
import '../../base/location_data.dart';

class LocationInfoPage extends StatefulWidget {

  const LocationInfoPage({Key? key}) : super(key: key);

  @override
  _LocationInfoPageState createState() => _LocationInfoPageState();
}

class _LocationInfoPageState extends State<LocationInfoPage> {

  LocationData? locationData;

  @override
  Widget build(BuildContext context) {
    dynamic result = ModalRoute.of(context)!.settings.arguments;
    setState(() {
      locationData = result != null ? result as LocationData : null;
    });
    if(locationData == null){
      return const Text("Error can't load; no data");
    } else {
      return Scaffold(
        appBar: MainAppBar(mainColor: Palette.darkOne, logoColor: Palette.lightOne),
        bottomNavigationBar: const ReturnBottomNavigation(),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 250,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(locationData!.photoUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(color: Palette.accent, height: 6),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 48.0, vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children : [
                      Text(
                        locationData!.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Palette.darkOne,
                          fontSize: FontSize.smallHeader,
                        ),
                      ),
                      Text(
                        locationData!.address,
                        style: const TextStyle(
                          color: Palette.darkOne,
                          fontSize: FontSize.body,
                        ),
                      ),

                      const BasicDivider(),
                      const Text(
                        "Contact",
                        style: TextStyle(
                          color: Palette.darkOne,
                          fontSize: FontSize.body,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.phone, color: Palette.darkOne),
                          Text(
                          locationData!.phoneNumber,
                          style: const TextStyle(
                            color: Palette.darkOne,
                            fontSize: FontSize.body,
                            ),
                          ),
                        ],
                      ),
                      const BasicDivider(),
                      const Text(
                        "Hours",
                        style: TextStyle(
                          color: Palette.darkOne,
                          fontSize: FontSize.body,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(
                        height: 150,
                        width: 250,
                        child: ListView.builder(
                          itemCount: locationData!.operatingHours.length,
                          itemBuilder: (context, index) {
                            String dayOfWeek = locationData!.operatingHours.keys.toList()[index];
                            DateTimeRange? hours =  locationData!.operatingHours[dayOfWeek];
                            return Row(
                              children: [
                                Text(
                                  dayOfWeek,
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                    color: Palette.darkOne,
                                    fontSize: FontSize.body,
                                  ),
                                ),
                                const Expanded(child: SizedBox()),
                                Text(
                                  hours == null ? "Closed" : "${DateFormat("HH:mm").format(hours.start)} - ${DateFormat("HH:mm").format(hours.end)}",
                                  textAlign: TextAlign.right,
                                  style: const TextStyle(
                                    color: Palette.darkOne,
                                    fontSize: FontSize.body,
                                  ),
                                ),
                              ],
                            );
                          }
                        ),
                      ),

                      const BasicDivider(),
                      const Text(
                        "Ammenities",
                        style: TextStyle(
                          color: Palette.darkOne,
                          fontSize: FontSize.body,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 100,
                        width: 200,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: locationData!.ammenities.length,
                          itemBuilder: (context, index) {
                            Ammenities ammenity = locationData!.ammenities[index];

                            return Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Icon(getAmmenityIcon(ammenity), color: Palette.darkOne),
                                ),
                                Text(
                                getAmmenityName(ammenity) is String? getAmmenityName(ammenity) as String : "",
                                style: const TextStyle(
                                  color: Palette.darkOne,
                                  fontSize: FontSize.body,
                                  ),
                                ),
                              ],
                            );
                          }
                        ),
                      ),
                    ]
                  ),
                )
              ],
            ),
          ),
        )
      );
    }
  }
}
