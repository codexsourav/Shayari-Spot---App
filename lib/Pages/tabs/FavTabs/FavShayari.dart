import 'package:flutter/material.dart';
import 'package:shayarispot2/Models/Storage/FavLocalDb.dart';

import '../../../Constent/Colors/Apptheme.dart';
import '../../../widgets/Shayaribox/Loading/ShayariBoxLoading.dart';
import '../../../widgets/Shayaribox/ShayariBox.dart';

class FavShayari extends StatefulWidget {
  const FavShayari({super.key});

  @override
  State<FavShayari> createState() => _FavShayariState();
}

class _FavShayariState extends State<FavShayari> {
  var favData;
  var favLocalDb = FavLocalDb.instense;

  setFavData() async {
    var data = await favLocalDb.getSaved();
    setState(() {
      favData = data;
    });
  }

  @override
  void initState() {
    super.initState();
    setFavData();
  }

  @override
  Widget build(BuildContext context) {
    return favData == null
        ? ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return Container(
                  width: 230,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                  child: shayariboxloading(context));
            },
          )
        : favData.length == 0
            ? Center(
                child: Text(
                  'No Favorite Found : (',
                  style: TextStyle(color: Apptheme.secendery),
                ),
              )
            : SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: List.generate(favData.length, (index) {
                      return ShayariBox(
                        shayatidata: favData[index],
                      );
                    }),
                  ),
                ),
              );
  }
}
