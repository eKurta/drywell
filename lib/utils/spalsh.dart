import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drivel/providers/chatProvider.dart/chatProvider.dart';
import 'package:drivel/providers/user/userMessageProvider.dart';
import 'package:drivel/providers/user/userProvider.dart';
import 'package:drivel/services/userService/userService.dart';
import 'package:drivel/utils/navigator.dart';
import 'package:drivel/utils/sizeConfig.dart';
import 'package:drivel/view/explore/pages/explorePage.dart';
import 'package:drivel/view/login/pages/loginPage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashInitialize {
  static void initialize(BuildContext context, WidgetRef ref) {
    try {
      SizeConfig(context: context);
      FirebaseMessaging.instance
          .getToken()
          .then((value) => ref.read(userFCMProvider.notifier).state = value!);

      if (UserService.user() == null)
        Navigator.push(context, MaterialPageRoute(builder: (_) => LoginPage()));
      else {
        FirebaseFirestore.instance
            .collection('Users')
            .doc(UserService.user()!.uid)
            .get()
            .then((value) {
          inspect(value);
          ref.watch(userMessageProvider.notifier).state =
              value.data()!['numberOfMessagesWritten'];
        });
        ref.read(chatsProvider.notifier).getUserChats();
        navigatorPush(ExplorePage(), context);
      }
    } catch (e) {
      print('Error na inicijalizaciji $e');
    }
  }
}
