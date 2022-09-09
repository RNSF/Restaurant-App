import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import "package:restaurant_app/pages/base/account_data.dart";

import '../../../constants.dart';
import '../../sub/login/google_sign_in_provider.dart';

class LoggedInBody extends StatelessWidget {
  final AccountData accountData;
  final BuildContext context;
  const LoggedInBody({Key? key, required this.accountData, required this.context}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 64.0),
              child: SizedBox(
                width: 320,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children : [
                          CircleAvatar(
                            radius: 40,
                            backgroundColor: Palette.accent,
                            child: CircleAvatar(
                              radius: 35,
                              backgroundImage: NetworkImage(accountData.profileImageUrl),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(accountData.firstName, textAlign: TextAlign.left, style: const TextStyle(
                                  color: Palette.lightOne, fontSize: FontSize.largeHeader, fontWeight: FontWeight.bold,
                                )),
                                Text(accountData.lastName, style: MainTextStyle()),
                              ],
                            ),
                          ),
                        ]
                      ),
                      const SizedBox(height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Subheader(text: "Info"),
                          const SizedBox(height: 10),
                          Text("Email: ${accountData.email}", style: MainTextStyle()),
                          Text("Phone: ${accountData.phoneNumber}", style: MainTextStyle()),
                        ]
                      ),
                      const SizedBox(height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Subheader(text: "Preferences"),
                          const SizedBox(height: 10),
                          BoolPreferenceItem(text: "Email Receipts", enabled: accountData.emailReceipts),
                          BoolPreferenceItem(text: "Reservation Reminders", enabled: accountData.reservationReminders),
                          BoolPreferenceItem(text: "Weekly Newsletter", enabled: accountData.weeklyNewsletter),
                        ],
                      ),
                      const SizedBox(height: 100)
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Container(
          alignment: const Alignment(1.0, 1.0),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: FloatingActionButton(
              onPressed: () { Navigator.pushNamed(context, "/edit_account_data_page");},
              backgroundColor: Palette.accent,
              child: const Icon(Icons.edit, color: Palette.lightOne),
            ),
          ),
        ),
        Container(
          alignment: const Alignment(-1.0, 1.0),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: TextButton(
              onPressed: () {
                final googleSignInProvider = Provider.of<GoogleLogIn>(context, listen: false);
                googleSignInProvider.googleLogout();
                accountData.clear();

              },
              child: Text(
                "Logout",
                style: TextStyle(
                  color: Palette.lightOne,
                  fontSize: FontSize.smallHeader,
                  fontStyle: FontStyle.italic,
                  shadows: <Shadow>[
                    basicShadow
                  ],
                )
              )
            )
          )
        )
      ],
    );
  }
}
class MainTextStyle extends TextStyle {
    MainTextStyle() : super(
      color: Palette.lightOne,
      fontSize: FontSize.body,
      shadows: <Shadow>[
        basicShadow
      ],
    );
  }

class Subheader extends StatelessWidget {
  final String text;
  const Subheader({Key? key, this.text = ""}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 3),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(
          color: Palette.accent,
          width: 3.0,
        ))
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 0.0),
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: FontSize.smallHeader,
            color: Palette.lightOne,
            shadows: <Shadow>[
              basicShadow
            ],
          ),
        ),
      ),
    );
  }
}

class BoolPreferenceItem extends StatelessWidget{
  final String text;
  final bool enabled;
  const BoolPreferenceItem({Key? key, this.text = "", this.enabled = false}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 25,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            border: Border.all(color: Palette.lightOne, width: 2.0),
          ),
          child: Center(
            child: Text(
              enabled ? "Yes" : "No",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: FontSize.body,
                color: Palette.lightOne,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.0),
          child: Text(
            text,
            style: MainTextStyle(),
          ),
        ),
      ],
    );
  }
}