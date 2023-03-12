import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shayarispot2/Pages/EditorPage.dart';
import 'package:shayarispot2/widgets/Appbars/SnackBar.dart';
import 'package:shayarispot2/widgets/Editor/Actions/ActionBtn.dart';

import '../Constent/AdsInfo/AdunitsId.dart';
import '../Constent/AppInfo/FontNames.dart';
import '../Constent/AppInfo/appInfo.dart';
import '../Constent/Colors/Apptheme.dart';
import '../Provider/InterstitialAds.dart';

class notification extends StatefulWidget {
  final title;

  const notification({super.key, this.title});

  @override
  State<notification> createState() => _notificationState();
}

class _notificationState extends State<notification> {
  BannerAd? _bannerAd = null;
  bool isloaded = false;
  void loadAd() async {
    _bannerAd = BannerAd(
      adUnitId: AdunitsId.banner,
      request: const AdRequest(),
      size: AdSize.largeBanner,
      listener: BannerAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (ad) {
          setState(() {
            isloaded = true;
          });
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (ad, err) {
          setState(() {
            isloaded = false;
          });
        },
      ),
    );
    await _bannerAd?.load();
  }

  @override
  void initState() {
    super.initState();
    var interstitial = Provider.of<InterstitialAds>(context, listen: false);
    interstitial.showInterstitial();
    loadAd();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        var interstitial = Provider.of<InterstitialAds>(context, listen: false);
        interstitial.showInterstitial();
        return true;
      },
      child: Scaffold(
        backgroundColor: Apptheme.primary,
        appBar: AppBar(
          elevation: 0,
          title: Text(
            'For You Shayari',
            style: TextStyle(fontFamily: fontNames[5], fontSize: 16),
          ),
          backgroundColor: Apptheme.splashColor,
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              Center(
                child: Text(
                  widget.title.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Apptheme.textDark,
                  ),
                ),
              ),
              const Spacer(),
              _bannerAd != null
                  ? SizedBox(
                      height: AdSize.largeBanner.height.toDouble(),
                      width: AdSize.largeBanner.width.toDouble(),
                      child: AdWidget(ad: _bannerAd!),
                    )
                  : const SizedBox(height: 0),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          height: 80,
          color: Apptheme.white,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                actionBtn(
                    color: Apptheme.splashColor,
                    icon: FontAwesomeIcons.copy,
                    text: 'Copy',
                    ontap: () {
                      FlutterClipboard.copy(widget.title + Appinfo.shareTxt)
                          .then((value) {
                        showSnackBar(context, text: 'Copy To ClipBord');
                      });
                    }),
                actionBtn(
                    color: Apptheme.splashColor,
                    icon: FontAwesomeIcons.paintbrush,
                    text: 'Edit',
                    ontap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => EditorPage(text: widget.title),
                      ));
                    }),
                actionBtn(
                    color: Apptheme.splashColor,
                    icon: FontAwesomeIcons.shareAlt,
                    text: 'Share',
                    ontap: () async {
                      await Share.share(widget.title + Appinfo.shareTxt);
                    }),
              ]),
        ),
      ),
    );
  }
}
