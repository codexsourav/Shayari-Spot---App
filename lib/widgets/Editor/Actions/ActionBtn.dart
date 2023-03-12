import 'package:flutter/material.dart';

import '../../../Constent/Colors/Apptheme.dart';

Widget actionBtn({icon, text, ontap, color}) {
  return GestureDetector(
    onTap: ontap,
    child: Container(
      color: Colors.transparent,
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 22,
            color: color ?? Apptheme.textDark,
          ),
          SizedBox(height: 3),
          Text(
            text,
            style: TextStyle(
              fontSize: 9,
              color: color ?? Apptheme.textDark,
            ),
          ),
        ],
      ),
    ),
  );
}
