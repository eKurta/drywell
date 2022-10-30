import 'dart:async';

import 'package:drivel/services/userService/userService.dart';
import 'package:drivel/utils/spalsh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashPage extends ConsumerStatefulWidget {
  SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  @override
  void initState() {
    Timer(const Duration(milliseconds: 100), () {
      SplashInitialize.initialize(context, ref);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
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
