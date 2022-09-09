import "package:flutter/foundation.dart";

class AccountData with ChangeNotifier {
  String firstName;
  String lastName;
  String profileImageUrl;
  String email;
  String phoneNumber;
  String? token;
  bool emailReceipts;
  bool reservationReminders;
  bool weeklyNewsletter;
  bool loggedIn = false;
  dynamic user;
  AccountData({
    this.firstName = "",
    this.lastName = "",
    this.profileImageUrl = "",
    this.email = "",
    this.phoneNumber = "",
    this.emailReceipts = false,
    this.reservationReminders = false,
    this.weeklyNewsletter = false,
    this.token,
  });

  void clear() {
    firstName = "";
    lastName = "";
    profileImageUrl = "";
    email = "";
    phoneNumber = "";
    emailReceipts = false;
    reservationReminders = false;
    weeklyNewsletter= false;
    token = null;
    loggedIn = false;
    notifyListeners();
  }

  factory AccountData.fromAccountData(AccountData accountData){
    return AccountData(
      firstName: accountData.firstName,
      lastName: accountData.lastName,
      profileImageUrl: accountData.profileImageUrl,
      email: accountData.email,
      phoneNumber: accountData.phoneNumber,
      emailReceipts: accountData.emailReceipts,
      reservationReminders: accountData.reservationReminders,
      weeklyNewsletter: accountData.weeklyNewsletter,
      token: accountData.token,
    );
  }

  void update(AccountData accountData){
    firstName = accountData.firstName;
    lastName = accountData.lastName;
    profileImageUrl = accountData.profileImageUrl;
    email = accountData.email;
    phoneNumber = accountData.phoneNumber;
    emailReceipts = accountData.emailReceipts;
    reservationReminders = accountData.reservationReminders;
    weeklyNewsletter = accountData.weeklyNewsletter;
    token = accountData.token;
    notifyListeners();
  }

  void updateListeners(){
    notifyListeners();
  }
}