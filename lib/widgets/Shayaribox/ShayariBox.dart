import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shayarispot2/Pages/EditorPage.dart';
import 'package:shayarispot2/widgets/Appbars/SnackBar.dart';

import '../../Constent/AppInfo/appInfo.dart';
import '../../Constent/Colors/Apptheme.dart';

import '../../Models/Storage/FavLocalDb.dart';
import '../../Provider/PlayShayari.dart';

class ShayariBox extends StatefulWidget {
  final shayatidata;
  ShayariBox({super.key, this.shayatidata});

  @override
  State<ShayariBox> createState() => _ShayariBoxState();
}

class _ShayariBoxState extends State<ShayariBox> {
  var localstorage = FavLocalDb.instense;

  final flutterTts = FlutterTts();
  String shayatitxt = '';
  bool isfav = false;

  var _playid;

// add or remove favirate
  addremoveFav(sid) {
    if (isfav) {
      localstorage.deleteData(sid);
      setState(() {
        isfav = false;
      });
    } else {
      localstorage.addSaved(widget.shayatidata);
      setState(() {
        isfav = true;
      });
    }
  }

// chack if fav exist
  setFav(sid) async {
    var res = await localstorage.chackexistondb(sid);

    if (res == sid) {
      setState(() {
        isfav = true;
      });
    } else {
      setState(() {
        isfav = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    shayatitxt = widget.shayatidata['fields']['text'];
    setFav(widget.shayatidata['id']);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var provaide = Provider.of<PlayShayari>(context, listen: true);
    // play shayari
    playShayari() async {
      if (widget.shayatidata['id'] == provaide.playerId) {
        flutterTts.stop();
        provaide.removePlayer();
      } else {
        provaide.setPlayer(id: widget.shayatidata['id']);
        flutterTts.speak(shayatitxt);
      }
    }

    return Container(
      width: MediaQuery.of(context).size.width - 15,
      margin: EdgeInsets.only(bottom: 10, top: 10),
      height: 280,
      decoration: BoxDecoration(
        color: Apptheme.white,
        borderRadius: BorderRadius.circular(0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 50,
            padding: const EdgeInsets.only(top: 15, left: 15),
            alignment: Alignment.topLeft,
            child: Image.asset(
              'assets/love.png',
              height: 35,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              shayatitxt.toString(),
              textAlign: TextAlign.center,
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Apptheme.textDark,
                fontSize: 18,
              ),
            ),
          ),
          SizedBox(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () async {
                    FlutterClipboard.copy(shayatitxt + Appinfo.shareTxt)
                        .then((value) {
                      showSnackBar(context, text: 'Copy To ClipBord');
                    });
                  },
                  icon: Icon(
                    FontAwesomeIcons.copy,
                    color: Apptheme.secendery,
                    size: 18,
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    addremoveFav(widget.shayatidata['id']);
                  },
                  icon: Icon(
                    isfav
                        ? FontAwesomeIcons.solidHeart
                        : FontAwesomeIcons.heart,
                    color: Apptheme.secendery,
                    size: 18,
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    playShayari();
                  },
                  icon: Icon(
                    provaide.playerId == widget.shayatidata['id']
                        ? FontAwesomeIcons.pause
                        : FontAwesomeIcons.play,
                    color: Apptheme.secendery,
                    size: 18,
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    if (provaide.playerId != null) {
                      await flutterTts.stop();
                      provaide.removePlayer();
                    }
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => EditorPage(text: shayatitxt),
                    ));
                  },
                  icon: Icon(
                    FontAwesomeIcons.paintbrush,
                    color: Apptheme.secendery,
                    size: 18,
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    if (provaide.playerId != null) {
                      flutterTts.stop();
                      provaide.removePlayer();
                    }
                    await Share.share(shayatitxt + Appinfo.shareTxt);
                  },
                  icon: Icon(
                    FontAwesomeIcons.shareAlt,
                    color: Apptheme.secendery,
                    size: 18,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
