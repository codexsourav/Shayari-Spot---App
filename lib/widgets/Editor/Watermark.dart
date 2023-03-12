import 'package:flutter/material.dart';

Widget watermark() {
  return Align(
    alignment: Alignment.bottomRight,
    child: Container(
      color: Colors.transparent,
      margin: const EdgeInsets.only(right: 15),
      height: 60,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            'MADE BY',
            style: TextStyle(
              color: Color.fromARGB(96, 255, 255, 255),
              fontSize: 10,
            ),
          ),
          SizedBox(height: 5),
          Text(
            'SHAYARI  SPOT',
            style: TextStyle(
                color: Color.fromARGB(118, 255, 255, 255), fontSize: 12),
          ),
        ],
      ),
    ),
  );
}
