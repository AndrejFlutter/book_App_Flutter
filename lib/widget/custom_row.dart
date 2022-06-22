import 'package:flutter/material.dart';

Widget CustomRow(
    IconData myIcon, Color myColor, String myText1, String myText2) {
  return Container(
    height: 150,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      color: Colors.white,
      border: Border.all(color: Colors.black26),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 8),
    child: Row(
      //mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(myIcon, color: myColor),
        ]),
        SizedBox(
          width: 5,
        ),
        Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            myText1,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
          ),
        ]),
        SizedBox(
          width: 20,
        ),
        Flexible(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              myText2,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            )
          ]),
        ),
      ],
    ),
  );
}
