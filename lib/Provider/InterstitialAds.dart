import 'package:flutter/widgets.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../Constent/AdsInfo/AdunitsId.dart';

class InterstitialAds with ChangeNotifier {
  InterstitialAd? _interstitialAd = null;
  bool _isloading = false;

  void loadAd() {
    print('Loading Video add');
    InterstitialAd.load(
      adUnitId: AdunitsId.interstitial,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
          _isloading = false;
        },
        onAdFailedToLoad: (LoadAdError error) {
          _isloading = false;
          _interstitialAd = null;
        },
      ),
    );
  }

  void showInterstitial() async {
    if (_interstitialAd == null && _isloading == false) {
      _isloading = true;

      loadAd();
    } else {
      await _interstitialAd?.show();
      _interstitialAd = null;
    }
  }
}
