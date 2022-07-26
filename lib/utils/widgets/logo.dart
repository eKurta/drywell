import 'package:flutter/material.dart';

Widget logo(double size) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        'dry',
        style: TextStyle(
            fontFamily: 'LogoFont', fontSize: size, color: Colors.amber),
      ),
      Text(
        'well',
        style: TextStyle(
            fontFamily: 'LogoFont', fontSize: size, color: Colors.white),
      ),
    ],
  );
}
