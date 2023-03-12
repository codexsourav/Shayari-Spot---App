import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../Constent/AppInfo/FontNames.dart';
import '../../Constent/Colors/Apptheme.dart';

@override
PreferredSizeWidget editorAppBar(context,
    {clickindex, loading, ispro = false}) {
  return AppBar(
    title: Text(
      'Shayari Editor',
      style: TextStyle(
          fontWeight: FontWeight.w400, fontFamily: fontNames[5], fontSize: 16),
    ),
    elevation: 0,
    backgroundColor: Apptheme.splashColor,
    actions: [
      IconButton(
        onPressed: ispro ? null : () => clickindex('pro'),
        icon: Icon(
          FontAwesomeIcons.crown,
          size: 18,
          color: ispro ? Colors.yellow : Apptheme.white,
        ),
      ),
      IconButton(
        onPressed: loading ? null : () => clickindex('save'),
        disabledColor: Apptheme.primaryDark,
        color: Apptheme.white,
        icon: Icon(
          FontAwesomeIcons.solidSave,
          size: 18,
        ),
      ),
      IconButton(
        onPressed: loading ? null : () => clickindex('share'),
        disabledColor: Apptheme.primaryDark,
        color: Apptheme.white,
        icon: Icon(
          FontAwesomeIcons.shareAlt,
          size: 18,
        ),
      )
    ],
  );
}
