import 'package:flutter/material.dart';

import '../../Constent/Colors/Apptheme.dart';

void showSnackBar(BuildContext context, {text = '', ontap, btntext = 'OK'}) {
  final snackBar = SnackBar(
    duration: Duration(seconds: 1),
    content: Container(
      padding: const EdgeInsets.only(top: 5, bottom: 5, left: 20, right: 10),
      decoration: BoxDecoration(
        color: Apptheme.secendery,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text.toString()),
          TextButton(
            style: ButtonStyle(
              overlayColor: MaterialStateProperty.all(Colors.transparent),
            ),
            onPressed: ontap ??
                () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
            child: Text(btntext.toString()),
          ),
        ],
      ),
    ),
    backgroundColor: Colors.transparent,
    elevation: 0,
  );
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
