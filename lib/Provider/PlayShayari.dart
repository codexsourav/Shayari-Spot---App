import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class PlayShayari with ChangeNotifier {
  var _playId = null;

  get playerId => _playId;

  setPlayer({id}) {
    _playId = id;
    notifyListeners();
    FlutterTts().setCompletionHandler(() {
      _playId = null;
      notifyListeners();
    });
  }

  removePlayer() {
    _playId = null;
    notifyListeners();
  }
}
