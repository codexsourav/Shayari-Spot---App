import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shayarispot2/Constent/Colors/Apptheme.dart';

import '../../../Provider/InterstitialAds.dart';

showAlertExitDialog(BuildContext context) {
  var interstitial = Provider.of<InterstitialAds>(context, listen: false);
  // set up the button
  Widget okButton = TextButton(
    style: ButtonStyle(
      overlayColor: MaterialStateProperty.all(Colors.transparent),
    ),
    child: Text(
      "Yes",
      style: TextStyle(color: Apptheme.textDark),
    ),
    onPressed: () {
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      interstitial.showInterstitial();
    },
  );
  Widget noButton = TextButton(
    style: ButtonStyle(
      overlayColor: MaterialStateProperty.all(Colors.transparent),
    ),
    child: Text(
      "No",
      style: TextStyle(color: Apptheme.textDark),
    ),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    elevation: 0,
    title: Text("Go Back"),
    content: Text("Are You Sure Exit Editor ?"),
    actions: [
      noButton,
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
