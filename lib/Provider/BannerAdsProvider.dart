import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../Constent/AdsInfo/AdunitsId.dart';

class BannerAdsProvider with ChangeNotifier {
  BannerAd? _bannerAd = null;
  bool _isLoading = false;
  bool _isshow = true;
  int trycall = 0;

  BannerAd? get bannerAdshow => _bannerAd;

  callLoadBanner() {
    _bannerAd = BannerAd(
      adUnitId: AdunitsId.banner,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (Ad ad) {
          _isshow = false;
          _isLoading = false;
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (ad, err) {
          _bannerAd = null;
          notifyListeners();
          ad.dispose();
          _isshow = true;
          _isLoading = false;
        },
        onAdImpression: (ad) {
          _isshow = true;
        },
        onAdClosed: (Ad ad) {
          ad.dispose();
        },
      ),
    );
    _bannerAd?.load().then((value) {
      notifyListeners();
    }).catchError((e) {
      _bannerAd = null;
      notifyListeners();
    });
  }

  void loadBannerAd() async {
    if (_isLoading == false && _isshow == true) {
      _isLoading = true;
      callLoadBanner();
    }
  }
}
