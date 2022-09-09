import 'package:flutter/material.dart';
import 'package:restaurant_app/pages/main/home/promotion_data.dart';
import "package:restaurant_app/pages/main/main_page_base.dart";
import 'package:restaurant_app/pages/main/home/promotional_material.dart';

import '../../../constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  @override
  Widget build(BuildContext context) {
    return MainPageBase(
      title: "Welcome",
      backgroundImage: const AssetImage("images/landing_background.jpg"),
      child: Center(
        child: Column(
          children: [
            const DividingBar(),
            Expanded(
              flex: 1,
              child: SizedBox(
                width: 320,
                child: ListView.builder(
                  itemCount: promotionalMaterialDatas.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    PromotionalMaterialData data = promotionalMaterialDatas[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                      child: PromotionalMaterial(
                        title: data.title,
                        imageUrl: data.imageUrl,
                        url: data.url,
                        description: data.description,
                        alignment: data.alignment,
                      ),
                    );
                  }
                ),
              ),
            ),
            const DividingBar(),
          ],
        ),
      )
    );
  }
}

class DividingBar extends StatelessWidget {

  const DividingBar({Key? key}) : super(key: key);

  @override
  build(context) {
    return const SizedBox(
      height: 30.0,
      child: SizedBox(
        width: 300,
        child: Divider(
          color: Palette.lightOne,
          thickness: 4.0,
        ),
      ),
    );
  }
}
