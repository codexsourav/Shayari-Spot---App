import 'package:flutter/material.dart';

import '../../Constent/AppInfo/FontNames.dart';
import '../../Constent/Colors/Apptheme.dart';
import 'Actions/ActionBtn.dart';

Widget EditorBottamBar(context, {ontap, alineindex = 0, idbold = false}) {
  return Container(
    height: 90,
    decoration: BoxDecoration(
      color: Apptheme.primary,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          actionBtn(
              icon: Icons.edit,
              text: "Text Edit",
              ontap: () {
                ontap(8);
              }),
          actionBtn(
              icon: Icons.text_fields_rounded,
              text: "Text Size",
              ontap: () {
                ontap(0);
              }),
          actionBtn(
              icon: alineTypsIcon[alineindex],
              text: "Text Aline",
              ontap: () {
                ontap(10);
              }),
          actionBtn(
              icon: Icons.format_indent_increase_rounded,
              text: "Padding",
              ontap: () {
                ontap(1);
              }),
          actionBtn(
              icon: Icons.format_bold_outlined,
              text: "Text Bold",
              ontap: () {
                ontap(11);
              }),
          actionBtn(
              icon: Icons.opacity_rounded,
              text: "Opacity",
              ontap: () {
                ontap(2);
              }),
          actionBtn(
              icon: Icons.blur_on_rounded,
              text: "Blur",
              ontap: () {
                ontap(3);
              }),
          actionBtn(
              icon: Icons.font_download_rounded,
              text: "Text Font",
              ontap: () {
                ontap(4);
              }),
          actionBtn(
              icon: Icons.color_lens,
              text: "Text Color",
              ontap: () {
                ontap(5);
              }),
          actionBtn(
              icon: Icons.image,
              text: "Image",
              ontap: () {
                ontap(6);
              }),
          actionBtn(
              icon: Icons.colorize_rounded,
              text: "Bg Color",
              ontap: () {
                ontap(7);
              }),
          actionBtn(
              icon: Icons.format_color_fill_rounded,
              text: "Gradient",
              ontap: () {
                ontap(9);
              }),
        ],
      ),
    ),
  );
}
