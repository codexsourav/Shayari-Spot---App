import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:provider/provider.dart';
import 'package:shayarispot2/Provider/InterstitialAds.dart';
import 'package:shayarispot2/widgets/Shayaribox/Loading/CateLoading.dart';

import '../../Constent/Colors/Apptheme.dart';
import '../../Models/DataHelper/DataHelper.dart';
import '../../Provider/PlayShayari.dart';
import '../../widgets/Appbars/SnackBar.dart';
import '../../widgets/Shayaribox/CateBox.dart';

class CategoriesTab extends StatefulWidget {
  const CategoriesTab({super.key});

  @override
  State<CategoriesTab> createState() => _CategoriesTabState();
}

class _CategoriesTabState extends State<CategoriesTab> {
  List? catedata;

  setcategory() async {
    var data = await DataHelper().getDataBase();
    if (data[0] == 'error') {
      showSnackBar(context, text: data[1]);
    } else {
      setState(() {
        catedata = data;
      });
    }
  }

  refreshcategory() async {
    var data = await DataHelper().refreshData();
    if (data[0] == 'error') {
      showSnackBar(context, text: data[1]);
    } else {
      setState(() {
        catedata = data;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    setcategory();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        FlutterTts().stop();
        context.read<PlayShayari>().removePlayer();
        await refreshcategory();
      },
      color: Apptheme.secendery,
      child: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: (1 / .6),
        shrinkWrap: true,
        mainAxisSpacing: 10,
        padding: EdgeInsets.all(10),
        crossAxisSpacing: 10,
        children: catedata != null
            ? List.generate(catedata!.length, (index) {
                return cateBox(
                  context,
                  lable: catedata![index]["fields"]['english'],
                  hidilable: catedata![index]["fields"]['hindi'],
                  emoji: catedata![index]['fields']['emoji'],
                );
              })
            : List.generate(14, (index) {
                return cateLoading();
              }),
      ),
    );
  }
}
