import 'package:flutter/material.dart';

import '../../../Constent/AppInfo/FontNames.dart';
import '../../../Constent/Colors/Apptheme.dart';

Widget PickFont({onchenge}) {
  return Container(
    height: 90,
    padding: const EdgeInsets.symmetric(vertical: 20),
    decoration: BoxDecoration(
      color: Apptheme.primary,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
    child: ListView.builder(
      itemCount: fontNames.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => onchenge(index),
          child: Container(
            width: 130,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            height: 40,
            decoration: BoxDecoration(
              color: Apptheme.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                fontNames[index].toString(),
                style: TextStyle(
                  fontFamily: fontNames[index].toString(),
                  fontSize: 12,
                ),
              ),
            ),
          ),
        );
      },
    ),
  );
}
