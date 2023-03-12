import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:shayarispot2/SplashScreen.dart';
import 'Constent/AppInfo/appInfo.dart';
import 'Provider/BannerAdsProvider.dart';
import 'Provider/ImageScroll.dart';
import 'Provider/InterstitialAds.dart';
import 'Provider/PlayShayari.dart';
import 'Provider/ProProvider.dart';

void main(List<String> args) {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PlayShayari()),
        ChangeNotifierProvider(create: (_) => ImageScroll()),
        ChangeNotifierProvider(create: (_) => ProProvider()),
        ChangeNotifierProvider(create: (_) => BannerAdsProvider()),
        ChangeNotifierProvider(create: (_) => InterstitialAds()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Appinfo.title,
      debugShowCheckedModeBanner: false,
      initialRoute: 'Home',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.white),
      ),
      home: const SplashScreen(),
    );
  }
}
