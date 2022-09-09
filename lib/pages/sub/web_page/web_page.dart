import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/pages/base/app_bar.dart';
import 'package:restaurant_app/pages/base/menu_parameters.dart';
import "dart:ui" as ui;
import "dart:html";
import "package:restaurant_app/archived/location_data.dart";

import '../../base/app_state.dart';

class WebPage extends StatefulWidget {
  final CurrentLocationData locationData;
  const WebPage({Key? key, this.locationData = const CurrentLocationData()}) : super(key: key);


  @override
  _WebPageState createState() => _WebPageState();
}

class _WebPageState extends State<WebPage> {
  bool urlUpdated = false;
  String url = "test test";
  Map currentUrlParameters = {
    "LocationId" : "0",
    "TableId" : "0",
    "Token" : "0",
  };

  final IFrameElement _iFrameElement = IFrameElement();

  void openLandingPage() async {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    String url = updateUrl(newData: ModalRoute.of(context)!.settings.arguments);
    _iFrameElement.src = url;
    _iFrameElement.style.border = "none";
    _iFrameElement.style.height = "100%";
    _iFrameElement.style.width = "100%";
    ui.platformViewRegistry.registerViewFactory(
      "iFrameElement" + url,
      (int viewId) => _iFrameElement,
    );
    MenuParameters menuParametersProvider = Provider.of<MenuParameters>(context);
    AppState appStateProvider = Provider.of<AppState>(context);
    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: 50,
        child: Container(
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  spreadRadius: 8,
                  blurRadius: 15,
                  offset: const Offset(0, 0),
                ),
              ]
          ),
          child: ReturnBottomNavigation(child: appStateProvider.appModeActive && url.contains("https://admin.interactsuite.app/") ? BarButton(
            text: currentUrlParameters["istakeout"] is !String ? "Change Seat" : currentUrlParameters["istakeout"] == "1" ? "Change Location" : "Change Seat",
            disabled: false,
            onPressed: () {
              menuParametersProvider.seatId = null;
              menuParametersProvider.locationId = null;
              Navigator.pop(context);
            },
          ) : Container()) ,
        ),
      ),
      body: HtmlElementView(
        key: UniqueKey(),
        viewType: "iFrameElement" + url,
      ),
    );
  }


  String updateUrl({dynamic newData}){
    String url = newData is String ? newData : "";
    Map urlParameters = newData is Map ? newData : {};
    currentUrlParameters = urlParameters;
    //Reload url if url is different
    if(url != ""){
      return url;
    }
    else{
      String newUrl = "https://admin.interactsuite.app/?";
      urlParameters.forEach((parameter, value) {
        newUrl += parameter + "=" + value + "&";
      });
      newUrl = newUrl.substring(0, newUrl.length-1);

      //Update Url
      return newUrl;

    }
  }
}
