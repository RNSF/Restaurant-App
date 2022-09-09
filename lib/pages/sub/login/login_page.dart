import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:restaurant_app/pages/base/account_data.dart";
import "package:restaurant_app/constants.dart";
import "package:restaurant_app/pages/base/app_bar.dart";
import 'login_method_data.dart';

class LoginPage extends StatefulWidget {


  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  List<LoginMethodData> loginMethodDatas = [];
  bool skippable = true;


  @override
  void initState() {
    super.initState();
    loginMethodDatas = getLoginMethodDatas();
  }

  @override
  Widget build(BuildContext context) {

    dynamic result = ModalRoute.of(context)!.settings.arguments;
    setState(() {
      skippable = result != null ? result as bool : true;
    });

    return Scaffold(
      appBar: MainAppBar(mainColor: Palette.darkOne, logoColor: Palette.lightOne),
      bottomNavigationBar: const ReturnBottomNavigation(),
      body: SafeArea(
        child: Column(
          children : [
            const Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    'Log In',
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
              child: SizedBox(
                width: 250,
                child: Column(
                  children: [
                    Expanded(
                      flex: 7,
                      child: ListView.builder(
                        itemCount: loginMethodDatas.length,
                        itemBuilder: (context, index) {
                          LoginMethodData loginMethodData = loginMethodDatas[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: ElevatedButton.icon(
                              icon: Padding(
                                padding: const EdgeInsets.all(1.0),
                                child: Container(
                                  color: Palette.lightOne,
                                  width: 34,
                                  height: 34,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.network(loginMethodData.logoUrl, isAntiAlias: true),
                                  ),
                                ),
                              ),
                              onPressed: () {loginMethodData.onPressed(context);},
                              label: Text(
                                "Sign in with " + loginMethodData.name,
                                style: const TextStyle(
                                  color: Palette.lightOne,
                                  fontSize: FontSize.body,
                                ),
                              ),
                              style: ButtonStyle(
                                alignment: Alignment.centerLeft,
                                fixedSize: MaterialStateProperty.all<Size>(const Size(10, 40)),
                                backgroundColor: MaterialStateProperty.all<Color>(loginMethodData.backgroundColor),
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                            ),
                          );
                        }
                      ),
                    ),
                    const Expanded(flex: 2, child: SizedBox(height: 40)),
                    skippable ? TextButton(
                      onPressed: () { Provider.of<AccountData>(context).token = ""; Navigator.pop(context); },
                      child: const Text(
                        "Skip",
                        style: TextStyle(
                          color: Palette.darkOne,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ) : Container(),
                    const Expanded(flex: 4, child: SizedBox(height: 40)),
                  ],
                ),
              )
            ),
          ],
        ),
      ),
    );
  }
}



