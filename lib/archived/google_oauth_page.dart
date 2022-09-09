import 'package:flutter/material.dart';
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import 'package:restaurant_app/pages/sub/login/google_sign_in_provider.dart';
import "package:provider/provider.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:restaurant_app/archived/location_data.dart";
import 'package:restaurant_app/archived/title_banner.dart';

class GoogleOAuthPage extends StatefulWidget {

  final CurrentLocationData locationData;
  const GoogleOAuthPage({Key? key, this.locationData = const CurrentLocationData()}) : super(key: key);


  @override
  _GoogleOAuthPageState createState() => _GoogleOAuthPageState();
}

class _GoogleOAuthPageState extends State<GoogleOAuthPage> {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          User user = FirebaseAuth.instance.currentUser!;
          Navigator.pop(context, user);
        } else if (snapshot.hasError) {
          return const Center(child: Text("Error! Can't Sign In."));
        }
        return Scaffold(
          backgroundColor: Colors.grey[350],
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Expanded(flex: 6, child: SizedBox(height: 60)),
                TitleBanner(
                  titleText: widget.locationData.restuarantName,
                ),
                const Expanded(flex: 5, child: SizedBox(height: 50)),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: FaIcon(
                    FontAwesomeIcons.google,
                    size: 150.0,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                Text(
                  "Sign in with Google",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Expanded(flex: 4, child: SizedBox(height: 40)),
                ElevatedButton(
                  onPressed: () {
                    final provider = Provider.of<GoogleLogIn>(context, listen: false);
                    provider.googleLogin();
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).colorScheme.secondary),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(500.0)),
                    )
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 36.0),
                    child: Text(
                      "Sign In",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      )
                    ),
                  ),
                ),
                const Expanded(flex: 2, child: SizedBox(height: 20)),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Theme.of(context).colorScheme.primary,
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(500.0)),
                    ),
                  ),

                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 18.0),
                    child: Text(
                      "Skip",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      )
                    ),
                  ),
                ),
                const Expanded(flex: 6, child: SizedBox(height: 60)),

              ],
            ),
          )
        );


      }
    );
  }
}
