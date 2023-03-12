import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Constent/Colors/Apptheme.dart';
import '../../Pages/ShayariPage.dart';
import '../../Provider/InterstitialAds.dart';

Widget cateBox(context, {lable = 'English', hidilable = 'Himdi', emoji}) {
  return GestureDetector(
    onTap: () {
      var interstitial = Provider.of<InterstitialAds>(context, listen: false);
      interstitial.showInterstitial();
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) {
            return ShayariPage(title: lable);
          },
        ),
      );
    },
    child: ClipRRect(
      child: Container(
        color: Apptheme.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              alignment: Alignment.topRight,
              width: 30,
              height: 30,
              margin: const EdgeInsets.only(top: 10, right: 10),
              decoration: BoxDecoration(
                  color: Apptheme.primary,
                  borderRadius: BorderRadius.circular(50)),
              child: Center(
                child: Text(emoji ?? '💌️'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12, bottom: 8, right: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          lable,
                          maxLines: 2,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            color: Apptheme.textDark,
                            fontWeight: FontWeight.w500,
                            fontSize: 13.5,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          hidilable,
                          style: TextStyle(
                            color: Apptheme.textGray,
                            fontWeight: FontWeight.w500,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 8, right: 10),
                    child: Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 12,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
