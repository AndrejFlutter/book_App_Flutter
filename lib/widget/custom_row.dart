import 'package:flutter/material.dart';

Widget CustomRow(
    IconData myIcon, Color myColor, String myText1, String myText2) {
  return Container(
    //height: 150,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      color: Colors.white,
      border: Border.all(color: Colors.purple),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 8),
    child: Row(
      //mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: 30,
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Icon(myIcon, color: myColor),
          ]),
        ),
        const SizedBox(
          width: 5,
        ),
        Container(
          width: 60,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  myText1,
                  style: const TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 16),
                ),
              ]),
        ),
        const SizedBox(
          width: 20,
        ),
        Flexible(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              myText2,
              style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                  color: Colors.purple),
            )
          ]),
        ),
      ],
    ),
  );
}
