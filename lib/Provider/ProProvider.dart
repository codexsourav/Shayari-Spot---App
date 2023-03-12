import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../Constent/AdsInfo/AdunitsId.dart';

class ProProvider with ChangeNotifier {
  bool _ispro = false;
  bool get pro => _ispro;
  RewardedInterstitialAd? _rewardeInterstitialdAd = null;
  bool _isloading = false;

  void loadAd() {
    _isloading = true;
    print('Loading Reworded Ads');
    RewardedInterstitialAd.load(
        adUnitId: AdunitsId.reowrded,
        request: const AdRequest(),
        rewardedInterstitialAdLoadCallback: RewardedInterstitialAdLoadCallback(
          // Called when an ad is successfully received.
          onAdLoaded: (ad) {
            _rewardeInterstitialdAd = ad;
            _isloading = false;
            notifyListeners();
          },
          // Called when an ad request failed.
          onAdFailedToLoad: (LoadAdError error) {
            _isloading = false;
            _rewardeInterstitialdAd = null;
            notifyListeners();
          },
        ));
  }

  activePro() {
    if (_rewardeInterstitialdAd != null && _isloading == false) {
      _rewardeInterstitialdAd?.show(
          onUserEarnedReward: (AdWithoutView ad, RewardItem rewardItem) {
        _ispro = !_ispro;
        notifyListeners();
      });
    } else {
      loadAd();
      return false;
    }
  }
}
