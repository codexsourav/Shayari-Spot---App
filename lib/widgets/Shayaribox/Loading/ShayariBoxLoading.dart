import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../Constent/Colors/Apptheme.dart';

Widget shayariboxloading(context) {
  return Shimmer.fromColors(
    baseColor: Apptheme.white,
    highlightColor: Apptheme.primary,
    child: Container(
        width: MediaQuery.of(context).size.width - 15,
        margin: EdgeInsets.only(bottom: 10, top: 10),
        height: 280,
        decoration: BoxDecoration(
          color: Apptheme.white,
          borderRadius: BorderRadius.circular(0),
        )),
  );
}
