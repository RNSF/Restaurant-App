

import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '../../base/account_data.dart';
import 'google_account_data.dart';
import 'google_sign_in_provider.dart';
import 'package:flutter/material.dart';

void accountGoogleLogin(BuildContext context) async {
  final googleSignInProvider = Provider.of<GoogleLogIn>(context, listen: false);
  await googleSignInProvider.googleLogin();
  final accountDataProvider = Provider.of<AccountData>(context, listen: false);
  if(FirebaseAuth.instance.currentUser != null){
    User? user = FirebaseAuth.instance.currentUser;
    String fullName = user != null? user.displayName.toString() : "";
    List fullNameList = fullName.split(" ");
    accountDataProvider.firstName = fullNameList[0];
    accountDataProvider.lastName = fullNameList.length > 1? fullNameList[1] : "";
    accountDataProvider.email = user != null? user.email.toString() : "";
    accountDataProvider.profileImageUrl = user != null? user.photoURL ?? "" : "";
    accountDataProvider.loggedIn = true;
    accountDataProvider.token = getTokenFromGoogleId(user!.uid);

    Map<String, dynamic> accountOptions = getAccountOptions(accountDataProvider.email);
    accountDataProvider.phoneNumber = accountOptions["Phone Number"];
    accountDataProvider.emailReceipts = accountOptions["Email Receipts"];
    accountDataProvider.weeklyNewsletter = accountOptions["Weekly Newsletter"];
    accountDataProvider.reservationReminders = accountOptions["Reservation Reminders"];

    accountDataProvider.updateListeners();
    Navigator.pop(context);
  }
}