import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:shayarispot2/Constent/Colors/Apptheme.dart';
import 'package:shayarispot2/Pages/tabs/FavTabs/FavImages.dart';

import '../Constent/AppInfo/FontNames.dart';
import '../Provider/BannerAdsProvider.dart';
import '../Provider/InterstitialAds.dart';
import 'tabs/FavTabs/FavShayari.dart';

class SavedPage extends StatefulWidget {
  const SavedPage({super.key});

  @override
  State<SavedPage> createState() => _SavedPageState();
}

class _SavedPageState extends State<SavedPage> {
  @override
  void initState() {
    super.initState();
    var interstitial = Provider.of<InterstitialAds>(context, listen: false);
    interstitial.showInterstitial();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        var interstitial = Provider.of<InterstitialAds>(context, listen: false);
        interstitial.showInterstitial();
        return true;
      },
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Apptheme.primary,
          appBar: AppBar(
            backgroundColor: Apptheme.splashColor,
            elevation: 0,
            bottom: TabBar(
              indicatorColor: Apptheme.white,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorWeight: 5,
              tabs: const [
                Tab(
                    icon: Icon(
                  FontAwesomeIcons.bookOpenReader,
                  size: 20,
                )),
                Tab(
                    icon: Icon(
                  FontAwesomeIcons.image,
                  size: 20,
                )),
              ],
            ),
            title: Text(
              'Your Favorite',
              style: TextStyle(fontFamily: fontNames[5], fontSize: 18),
            ),
          ),
          body: TabBarView(
            children: [
              const FavShayari(),
              FavImages(),
            ],
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
      ),
    );
  }
}
