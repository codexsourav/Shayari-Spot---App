import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:shayarispot2/Provider/BannerAdsProvider.dart';
import 'package:shayarispot2/Provider/PlayShayari.dart';
import 'package:shayarispot2/widgets/Shayaribox/ShayariBox.dart';
import '../Constent/AppInfo/FontNames.dart';
import '../Constent/Colors/Apptheme.dart';
import '../Models/DataHelper/DataHelper.dart';
import '../Provider/InterstitialAds.dart';
import '../widgets/Appbars/SnackBar.dart';
import '../widgets/Shayaribox/Loading/ShayariBoxLoading.dart';

class ShayariPage extends StatefulWidget {
  final title;
  const ShayariPage({super.key, this.title});

  @override
  State<ShayariPage> createState() => _ShayariPageState();
}

class _ShayariPageState extends State<ShayariPage> {
  List? lattestData;

  setData() async {
    var maindata = await DataHelper().getDataBase(fldname: widget.title);

    if (maindata.length == 0) {
      setState(() {
        lattestData = [];
      });
    } else if (maindata[0] == 'error') {
      // ignore: use_build_context_synchronously
      showSnackBar(context, text: maindata[1]);
    } else {
      setState(() {
        lattestData = maindata;
      });
    }
  }

  refreshData() async {
    var maindata = await DataHelper().refreshData(fldname: widget.title);
    if (maindata.length == 0) {
      setState(() {
        lattestData = [];
      });
    } else if (maindata[0] == 'error') {
      showSnackBar(context, text: maindata[1]);
    } else {
      setState(() {
        lattestData = maindata;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    setData();
    var banner = Provider.of<BannerAdsProvider>(context, listen: false);
    var interstitial = Provider.of<InterstitialAds>(context, listen: false);
    interstitial.showInterstitial();
    banner.loadBannerAd();
  }

  @override
  Widget build(BuildContext context) {
    var playState = context.watch<PlayShayari>();
    var interstitial = Provider.of<InterstitialAds>(context, listen: false);
    return WillPopScope(
      onWillPop: () async {
        interstitial.showInterstitial();
        if (playState.playerId != null) {
          playState.removePlayer();
          FlutterTts().stop();

          return true;
        } else {
          return true;
        }
      },
      child: Scaffold(
        backgroundColor: Apptheme.primary,
        appBar: AppBar(
          elevation: 0,
          title: Text(
            widget.title,
            style: TextStyle(fontFamily: fontNames[5], fontSize: 16),
          ),
          backgroundColor: Apptheme.splashColor,
        ),
        body: lattestData != null
            ? lattestData!.isEmpty
                ? Center(
                    child: Text(
                      'No Data Found : (',
                      style: TextStyle(color: Apptheme.secendery),
                    ),
                  )
                : RefreshIndicator(
                    color: Apptheme.secendery,
                    onRefresh: () async {
                      await refreshData();
                    },
                    child: ListView.builder(
                      itemCount: lattestData!.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: ShayariBox(shayatidata: lattestData![index]),
                        );
                      },
                    ),
                  )
            : ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Container(
                      width: 230,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 0),
                      child: shayariboxloading(context));
                },
              ),
        bottomNavigationBar: Consumer<BannerAdsProvider>(
          builder: (context, value, child) {
            return value.bannerAdshow != null
                ? SizedBox(
                    height: value.bannerAdshow?.size.height.toDouble(),
                    width: value.bannerAdshow?.size.width.toDouble(),
                    child: AdWidget(ad: value.bannerAdshow!),
                  )
                : const SizedBox(height: 0);
          },
        ),
      ),
    );
  }
}
