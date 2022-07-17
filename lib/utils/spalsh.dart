import 'package:drivel/utils/sizeConfig.dart';
import 'package:drivel/view/login/pages/loginPage.dart';
import 'package:flutter/material.dart';

class SplashInitialize {
  static void initialize(BuildContext context) {
    try {
      SizeConfig(context: context);
      Navigator.push(context, MaterialPageRoute(builder: (_) => LoginPage()));
    } catch (e) {
      print('Error na inicijalizaciji $e');
    }
  }
}
