import "package:flutter/material.dart";





import 'package:provider/provider.dart';
import '../../../constants.dart';
import '../../base/account_data.dart';
import '../../base/app_bar.dart';

import 'option_editors.dart';


class EditAccountDataPage extends StatefulWidget {
  const EditAccountDataPage({Key? key}) : super(key: key);

  @override
  _EditAccountDataPageState createState() => _EditAccountDataPageState();
}

class _EditAccountDataPageState extends State<EditAccountDataPage> {

  bool changeMade = false;
  AccountData localAccountData = AccountData();


  @override
  Widget build(BuildContext context) {
    AccountData accountDataProvider = Provider.of<AccountData>(context);
    if(localAccountData.email == ""){
      setState(() {
        localAccountData = AccountData.fromAccountData(accountDataProvider);
      });
    }

    return Scaffold(
      appBar: MainAppBar(mainColor: Palette.darkOne, logoColor: Palette.lightOne),
      bottomNavigationBar: ReturnBottomNavigation(
        child: BarButton(
          text: "Confirm",
          disabled: !changeMade || localAccountData.phoneNumber.length != 12,
          onPressed: () {
            accountDataProvider.update(localAccountData);
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: 320,
            child: Column(
              children: [
                const Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        "Edit Account Info",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: FontSize.mediumHeader,
                          fontWeight: FontWeight.bold,
                          color: Palette.darkOne,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      const BasicDivider(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: EmailOption(
                          optionName: "Email",
                          optionValue: localAccountData.email,
                          onValueChanged: (String newValue) {setState(() {
                            localAccountData.email = newValue;
                            changeMade = true;
                          });},
                          editable: false,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: PhoneOption(
                          optionName: "Phone",
                          optionValue: localAccountData.phoneNumber.substring(2),
                          onValueChanged: (String newValue) {setState(() {
                            localAccountData.phoneNumber = newValue;
                            changeMade = true;
                          });},
                        ),
                      ),
                      const BasicDivider(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: BoolOption(
                          optionName: "Email Receipts",
                          optionValue: localAccountData.emailReceipts,
                          onValueChanged: (bool newValue) {setState(() {
                            localAccountData.emailReceipts = newValue;
                            changeMade = true;
                          });},
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: BoolOption(
                          optionName: "Reservation Reminders",
                          optionValue: localAccountData.reservationReminders,
                          onValueChanged: (bool newValue) {setState(() {
                            localAccountData.reservationReminders = newValue;
                            changeMade = true;
                          });},
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: BoolOption(
                          optionName: "Weekly Newsletter",
                          optionValue: localAccountData.weeklyNewsletter,
                          onValueChanged: (bool newValue) {setState(() {
                            localAccountData.weeklyNewsletter = newValue;
                            changeMade = true;
                          });},
                        ),
                      ),
                      const BasicDivider(),
                    ],
                  ),
                ),
              ]
            ),
          ),
        ),
      ),
    );
  }
}
