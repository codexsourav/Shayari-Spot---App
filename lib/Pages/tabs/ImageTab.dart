import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shayarispot2/Constent/Colors/Apptheme.dart';
import 'package:shayarispot2/Provider/ImageScroll.dart';

import '../../Models/DataHelper/GetImageHelper.dart';
import '../../Provider/InterstitialAds.dart';
import '../../widgets/Appbars/SnackBar.dart';
import '../../widgets/ImageBox/ImageBox.dart';

class ImageTab extends StatefulWidget {
  ImageTab({super.key});

  @override
  State<ImageTab> createState() => _ImageTabState();
}

class _ImageTabState extends State<ImageTab> {
  var data = GetImageHelper();
  var showImage;

  setImages() async {
    var maindata = await data.getImageBase();

    if (maindata.length == 0) {
      setState(() {
        showImage = maindata;
      });
    } else {
      if (maindata[0] == 'error') {
        showSnackBar(context, text: maindata[1]);
        return false;
      } else {
        setState(() {
          showImage = maindata;
        });
      }
    }
  }

  refreshImages() async {
    var maindata = await data.refreshData();
    if (maindata[0] == 'error') {
      print('call error');
      showSnackBar(context, text: maindata[1]);
    } else {
      setState(() {
        showImage = maindata;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    var interstitial = Provider.of<InterstitialAds>(context, listen: false);
    interstitial.showInterstitial();
    setImages();
  }

  @override
  Widget build(BuildContext context) {
    var scrollindex = Provider.of<ImageScroll>(context);

    var controller = PageController(initialPage: scrollindex.index);
    return RefreshIndicator(
      color: Apptheme.secendery,
      onRefresh: () async {
        await refreshImages();
      },
      child: showImage != null
          ? showImage.isEmpty
              ? Center(
                  child: Text(
                    'No Data Found : (',
                    style: TextStyle(color: Apptheme.secendery),
                  ),
                )
              : PageView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: showImage.length,
                  controller: controller,
                  onPageChanged: (index) {
                    scrollindex.setIndex(index);
                  },
                  itemBuilder: (context, index) {
                    return ImageBox(
                      showImage: showImage[index],
                    );
                  },
                )
          : Center(
              child: CircularProgressIndicator(
                color: Apptheme.secendery,
              ),
            ),
    );
  }
}
