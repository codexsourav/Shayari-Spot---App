import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:shayarispot2/Constent/Colors/Apptheme.dart';

showColorDialog(BuildContext context,
    {color = Colors.white, required onchenge}) {
  // set up the button
  Widget okButton = TextButton(
    style: ButtonStyle(
      overlayColor: MaterialStateProperty.all(Colors.transparent),
    ),
    child: Text(
      "OK",
      style: TextStyle(color: Apptheme.textDark),
    ),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    elevation: 0,
    content: SingleChildScrollView(
      child: ColorPicker(
        padding: EdgeInsets.zero,
        // Use the screenPickerColor as start color.
        color: color,
        // Update the screenPickerColor using the callback.
        onColorChanged: onchenge,
        width: 44,
        height: 44,
        elevation: 0,
        showColorCode: false,
        materialNameTextStyle: Theme.of(context).textTheme.bodySmall,
        colorNameTextStyle: Theme.of(context).textTheme.bodySmall,
        colorCodeTextStyle: Theme.of(context).textTheme.bodySmall,
        pickersEnabled: const <ColorPickerType, bool>{
          ColorPickerType.both: false,
          ColorPickerType.primary: true,
          ColorPickerType.accent: false,
          ColorPickerType.bw: false,
          ColorPickerType.custom: false,
          ColorPickerType.wheel: true,
        },

        borderRadius: 15,
      ),
    ),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
