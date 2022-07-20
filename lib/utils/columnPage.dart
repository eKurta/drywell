import 'package:flutter/material.dart';

Widget columnPage(
    {required List<Widget> children,
    EdgeInsets padding = const EdgeInsets.symmetric(horizontal: 16)}) {
  return Scaffold(
    body: SafeArea(
        child: Padding(
      padding: padding,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: children,
      ),
    )),
  );
}
