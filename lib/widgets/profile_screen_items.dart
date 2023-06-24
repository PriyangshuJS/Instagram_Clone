import 'package:flutter/material.dart';

Column buildStatColumn(int number, String label) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Text(
        number.toString(),
        style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
      ),
      Container(
        margin: const EdgeInsets.only(top: 4.0),
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 15.0,
            fontWeight: FontWeight.w400,
          ),
        ),
      )
    ],
  );
}
