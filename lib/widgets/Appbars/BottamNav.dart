import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../Constent/Colors/Apptheme.dart';

Widget bottamNav({index, setindex}) {
  return BottomNavigationBar(
    onTap: setindex,
    currentIndex: index,
    backgroundColor: Apptheme.white,
    type: BottomNavigationBarType.fixed,
    elevation: 0,
    showSelectedLabels: false,
    showUnselectedLabels: false,
    iconSize: 18,
    selectedIconTheme: IconThemeData(
      color: Apptheme.secendery,
    ),
    unselectedIconTheme: IconThemeData(
      color: Apptheme.primaryDark,
    ),
    items: const [
      BottomNavigationBarItem(
        icon: Icon(
          FontAwesomeIcons.home,
        ),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: Icon(FontAwesomeIcons.bookOpenReader),
        label: 'List',
      ),
      BottomNavigationBarItem(
        icon: Icon(FontAwesomeIcons.paintbrush),
        label: 'Create',
      ),
      BottomNavigationBarItem(
        icon: Icon(FontAwesomeIcons.image),
        label: 'Images',
      ),
    ],
  );
}
