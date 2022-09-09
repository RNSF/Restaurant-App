import "dart:ui" as ui;
import 'dart:html';
import 'package:flutter/material.dart';
import "package:restaurant_app/archived/location_data.dart";

class OrderingPage extends StatefulWidget {
  final CurrentLocationData locationData;
  const OrderingPage({Key? key, this.locationData = const CurrentLocationData()}) : super(key: key);


  @override
  _OrderingPageState createState() => _OrderingPageState();
}

class _OrderingPageState extends State<OrderingPage> {
  bool urlUpdated = false;
  String url = "test test";
  Map currentUrlParameters = {
    "locationid" : "",
    "tableid" : "",
    "token" : "0",
  };

  final IFrameElement _iFrameElement = IFrameElement();

  void updateUrl({dynamic newData}){
    String url = newData is String ? newData : "";
    Map urlParameters = newData is Map ? newData : {};
    //Reload url if url is different
    if(url != ""){
      _iFrameElement.src = url;
      setState(() {});
    }
    else{
      if(urlParameters.isNotEmpty){
        bool needUpdate = false;
        urlParameters.forEach((key, value) {
          if(value != currentUrlParameters[key]){
            needUpdate = true;
            currentUrlParameters[key] = value;
          }
        });
        if(needUpdate){
          setState(() {
            urlUpdated = true;
            if(currentUrlParameters["Token"] != ""){
              _iFrameElement.src = "https://admin.interactsuite.app/?locationid=${currentUrlParameters["LocationId"]}&tableid=${currentUrlParameters["TableId"]}&token=${currentUrlParameters["Token"]}#logon40004";
            } else {
              _iFrameElement.src = "https://admin.interactsuite.app/?locationid=${currentUrlParameters["LocationId"]}&tableid=${currentUrlParameters["TableId"]}";
            }

          });
        }
      }
    }


  }

  void openLandingPage() async {
    dynamic result = await Navigator.pushNamed(context, "/landing_page", arguments: {"first_time" : false} );
    updateUrl(newData: result);
  }

  @override
  void initState() {
    super.initState();
    _iFrameElement.style.border = "none";
    _iFrameElement.style.height = "100%";
    _iFrameElement.style.width = "100%";
    ui.platformViewRegistry.registerViewFactory(
      "iFrameElement",
        (int viewId) => _iFrameElement
    );
  }


  @override
  Widget build(BuildContext context) {
    if(!urlUpdated){
      updateUrl(newData: ModalRoute.of(context)!.settings.arguments);
    } else {
      urlUpdated = false;
    }

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
          child: AppBar(
            backgroundColor: Theme.of(context).colorScheme.secondary,
            leading: IconButton(onPressed: () {openLandingPage();}, icon: const Icon(Icons.arrow_back)),
          ),
        ),
      ),
      body: HtmlElementView(
        key: UniqueKey(),
        viewType: "iFrameElement",
      ),
    );
  }
}
