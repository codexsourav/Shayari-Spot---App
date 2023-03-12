import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:shayarispot2/Constent/Colors/Apptheme.dart';

import '../../../Models/DataHelper/GetImageHelper.dart';

import '../../../Models/Storage/FavImagesLocalDb.dart';
import '../../../widgets/ImageBox/ImageBox.dart';

class FavImages extends StatefulWidget {
  FavImages({super.key});

  @override
  State<FavImages> createState() => _FavImagesState();
}

class _FavImagesState extends State<FavImages> {
  var showImage;
  var favLocalDb = FavImagesLocalDb.instense;

  setFavData() async {
    var data = await favLocalDb.getSaved();
    setState(() {
      showImage = data;
    });
  }

  @override
  void initState() {
    super.initState();
    setFavData();
  }

  @override
  Widget build(BuildContext context) {
    return showImage != null
        ? showImage.isEmpty
            ? Center(
                child: Text(
                  'No Favorite Found : (',
                  style: TextStyle(color: Apptheme.secendery),
                ),
              )
            : PageView(
                scrollDirection: Axis.vertical,
                children: List.generate(showImage.length, (index) {
                  return ImageBox(
                    showImage: showImage[index],
                  );
                }),
              )
        : Center(
            child: CircularProgressIndicator(
              color: Apptheme.secendery,
            ),
          );
  }
}
