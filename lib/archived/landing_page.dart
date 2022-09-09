import 'package:flutter/material.dart';
import "package:restaurant_app/archived/location_data.dart";
import 'package:restaurant_app/pages/main/home/promotional_material.dart';
import "package:firebase_auth/firebase_auth.dart";
import 'package:restaurant_app/archived/login_button.dart';
import "package:provider/provider.dart";
import 'package:restaurant_app/pages/sub/login/google_sign_in_provider.dart';
import 'package:restaurant_app/archived/title_banner.dart';

import '../constants.dart';



class LandingPage extends StatefulWidget {
  final CurrentLocationData locationData;
  const LandingPage({Key? key, this.locationData = const CurrentLocationData()}) : super(key: key);


  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {

  User? user = FirebaseAuth.instance.currentUser;
  String currentUserToken = "";
  bool loginPageOpened = false;

  Map idToToken = {
    "" : "",
    "ruY8f7BoUZVeZTDjbThBsrMWVp43" : "rwXvl7IzPpzMtm9t+YsGSHDyL5xa7StbwH7RsksFg8dpATO8lnPji8vWtH7ROq2ohOT/u1b6Rnr2KEYg1oDXKipO4zJBTHMj0RLfSgEgrKG9PMqCQ+LA/2MUro5pke4EMnYwuLFx2vKe7lvBAmE9nzwlUqS1xfO9t6Sd+GwM1OQ=",
    "5gz6xmT7arWqNEqcZ5BwhJgqTD23" : "9WWfXeiwNxC+GjNBmu8pBeh+9m8xNJ4Y3kqLKKQG0ecFxpL3RScXlm2bZqVec32JBrzc79SdEiU0Hd4SQOCNk26ivxHC0dNA1TlWBnFfLTC3oOz/LYasSr8xR3YITI09IZH/mef7mq4qSQtEJo4PI6NWWBM1D5z711Gcpv5wEg4=",
  };

  BoxDecoration generateBackgroundImage(String path) {
    return BoxDecoration(
      image: DecorationImage(
        image: AssetImage(path),
        fit: BoxFit.cover,
      ),
    );
  }

  List<PromotionalMaterial> promotionalMaterials = [
    const PromotionalMaterial(title: "Super Cool Food",
        description: "It really is amazing! Test Test Test Test Test Test Test Test Test Test Test Test Test Test",
        url: "https://www.glowbalgroup.com/italiankitchen/"),
    const PromotionalMaterial(title: "Fresh Ingredients",
        description: "And local too!",
        url: "https://www.glowbalgroup.com/italiankitchen/"),
    const PromotionalMaterial(title: "New Special!",
        description: "Only available this week!",
        url: "https://www.glowbalgroup.com/italiankitchen/"),
  ];

  void openOrderingPage({bool first = true, String link = "", Map urlParameters = const {}}) async {
    final passThroughData = (link != "")? link : urlParameters;

    if(first){
      if(!loginPageOpened){
        await openLoginPage();
        urlParameters["Token"] = currentUserToken;
      }
      if(passThroughData is Map){
        passThroughData["LocationId"] = widget.locationData.restaurantId.toString();
        passThroughData["TableId"] = widget.locationData.table.toString();
      }
      Navigator.pushReplacementNamed(context, "/ordering_page", arguments: passThroughData);
    }
    else  {
      Navigator.pop(context, passThroughData);
    }
  }

  String getUserToken({String userId = ""}) {
    if(idToToken.containsKey(userId)){
      return idToToken[userId];
    }
    return "";
  }

  Future<void> openLoginPage() async {
    dynamic result = await Navigator.pushNamed(context, "/google_oauth_page");
    user = result is User? result : null;
    if(user != null){
      User u = user as User;
      currentUserToken = getUserToken(userId: u.uid);
    } else {
      currentUserToken = "";
    }

    loginPageOpened = true;
    setState(() {});


  }
  @override
  void initState() {
    super.initState();
    if(user != null){
      User u = user as User;
      currentUserToken = getUserToken(userId: u.uid);
    } else {
      currentUserToken = "";
    }
  }

  //Data sent in from other pages
  Map data = {};

  //Is this the first time opening the landing page
  bool firstTime = true;

  //Build
  @override
  Widget build(BuildContext context) {

    //Read in data
    data = ModalRoute.of(context)!.settings.arguments != null ? ModalRoute.of(context)!.settings.arguments as Map : data;
    firstTime = data.containsKey("first_time") ? data["first_time"] : firstTime;

    //Page
    return Scaffold(
        body: Stack(
            children: [
              Stack(
                children: [
                  Container(
                    decoration: generateBackgroundImage(
                        "assets/images/landing_background.jpg"),
                    ),
                    Container(
                        decoration: generateBackgroundImage(
                            "assets/images/vignette.png"),
                        child: Container(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              "table id: ${widget.locationData.table}",
                              style: const TextStyle(
                                color: Palette.lightOne,
                              ),
                            )
                        )
                    ),
                ],
              ),

              SafeArea(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Container()
                        ),
                        Text(
                            "Welcome to",
                            style: TextStyle(
                              fontFamily: "OpenSans",
                              fontSize: 30.0,
                              fontStyle: FontStyle.italic,
                              color: Palette.lightOne,
                              shadows: <Shadow>[
                                basicShadow
                              ],
                            )
                        ),
                        const SizedBox(height: 8.0),
                        TitleBanner(titleText: widget.locationData.restuarantName),
                        const SizedBox(
                          height: 40.0,
                          child: SizedBox(
                            width: 390,
                            child: Divider(
                              color: Palette.lightOne,
                              thickness: 3.0,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 8,
                          child: SizedBox(
                            width: 400,
                            child: ListView.builder(
                              itemCount: promotionalMaterials.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
                                  child: InkWell(
                                    onTap: () {
                                      //openOrderingPage(first: firstTime, link: promotionalMaterials[index].url, urlParameters: {"Token" : currentUserToken});
                                    },
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                      ),
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 100,
                                            decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)),
                                              /*image: DecorationImage(
                                                colorFilter: const ColorFilter.mode(
                                                  Colors.black26,
                                                  BlendMode.multiply,
                                                ),

                                                image: AssetImage(
                                                    "assets/images/${promotionalMaterials[index]
                                                        .backgroundImage}"),
                                                fit: BoxFit.cover,
                                              )*/
                                            ),
                                            child: Stack(
                                              children: [
                                                Opacity(
                                                  opacity: 0.4,
                                                  child: Container(
                                                    decoration: const BoxDecoration(
                                                      borderRadius: BorderRadius
                                                          .all(
                                                          Radius.circular(
                                                              20)),
                                                      image: DecorationImage(
                                                        image: AssetImage(
                                                            "assets/images/vignette.png"),
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  transformAlignment: Alignment
                                                      .topRight,

                                                  decoration: BoxDecoration(
                                                    color: Colors.black.withOpacity(0.4),
                                                    borderRadius: const BorderRadius.only(
                                                      topRight: Radius.circular(20),
                                                      bottomRight: Radius.circular(20),
                                                      topLeft: Radius.circular(20),

                                                        ),
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 5.0,
                                                        horizontal: 15.0),
                                                    child: Text(
                                                        promotionalMaterials[index]
                                                            .title,
                                                        style: const TextStyle(
                                                            color: Colors
                                                                .white,
                                                            fontSize: 25.0,
                                                            fontWeight: FontWeight.bold,
                                                            fontStyle: FontStyle.italic,
                                                            letterSpacing: 1.0,
                                                      )
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),

                                          Container(
                                            alignment: Alignment.bottomLeft,
                                            decoration: BoxDecoration(
                                              borderRadius: const BorderRadius.all(
                                                  Radius.circular(20)),
                                              color: Palette.lightOne.withOpacity(0.95),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                                              child: Text(
                                                  promotionalMaterials[index]
                                                      .description,
                                                  style: const TextStyle(
                                                    color: Colors.black87,
                                                    fontFamily: "OpenSans"
                                                  )
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }
                            ),
                          ),
                        ),
                        /*
                  Image(
                    image: AssetImage("assets/images/logo.png"),
                    width: 100.0,
                    height: 100.0,
                  ),
                   */
                        const Expanded(
                          flex: 2,
                          child: SizedBox(
                            height: 40.0,
                            child: SizedBox(
                              width: 390,
                              child: Divider(
                                color: Palette.lightOne,
                                thickness: 3.0,
                              ),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            openOrderingPage(first: firstTime, urlParameters: {"Token" : currentUserToken});
                          },
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).colorScheme.secondary),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(borderRadius: BorderRadius.circular(500.0)),
                              )
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 30.0),
                            child: Text(
                                "ORDER",
                                style: TextStyle(
                                  color: Palette.lightOne,
                                  letterSpacing: 1.5,
                                  fontSize: 30.0,
                                )
                            ),
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: InkWell(
                                onTap: () {
                                  if(user == null){
                                    openLoginPage();
                                  } else {
                                    final provider = Provider.of<GoogleLogIn>(context, listen: false);
                                    provider.googleLogout();
                                    setState(() {
                                      user = null;
                                      currentUserToken = "";
                                    });
                                  }
                                },
                                child: SizedBox(
                                  width: 60,
                                  child: Center(
                                    child: loginButton(
                                      color: Theme.of(context).colorScheme.primary,
                                      accentColor: Theme.of(context).colorScheme.secondary,
                                      user: user,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                      ],
                    ),
                  )
              )
            ]
        )
    );
  }
}