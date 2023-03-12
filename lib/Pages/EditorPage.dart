import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shayarispot2/Constent/AppInfo/appInfo.dart';
import 'package:shayarispot2/Constent/Colors/Apptheme.dart';
import 'package:shayarispot2/widgets/Editor/Actions/PickFont.dart';

import 'package:widgets_to_image/widgets_to_image.dart';

import '../Models/Storage/GetImageFile.dart';
import '../Provider/InterstitialAds.dart';
import '../Provider/ProProvider.dart';
import '../widgets/Appbars/SnackBar.dart';
import '../widgets/Editor/Actions/ExitAlet.dart';
import '../widgets/Editor/Actions/GredentColor.dart';
import '../widgets/Editor/Actions/SelectColor.dart';
import '../widgets/Editor/Actions/SliderBtn.dart';
import '../widgets/Editor/Actions/TextEditor.dart';
import '../widgets/Editor/EditorAppBar.dart';
import '../widgets/Editor/EditorBottamBar.dart';
import '../widgets/Editor/ViewPage.dart';

class EditorPage extends StatefulWidget {
  final text;
  const EditorPage({super.key, this.text = ''});

  @override
  State<EditorPage> createState() => _EditorPageState();
}

class _EditorPageState extends State<EditorPage> {
  int tabindex = 0;

// editor setup
  String text = '';
  bool isBold = false;
  int? fontindex;
  Color textcolor = Apptheme.textLight, bgcolor = Apptheme.primaryDark;
  double padding = 10, blur = 0, opacity = 1, textsize = 18;
  bool showatermark = true;
  String? imgpath;
  List<Color>? gredent;
  Color color1 = Apptheme.secendery;
  Color color2 = Apptheme.secendery;
  bool isloading = false;
  int alineindex = 0;
  WidgetsToImageController controller = WidgetsToImageController();

// get whitch button her click
  void onbottamTabclick(index) {
    switch (index) {
      case 0:
        setState(() {
          tabindex = 1;
        });
        break;
      case 1:
        setState(() {
          tabindex = 2;
        });
        break;
      case 2:
        {
          if (imgpath == null) {
            showSnackBar(context,
                text: 'Select Image To Use Opacity', ontap: setBgImage);
          } else {
            setState(() {
              tabindex = 3;
            });
          }
        }
        break;
      case 3:
        {
          if (imgpath == null) {
            showSnackBar(context,
                text: 'Select Image To Use Blur', ontap: setBgImage);
          } else {
            setState(() {
              tabindex = 4;
            });
          }
        }
        break;
      case 4:
        setState(() {
          tabindex = 5;
        });
        break;
      case 5:
        showColorDialog(context, onchenge: setTextColor, color: textcolor);
        break;
      case 6:
        setBgImage();
        break;
      case 7:
        showColorDialog(context, onchenge: setBgColor, color: bgcolor);
        break;
      case 8:
        showTextEditorDialog(context, text: text, onclick: setText);
        break;
      case 9:
        setState(() {
          tabindex = 6;
        });
        break;
      case 10:
        if (alineindex != 2) {
          setState(() {
            alineindex++;
          });
        } else {
          setState(() {
            alineindex = 0;
          });
        }
        break;
      case 11:
        setBold();
        break;
      default:
        setState(() {
          tabindex = 0;
        });
    }
  }

// set text
  setText(val) {
    setState(() {
      text = val;
    });
  }

// set text bold
  setBold() {
    setState(() {
      isBold = !isBold;
    });
  }

// settext size
  setTextSize(val) {
    setState(() {
      textsize = val;
    });
  }

  // settext Padding
  setPadding(val) {
    setState(() {
      padding = val;
    });
  }

  // settext opacity
  setOpacity(val) {
    setState(() {
      opacity = val;
    });
  }

  // settext blur
  setBlur(val) {
    setState(() {
      blur = val;
    });
  }

// set text color
  setTextColor(color) {
    setState(() {
      textcolor = color;
    });
  }

// set font index
  setfontIndex(index) {
    setState(() {
      fontindex = index;
    });
  }

// set bg color
  setBgColor(color) {
    if (gredent != null) {
      setState(() {
        gredent = null;
      });
    }
    setState(() {
      bgcolor = color;
    });
  }

//set bg gredent color
  callGredent(index) {
    if (index == 0) {
      showColorDialog(context, onchenge: (color) {
        setState(() {
          color1 = color;
          gredent = [color1, color2];
        });
      }, color: color1);
    } else if (index == 1) {
      showColorDialog(context, onchenge: (color) {
        setState(() {
          color2 = color;
          gredent = [color1, color2];
        });
      }, color: color2);
    } else {
      setState(() {
        tabindex = 0;
      });
    }
  }

// on try pop
  Future<bool> willtrypop() async {
    if (tabindex != 0) {
      setState(() {
        tabindex = 0;
      });
    } else {
      showAlertExitDialog(context);
    }
    return false;
  }

// set bg image
  setBgImage() async {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'gif'],
    );
    if (result != null) {
      if (result.files.first.path!.isNotEmpty) {
        setState(() {
          imgpath = result.files.first.path;
          opacity = 0;
        });
      }
    }
  }

// set loading
  setLoading() {
    setState(() {
      isloading = !isloading;
    });
  }

// appbar action
  appbarAction(index) async {
    if (index == 'pro') {
      var activatePro = Provider.of<ProProvider>(context, listen: false);
      var status = activatePro.activePro();
      if (status == false) {
        showSnackBar(context, text: 'Loading Ad...');
      }
    } else {
      setLoading();
      showSnackBar(context, text: 'Loading Image...');

      try {
        var byts = await controller.capture();

        if (index == 'share') {
          final t = await getTemporaryDirectory();
          final path = "${t.path}/Shayari_Spot.png";
          await File(path).writeAsBytes(byts!);
          setLoading();
          await Share.shareXFiles([XFile(path)], text: Appinfo.shareTxt);
        } else {
          // ignore: prefer_interpolation_to_compose_strings
          String fileName = "Shayari_Spot_" +
              DateTime.now().millisecondsSinceEpoch.toString() +
              '.jpg';

          var dpath = await getDownloadPath();

          File file2 = File("$dpath/$fileName");
          await file2.writeAsBytes(byts!);
          showSnackBar(context, text: 'Download Complete');
          setLoading();
          // try show ad;
          var interstitial =
              Provider.of<InterstitialAds>(context, listen: false);
          interstitial.showInterstitial();
        }
      } catch (e) {
        showSnackBar(context, text: 'Sumthing Want Wrong : (');
        print(e);
      }
    }
  }

// init statte set
  @override
  void initState() {
    super.initState();
    var interstitial = Provider.of<InterstitialAds>(context, listen: false);
    interstitial.showInterstitial();
    text = widget.text;
  }

  @override
  Widget build(BuildContext context) {
    List bottamtabs = [
      EditorBottamBar(context, ontap: onbottamTabclick, alineindex: alineindex),
      // for text size
      SliderBtn(value: textsize, onchenge: setTextSize, min: 5, max: 50),
      // for padding
      SliderBtn(value: padding, onchenge: setPadding),
      // for opacity
      SliderBtn(value: opacity, onchenge: setOpacity, max: 1, min: 0),
      // for blur
      SliderBtn(value: blur, onchenge: setBlur, max: 50),
      // font
      PickFont(onchenge: setfontIndex),
      // gredent color
      gredentColor(onchenge: callGredent),
    ];
    return WillPopScope(
      onWillPop: willtrypop,
      child: Scaffold(
        backgroundColor: Apptheme.white,
        appBar: editorAppBar(
          context,
          clickindex: appbarAction,
          loading: isloading,
          ispro: context.watch<ProProvider>().pro,
        ),
        body: Center(
          child: WidgetsToImage(
            controller: controller,
            child: viewPage(
              context,
              bgcolor: bgcolor,
              blur: blur,
              fontindex: fontindex,
              imgPath: imgpath,
              opacity: opacity,
              padding: padding,
              showatermark: context.watch<ProProvider>().pro,
              text: text,
              textcolor: textcolor,
              textsize: textsize,
              alineindex: alineindex,
              gradient: gredent,
              isbold: isBold,
            ),
          ),
        ),
        bottomNavigationBar: bottamtabs[tabindex],
      ),
    );
  }
}
