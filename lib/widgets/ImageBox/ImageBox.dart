import 'package:cached_network_image/cached_network_image.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shayarispot2/Constent/AppInfo/appInfo.dart';
import 'package:shimmer/shimmer.dart';

import '../../Constent/Colors/Apptheme.dart';
import '../../Models/Storage/FavImagesLocalDb.dart';
import '../../Models/Storage/GetImageFile.dart';
import '../Appbars/SnackBar.dart';

class ImageBox extends StatefulWidget {
  final showImage;
  const ImageBox({super.key, this.showImage});

  @override
  State<ImageBox> createState() => _ImageBoxState();
}

class _ImageBoxState extends State<ImageBox> {
  var localstorage = FavImagesLocalDb.instense;
  bool isfav = false;

  // add or remove favirate
  addremoveFav() {
    if (isfav) {
      localstorage.deleteData(widget.showImage['id']);
      setState(() {
        isfav = false;
      });
    } else {
      localstorage.addSaved(widget.showImage);
      setState(() {
        isfav = true;
      });
    }
  }

// chack if fav exist
  Future setFav(sid) async {
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

// downlad This Image
  downloadImage() async {
// ignore: prefer_interpolation_to_compose_strings
    String fileName = "Shayari_Spot_" +
        DateTime.now().millisecondsSinceEpoch.toString() +
        '.jpg';

    showSnackBar(context, text: 'Start Downloading..');

    var dpath = await getDownloadPath();

    var loadFile = await fileFromImageUrl(
      widget.showImage['fields']['url'].toString(),
      path: dpath,
      name: fileName,
    );
    if (loadFile != null) {
      showSnackBar(context, text: 'Download Complete');
    } else {
      showSnackBar(context, text: 'something went wrong!');
    }
  }

// share Iamge
  shareImage() async {
    showSnackBar(context, text: 'Loading Image...');
    var shareFile =
        await fileFromImageUrl(widget.showImage['fields']['url'].toString());

    if (shareFile != null) {
      await Share.shareXFiles([XFile(shareFile.path)], text: Appinfo.shareTxt);
    } else {
      showSnackBar(context, text: 'something went wrong!');
    }
  }

  @override
  void initState() {
    super.initState();
    setFav(widget.showImage['id']);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            alignment: Alignment.center,
            // widget.showImage['fields']['url'],
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 10, right: 10, top: 10, bottom: 70),
              child: GestureDetector(
                onDoubleTap: () {
                  addremoveFav();
                },
                child: CachedNetworkImage(
                  imageUrl: widget.showImage['fields']['url'].toString(),
                  placeholder: (context, url) => Shimmer.fromColors(
                    baseColor: Apptheme.white,
                    highlightColor: Apptheme.primary,
                    child: Container(
                      color: Apptheme.white,
                      width: MediaQuery.of(context).size.width,
                    ),
                  ),
                  errorWidget: (context, url, error) => const Icon(
                    Icons.error_outline_rounded,
                    size: 30,
                    color: Color.fromARGB(192, 244, 67, 54),
                  ),
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 60,
            margin: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Apptheme.textLight.withOpacity(0.8),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  onPressed: () {
                    FlutterClipboard.copy(
                            widget.showImage['fields']['url'].toString())
                        .then((value) {
                      showSnackBar(context, text: 'Link Copy To ClipBord');
                    });
                  },
                  icon: Icon(
                    FontAwesomeIcons.copy,
                    color: Apptheme.secendery,
                    size: 22,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    addremoveFav();
                  },
                  icon: Icon(
                    isfav
                        ? FontAwesomeIcons.solidHeart
                        : FontAwesomeIcons.heart,
                    color: Apptheme.secendery,
                    size: 22,
                  ),
                ),
                IconButton(
                  onPressed: shareImage,
                  icon: Icon(
                    FontAwesomeIcons.whatsapp,
                    color: Apptheme.secendery,
                    size: 22,
                  ),
                ),
                IconButton(
                  onPressed: downloadImage,
                  icon: Icon(
                    FontAwesomeIcons.download,
                    color: Apptheme.secendery,
                    size: 22,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
