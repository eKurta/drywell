import 'package:flutter/material.dart';

Widget columnPage({required List<Widget> children}) {
  return Scaffold(
    body: SafeArea(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: children,
      ),
    )),
  );
}
