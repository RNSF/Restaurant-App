import "package:flutter/material.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";

import '../constants.dart';

Widget loginButton({Color color = Palette.lightOne, Color accentColor = Colors.blue, User? user}) {
  if(user == null) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 18*2,
          height: 18*2,
          child: Center(
            child: FaIcon(
              FontAwesomeIcons.google,
              size: 15*2,
              color: color,
            ),
          ),
        ),
        Text(
            "Login",
            style: TextStyle(
              color: color,
            )
        )
      ]
    );
  }
  else {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: accentColor,
            child: CircleAvatar(
              radius: 16,
              backgroundImage: NetworkImage(user.photoURL!),
            ),
          ),
          Text(
              "Logout",
              style: TextStyle(
                color: color,
              )
          )
        ]
    );
  }
}