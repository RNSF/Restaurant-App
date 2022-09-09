
import 'account_google_login.dart';
import 'package:flutter/material.dart';

class LoginMethodData {
  final String name;
  final String logoUrl;
  final Color backgroundColor;
  final Function onPressed;

  LoginMethodData({required this.name, required this.logoUrl, required this.backgroundColor, required this.onPressed});
}

List<LoginMethodData> getLoginMethodDatas() {
  return [
    LoginMethodData(
      name: "Google",
      backgroundColor: const Color(0xff4285F4),
      logoUrl: "https://upload.wikimedia.org/wikipedia/commons/thumb/5/53/Google_%22G%22_Logo.svg/2048px-Google_%22G%22_Logo.svg.png",
      onPressed: accountGoogleLogin,
    ),
    LoginMethodData(
      name: "Facebook",
      backgroundColor: const Color(0xff4267B2),
      logoUrl: "https://charity.org/sites/charity.org/files/partner_logos/Facebook.png",
      onPressed: () {},
    ),
    LoginMethodData(
      name: "Instagram",
      backgroundColor: const Color(0xffE1306C),
      logoUrl: "https://i0.wp.com/davidmeessen.com/wp-content/uploads/2020/09/ew-instagram-logo-transparent-related-keywords-logo-instagram-vector-2017-115629178687gobkrzwak.png?ssl=1",
      onPressed: () {},
    ),
  ];
}