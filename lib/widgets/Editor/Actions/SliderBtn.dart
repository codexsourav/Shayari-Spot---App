import 'package:flutter/material.dart';

import '../../../Constent/Colors/Apptheme.dart';

Widget SliderBtn({value, onchenge, double max = 100, double min = 0}) {
  return Container(
    height: 90,
    decoration: BoxDecoration(
      color: Apptheme.primary,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
    child: Slider(
        activeColor: Apptheme.primaryDark,
        inactiveColor: Apptheme.white,
        thumbColor: Apptheme.secendery,
        value: value,
        min: min,
        max: max,
        onChanged: (val) {
          onchenge(val);
        }),
  );
}
