import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import "package:restaurant_app/pages/main/main_page_base.dart";
import '../../../constants.dart';
import '../../base/account_data.dart';
import '../../base/app_state.dart';
import '../../base/location_data.dart';
import '../start_button.dart';
import "package:restaurant_app/pages/base/menu_parameters.dart";

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    MenuParameters menuParametersProvider = Provider.of<MenuParameters>(context);
    AccountData accountDataProvider = Provider.of<AccountData>(context);
    AppState appStateProvider = Provider.of<AppState>(context);
    return MainPageBase(
      title: "Order",
      backgroundImage: const AssetImage("images/landing_background.jpg"),
      child: Center(
          child: appStateProvider.appModeActive ?
            OrderPageAppModeBody(menuParametersProvider: menuParametersProvider, accountDataProvider: accountDataProvider)
            : OrderPageScannedModeBody(menuParametersProvider: menuParametersProvider, accountDataProvider: accountDataProvider),
      ),
    );
  }
}

class OrderPageAppModeBody extends StatelessWidget {

  final MenuParameters menuParametersProvider;
  final AccountData accountDataProvider;

  const OrderPageAppModeBody({Key? key, required this.menuParametersProvider, required this.accountDataProvider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(flex: 0, child: Container()),
        Flexible(
          flex: 4,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: StartButton(text: "In Store", onPressed: (() {menuParametersProvider.isTakeOut = false; openMenu(context, menuParametersProvider, accountDataProvider);})),
          ),
        ),
        Expanded(
          flex: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                width: 50,
                height: 4,
                child: Divider(color: Palette.lightOne, thickness: 3),
              ),
              Text(
                  "or",
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontSize: FontSize.mediumHeader,
                    color: Palette.lightOne,
                    shadows: <Shadow>[basicShadow],
                  )
              ),
              const SizedBox(
                width: 50,
                height: 4,
                child: Divider(color: Palette.lightOne, thickness: 3),
              ),
            ],
          ),
        ),
        Flexible(
          flex: 4,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: StartButton(text: "Take Out", onPressed: (() {
              menuParametersProvider.isTakeOut = true;
              openMenu(context, menuParametersProvider, accountDataProvider);
            })),
          ),
        ),
        Expanded(flex: 2, child: Container()),
      ],
    );
  }
}

class OrderPageScannedModeBody extends StatelessWidget {

  final MenuParameters menuParametersProvider;
  final AccountData accountDataProvider;

  const OrderPageScannedModeBody({Key? key, required this.menuParametersProvider, required this.accountDataProvider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StartButton(text: "Order", onPressed: (() {menuParametersProvider.isTakeOut = false; openMenu(context, menuParametersProvider, accountDataProvider);}));
  }
}



void openMenu(BuildContext context, MenuParameters menuParameters, AccountData accountData) async {
  //Open Choose Location Page if Take Out and No Location Selected
  if(menuParameters.locationId == null){
    if(menuParameters.isTakeOut){
      dynamic result = await Navigator.pushNamed(context, "/choose_location_page");
      if(result is LocationData) {
        LocationData locationData = result;
        menuParameters.locationId = locationData.id;
      } else {
        return;
      }
    }
  }

  //Open QR Scanner Page if not Take Out and No Seat ID Exists
  if(menuParameters.seatId == null && !menuParameters.isTakeOut){
    dynamic result = await Navigator.pushNamed(context, "/qr_code_scanner_page");
    Map<String, String> data = result is Map<String, String> ? result : {};
    print(data);
    if(data.isNotEmpty){
      menuParameters.addMapData(data);
      print(menuParameters.seatId);
    } else {
      print("No Data");
      return;
    }
  }

  //Open the Login Page if user not logged in
  if(menuParameters.accountToken == null || menuParameters.accountToken != accountData.token) {
    if(accountData.token is String){
      menuParameters.accountToken = accountData.token;
    } else {
      await Navigator.pushNamed(context, "/login_page");
      if(accountData.token is String){
        if(accountData.token != ""){
          menuParameters.accountToken = accountData.token;
        }
      } else {
        print("Failed to log in");
        return;
      }
    }
  }

  //Open Web Page
  await Navigator.pushNamed(context, "/web_page", arguments: menuParameters.toMap());
  menuParameters.isTakeOut = false;
}