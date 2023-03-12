import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shayarispot2/Constent/AppInfo/FontNames.dart';
import '../../Constent/Colors/Apptheme.dart';
import '../../Pages/SavedPage.dart';

PreferredSizeWidget myAppBar(context, {title = 'Shayari Spot'}) {
  return AppBar(
    backgroundColor: Apptheme.splashColor,
    elevation: 0.0,
    centerTitle: true,
    title: Text(
      title,
      style: TextStyle(
          color: Apptheme.textLight, fontSize: 14, fontFamily: fontNames[5]),
    ),
    actions: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: IconButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const SavedPage(),
            ));
          },
          icon: const Icon(
            FontAwesomeIcons.solidHeart,
            size: 19,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: IconButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const SavedPage(),
            ));
          },
          icon: const Icon(
            FontAwesomeIcons.whatsapp,
            size: 19,
          ),
        ),
      ),
    ],
  );
}
