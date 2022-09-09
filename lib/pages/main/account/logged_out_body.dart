import "package:flutter/material.dart";
import "package:restaurant_app/pages/base/account_data.dart";
import "package:restaurant_app/pages/main/start_button.dart";

import '../../../constants.dart';

class LoggedOutBody extends StatelessWidget {
  final AccountData accountData;
  final BuildContext context;
  const LoggedOutBody({Key? key, required this.accountData, required this.context}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Expanded(flex: 4, child: SizedBox()),
          Expanded(
            flex: 2,
            child: Text(
              "You are currently not logged in.",
              style: TextStyle(
                color: Palette.lightOne,
                fontSize: FontSize.smallHeader,
                shadows: <Shadow>[
                  basicShadow
                ],
              )
            ),
          ),
          const Expanded(flex: 1, child: SizedBox()),
          StartButton(
            onPressed: () => Navigator.of(context).pushNamed("/login_page"),
            text: "Log In",
          ),
          const Expanded(flex: 7, child: SizedBox()),
        ],
      ),
    );
  }
}