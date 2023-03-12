import 'package:flutter/material.dart';
import 'package:shayarispot2/Constent/Colors/Apptheme.dart';
import '../../Models/DataHelper/DataHelper.dart';
import '../../widgets/Appbars/SnackBar.dart';
import '../../widgets/Shayaribox/CateBox.dart';
import '../../widgets/Shayaribox/Loading/CateLoading.dart';
import '../../widgets/Shayaribox/Loading/ShayariBoxLoading.dart';
import '../../widgets/Shayaribox/ShayariBox.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  var dataHelper = DataHelper();
  List? catedata;
  List? lattestData;

  setcategory() async {
    var data = await dataHelper.getDataBase(fldname: 'Public');
    var maindata = await dataHelper.getDataBase(fldname: 'Lattest');
    if (data[0] == 'error' || maindata[0] == 'error') {
      showSnackBar(context, text: data[1]);
    } else {
      setState(() {
        catedata = data;
        lattestData = maindata;
      });
    }
  }

  refreshPage() async {
    var data = await dataHelper.refreshData(fldname: 'Public');
    var maindata = await dataHelper.refreshData(fldname: 'Lattest');

    if (data[0] == 'error' || maindata[0] == 'error') {
      showSnackBar(context, text: data[1]);
    } else {
      setState(() {
        catedata = data;
        lattestData = maindata;
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
      color: Apptheme.secendery,
      onRefresh: () async {
        await refreshPage();
      },
      child: SingleChildScrollView(
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 15),
              SizedBox(
                height: 110,
                child: catedata != null
                    ? ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: catedata!.length,
                        padding: EdgeInsets.symmetric(horizontal: 7.5),
                        itemBuilder: (context, index) {
                          return Container(
                            width: 215,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 7.5, vertical: 0),
                            child: cateBox(
                              context,
                              lable: catedata![index]["fields"]['english'],
                              hidilable: catedata![index]["fields"]['hindi'],
                              emoji: catedata![index]['fields']['emoji'],
                            ),
                          );
                        },
                      )
                    : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        padding: EdgeInsets.symmetric(horizontal: 7.5),
                        itemBuilder: (context, index) => Container(
                          width: 215,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 7.5, vertical: 0),
                          child: cateLoading(),
                        ),
                      ),
              ),
              const SizedBox(height: 5),
              Flexible(
                child: lattestData != null
                    ? ListView.builder(
                        scrollDirection: Axis.vertical,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: lattestData!.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: ShayariBox(shayatidata: lattestData![index]),
                          );
                        },
                      )
                    : ListView.builder(
                        scrollDirection: Axis.vertical,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 10,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Container(
                              width: 230,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 0),
                              child: shayariboxloading(context));
                        },
                      ),
              )
            ]),
      ),
    );
  }
}
