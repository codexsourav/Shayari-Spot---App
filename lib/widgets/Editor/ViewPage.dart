import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import '../../Constent/AppInfo/FontNames.dart';
import '../../Constent/Colors/Apptheme.dart';
import 'Watermark.dart';

Widget viewPage(
  context, {
  String text = '',
  double? textsize,
  int? fontindex,
  Color? textcolor,
  double? padding,
  double? blur = 0,
  double? opacity,
  Color? bgcolor,
  bool showatermark = true,
  String? imgPath,
  var gradient,
  int alineindex = 0,
  isbold = false,
}) {
  return Container(
    color: Colors.black,
    child: ClipRRect(
      child: Container(
        width: MediaQuery.of(context).size.width - 30,
        height: MediaQuery.of(context).size.height - 280,
        decoration: BoxDecoration(
          color: Colors.black,
          image: imgPath != null
              ? DecorationImage(
                  image: FileImage(File(imgPath)),
                  fit: BoxFit.cover,
                )
              : null,
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blur ?? 0, sigmaY: blur ?? 0),
          child: Container(
            decoration: BoxDecoration(
              color: bgcolor?.withOpacity(opacity ?? 1),
              gradient: gradient != null
                  ? LinearGradient(
                      colors: gradient,
                      begin: const FractionalOffset(0.0, 0.0),
                      end: const FractionalOffset(1.0, 0.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp,
                    )
                  : null,
            ),
            child: Stack(
              children: [
                InteractiveViewer(
                  panEnabled: true,
                  maxScale: 10,
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: padding ?? 20),
                      child: Text(
                        text.isEmpty ? "Write Here.." : text,
                        textAlign: alineTyps[alineindex],
                        style: TextStyle(
                          color: textcolor ?? Apptheme.textLight,
                          fontWeight: isbold ? FontWeight.bold : null,
                          fontSize: textsize,
                          fontFamily:
                              fontindex != null ? fontNames[fontindex] : null,
                        ),
                      ),
                    ),
                  ),
                ),
                showatermark ? const SizedBox(height: 0) : watermark(),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
