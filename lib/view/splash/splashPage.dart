import 'dart:async';

import 'package:drivel/utils/spalsh.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Timer splashTimer = Timer(Duration(milliseconds: 1000), () {
      SplashInitialize.initialize(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
            // child: Image.asset(
            //   'assets/images/splash.png',
            //   width: MediaQuery.of(context).size.width / 2,
            // ),
            ),
      ),
    );
  }
}
