import 'package:flutter/material.dart';
import 'package:shayarispot2/Constent/Colors/Apptheme.dart';
import 'package:shayarispot2/Pages/HomePage.dart';
import 'Models/Storage/FavImagesLocalDb.dart';
import 'Models/Storage/FavLocalDb.dart';
import 'Models/Storage/LocalDb.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future delay() async {
    await Future.delayed(const Duration(milliseconds: 3000), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    });
  }

  @override
  void initState() {
    super.initState();
    LocalDatabase.instense;
    FavLocalDb.instense;
    FavImagesLocalDb.instense;
    delay();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Apptheme.splashColor,
      body: Center(
        child: Image.asset(
          'assets/splash.png',
          width: 280,
          height: 280,
        ),
      ),
    );
  }
}
