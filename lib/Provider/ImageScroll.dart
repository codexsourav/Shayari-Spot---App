import 'package:flutter/material.dart';

class ImageScroll with ChangeNotifier {
  var _showIndex = 0;

  int get index => _showIndex;

  setIndex(int pindex) {
    _showIndex = pindex;
    notifyListeners();
  }
}
