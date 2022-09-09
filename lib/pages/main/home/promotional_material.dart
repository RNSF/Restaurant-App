import "package:flutter/material.dart";

import '../../../constants.dart';

enum PromotionalMaterialAlignment {
  right,
  left,
}

class PromotionalMaterialData {
  final String title;
  final String imageUrl;
  final String url;
  final String description;
  final PromotionalMaterialAlignment alignment;

  PromotionalMaterialData({this.title = "", this.description = "", this.imageUrl = "", this.url = "", this.alignment = PromotionalMaterialAlignment.left});
}

class PromotionalMaterial extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String url;
  final String description;
  final PromotionalMaterialAlignment alignment;
  static const Radius radius = Radius.circular(20);

  const PromotionalMaterial({Key? key, this.title = "", this.imageUrl = "", this.url = "", this.description = "", this.alignment = PromotionalMaterialAlignment.left}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(context),
      child: Container(
        decoration: const BoxDecoration(
          color: Palette.lightOne,
          borderRadius: BorderRadius.all(PromotionalMaterial.radius),
        ),
        child: IntrinsicHeight(
          child: Row(
            textDirection: (alignment == PromotionalMaterialAlignment.left) ? TextDirection.ltr : TextDirection.rtl,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 6,
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                  child: Column(
                    children:[
                      Text(
                        title,
                        textAlign: (alignment == PromotionalMaterialAlignment.left) ? TextAlign.left : TextAlign.right,
                        style: const TextStyle(
                          color: Palette.accent,
                          fontWeight: FontWeight.bold,
                          fontSize: FontSize.body,
                        ),
                      ),
                      Text(
                        description,
                        textAlign: (alignment == PromotionalMaterialAlignment.left) ? TextAlign.left : TextAlign.right,
                        style: const TextStyle(
                          color: Palette.darkOne,
                          fontSize: FontSize.body,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: (alignment == PromotionalMaterialAlignment.left) ?
                        const BorderRadius.only(topRight: PromotionalMaterial.radius, bottomRight: PromotionalMaterial.radius) :
                        const BorderRadius.only(topLeft: PromotionalMaterial.radius, bottomLeft: PromotionalMaterial.radius),
                    image: DecorationImage(
                      image: NetworkImage(imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ]
          ),
        )
      ),
    );
  }

  void onTap(BuildContext context) {
    //Navigator.pushNamed(context, widget.pagePath);
    Navigator.pushNamed(context, "/web_page", arguments: url);
  }
}

