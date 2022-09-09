import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/pages/base/app_state.dart';
import 'package:restaurant_app/pages/sub/login/google_sign_in_provider.dart';
import "package:firebase_core/firebase_core.dart";
import 'package:restaurant_app/pages/base/base_page.dart';
import 'package:restaurant_app/pages/base/menu_parameters.dart';
import 'package:restaurant_app/pages/main/home/home_page.dart';
import 'package:restaurant_app/pages/sub/choose_location/location_chooser.dart';
import 'package:restaurant_app/pages/sub/reservation_options/reservations_options_page.dart';
import 'package:restaurant_app/pages/main/reservations/reservations_page.dart';
import 'package:restaurant_app/pages/sub/choose_location/choose_location_page.dart';
import 'package:restaurant_app/pages/sub/edit_account_data/edit_account_data_page.dart';
import 'package:restaurant_app/pages/sub/location_info/location_info_page.dart';
import "package:restaurant_app/pages/sub/qr_code_scanner/qr_code_scanner_page.dart";
import "package:restaurant_app/pages/sub/web_page/web_page.dart";
import "package:restaurant_app/pages/base/account_data.dart";
import "package:restaurant_app/pages/sub/login/login_page.dart";

import 'constants.dart';
import 'key_data_constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: firebaseOptions
  );

  //Get URL parameters in a map
  Map<String, String> urlParameters = Uri.base.queryParameters;

  //Run app
  runApp(RestaurantApp(urlParameters: urlParameters));
}

class RestaurantApp extends StatefulWidget {

  final Map<String, String> urlParameters;
  const RestaurantApp({Key? key, required this.urlParameters}) : super(key: key);

  @override
  State<RestaurantApp> createState() => _RestaurantAppState();
}

class _RestaurantAppState extends State<RestaurantApp> {


  bool appModeActive = true;
  @override
  Widget build(BuildContext context) {

    //Precache Background Images
    precacheImage(const AssetImage("assets/images/landing_background.jpg"), context);
    precacheImage(const AssetImage("assets/images/vignette.png"), context);

    //Get Url Parameters
    final Map<String, String> urlParameters = widget.urlParameters;

    MenuParameters menuParameters = MenuParameters();
    menuParameters.tableId = urlParameters["tableid"] == null? null : double.tryParse(urlParameters["tableid"].toString()) == null? null : int.parse(urlParameters["tableid"].toString());
    menuParameters.locationId = urlParameters["locationid"] == null? null : double.tryParse(urlParameters["locationid"].toString()) == null? null : int.parse(urlParameters["locationid"].toString());
    menuParameters.seatId = urlParameters["seatid"] == null? null : double.tryParse(urlParameters["seatid"].toString()) == null? null : int.parse(urlParameters["seatid"].toString());

    //Determine app state and null menu parameters generated from url parameters if not all are filled
    AppState appState = AppState();
    if(menuParameters.tableId != null && menuParameters.locationId != null && menuParameters.seatId != null) {
      appState.appModeActive = false;
    } else {
      menuParameters.tableId = null;
      menuParameters.locationId = null;
      menuParameters.seatId = null;
    }

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => GoogleLogIn(),),
        ChangeNotifierProvider(create: (context) => AccountData()),
        ChangeNotifierProvider(create: (context) => LocationChooser()),
        ChangeNotifierProvider(create: (context) => menuParameters),
        ChangeNotifierProvider(create: (context) => ReservationData(partySize: 2, time: DateTime.now())),
        ChangeNotifierProvider(create: (context) => appState),
      ],

      child: MaterialApp(
        title: 'Restaurant App',

        initialRoute: "/base_page",
        routes: {
          "/base_page": (context) => const BasePage(),
          "/qr_code_scanner_page" : (context) => const QrCodeScannerPage(),
          "/web_page" : (context) => const WebPage(),
          "/login_page" : (context) => const LoginPage(),
          "/choose_location_page" : (context) => const ChooseLocationPage(),
          "/location_info_page" : (context) => const LocationInfoPage(),
          "/home_page" : (context) => const HomePage(),
          "/reservations_option_page" : (context) => const ReservationsOptionPage(),
          "/edit_account_data_page" : (context) => const EditAccountDataPage(),
        },
        theme: ThemeData(
          primarySwatch: Colors.blue,
          colorScheme: const ColorScheme(
            brightness: Brightness.light,
            primary: Palette.darkTwo,
            onPrimary: Palette.darkOne,
            secondary: Palette.lightOne,
            onSecondary: Palette.accent,
            background: Colors.grey,
            onBackground: Colors.grey,
            surface: Palette.darkOne,
            onSurface: Palette.darkOne,
            error: Colors.red,
            onError: Colors.redAccent,
          ),
          timePickerTheme: TimePickerThemeData(
            dialBackgroundColor: Palette.lightTwo,
            dialHandColor: Palette.accent,
            dialTextColor: Palette.darkOne,
            backgroundColor: Palette.lightOne,
            hourMinuteColor: Palette.lightTwo,
            hourMinuteTextColor: Palette.darkOne,
            dayPeriodTextColor: Palette.darkOne,
            dayPeriodColor: MaterialStateColor.resolveWith((states) => states.contains(MaterialState.selected) ? Palette.lightOne : Palette.lightTwo),
            entryModeIconColor: Palette.lightTwo,
          ),
          fontFamily: "OpenSans",
        ),
      ),
    );
  }
}
