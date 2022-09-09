import 'package:flutter/material.dart';
import "package:restaurant_app/pages/main/main_page_base.dart";
import "package:provider/provider.dart";
import "package:restaurant_app/pages/base/account_data.dart";
import 'package:restaurant_app/pages/main/account/logged_in_body.dart';
import 'package:restaurant_app/pages/main/account/logged_out_body.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    final AccountData accountDataProvider = Provider.of<AccountData>(context);
    return MainPageBase(
      title: "Account",
      backgroundImage: const AssetImage("images/landing_background.jpg"),
      child: accountDataProvider.loggedIn ?
        LoggedInBody(context: context, accountData: accountDataProvider) :
        LoggedOutBody(context: context, accountData: accountDataProvider),
    );
  }
}

