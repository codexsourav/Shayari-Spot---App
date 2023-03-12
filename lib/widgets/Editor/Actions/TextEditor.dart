import 'package:flutter/material.dart';
import 'package:shayarispot2/Constent/Colors/Apptheme.dart';

showTextEditorDialog(BuildContext context, {text = '', onclick}) {
  TextEditingController textEditingController =
      TextEditingController(text: text);
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
      onclick(textEditingController.text);
      Navigator.of(context).pop();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    elevation: 0,
    content: Container(
        height: 160,
        child: Column(
          children: [
            Text('Edit Shayari'),
            SizedBox(height: 20),
            TextField(
              cursorColor: Apptheme.secendery,
              maxLines: 5,
              controller: textEditingController,
              decoration: InputDecoration(
                filled: true,
                border: InputBorder.none,
              ),
            ),
          ],
        )),
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
