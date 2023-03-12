import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../../Constent/Colors/Apptheme.dart';

Widget cateLoading() {
  return Shimmer.fromColors(
    baseColor: Apptheme.white,
    highlightColor: Apptheme.primary,
    child: Container(
      color: Apptheme.white,
    ),
  );
}
