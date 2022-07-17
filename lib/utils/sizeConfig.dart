import 'package:flutter/material.dart';

class SizeConfig {
  BuildContext context;
  static late double height;
  static late double width;

  SizeConfig({required this.context}) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
  }
}
