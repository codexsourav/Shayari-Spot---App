import 'package:flutter/material.dart';

import '../../../Constent/Colors/Apptheme.dart';

Widget gredentColor({onchenge}) {
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
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          onTap: () => onchenge(0),
          child: Container(
            width: 130,
            margin: EdgeInsets.symmetric(horizontal: 10),
            height: 50,
            child: Center(
              child: Text(
                'First Color',
                style: TextStyle(fontSize: 13),
              ),
            ),
            decoration: BoxDecoration(
              color: Apptheme.white,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        GestureDetector(
          onTap: () => onchenge(1),
          child: Container(
            width: 120,
            margin: EdgeInsets.symmetric(horizontal: 10),
            height: 50,
            child: Center(
              child: Text(
                'Secend Color',
                style: TextStyle(fontSize: 13),
              ),
            ),
            decoration: BoxDecoration(
              color: Apptheme.white,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    ),
  );
}
