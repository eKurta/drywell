import 'package:drivel/providers/chatProvider.dart/chatProvider.dart';
import 'package:drivel/services/userService/userService.dart';
import 'package:drivel/utils/navigator.dart';
import 'package:drivel/utils/sizeConfig.dart';
import 'package:drivel/view/explore/pages/explorePage.dart';
import 'package:drivel/view/login/pages/loginPage.dart';
import 'package:flutter/material.dart';

class SplashInitialize {
  static void initialize(BuildContext context, ref) {
    try {
      SizeConfig(context: context);

      UserService.user() == null
          ? Navigator.push(
              context, MaterialPageRoute(builder: (_) => LoginPage()))
          : {
              ref.read(chatsProvider.notifier).getUserChats(),
              navigatorPush(ExplorePage(), context)
            };
    } catch (e) {
      print('Error na inicijalizaciji $e');
    }
  }
}
