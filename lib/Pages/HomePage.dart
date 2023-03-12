import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shayarispot2/Constent/AppInfo/appInfo.dart';
import 'package:shayarispot2/Pages/EditorPage.dart';

import '../Constent/AppContentList/Tabs.dart';
import '../Constent/Colors/Apptheme.dart';

import '../Provider/InterstitialAds.dart';
import '../Provider/PlayShayari.dart';
import '../widgets/Appbars/BottamNav.dart';
import '../widgets/Appbars/MyAppBar.dart';
import '../widgets/Drawer/Appdrawer.dart';
import 'notification.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int tabindex = 0;

  // settabindex here
  onbottamclick(index) {
    var interstitial = Provider.of<InterstitialAds>(context, listen: false);
    interstitial.showInterstitial();

    var playState = context.read<PlayShayari>();
    if (playState.playerId != null) {
      FlutterTts().stop();
      playState.removePlayer();
    }
    if (index == 2) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const EditorPage(),
        ),
      );
    } else {
      setState(() {
        tabindex = index;
      });
    }
  }

// on page pop
  Future<bool> tryPop() async {
    if (tabindex != 0) {
      setState(() {
        tabindex = 0;
      });
      return false;
    } else {
      return true;
    }
  }

// title for appbar
  List titlesTabs = [
    Appinfo.title.toUpperCase(),
    "All Categorys".toUpperCase(),
    "Shayari Spot",
    "Image Shayari".toUpperCase()
  ];

  @override
  void initState() {
    super.initState();

    configOneSigal();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: tryPop,
      child: Scaffold(
        backgroundColor: Apptheme.primary,
        appBar: myAppBar(context, title: titlesTabs[tabindex]),
        drawer: AppDrawer(context, onclick: onbottamclick, tabindex: tabindex),
        body: tabsPages[tabindex],
        bottomNavigationBar:
            bottamNav(index: tabindex, setindex: onbottamclick),
      ),
    );
  }

// for notification
  // config one signal
  configOneSigal() async {
    await OneSignal.shared.setAppId(Appinfo.oneSignalId);
    OneSignal.shared.setNotificationWillShowInForegroundHandler((event) {
      OSNotificationDisplayType.notification;
    });
    OneSignal.shared.setNotificationOpenedHandler(
      (OSNotificationOpenedResult result) async {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) =>
                notification(title: result.notification.body.toString()),
          ),
        );
      },
    );
  }
}
