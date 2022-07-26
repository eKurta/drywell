import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drivel/models/chat.dart';
import 'package:drivel/models/chatUser.dart';
import 'package:drivel/providers/chatProvider.dart/chatProvider.dart';
import 'package:drivel/view/login/pages/loginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserService {
  static var _firebase = FirebaseFirestore.instance;

  static User? user() {
    return FirebaseAuth.instance.currentUser;
  }

  static ChatUser getUserChatUser() {
    return ChatUser(
        id: user()!.uid,
        name: user()!.displayName!,
        photoUrl: user()!.photoURL);
  }

  static logoutUser(context) {
    FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => LoginPage()));
  }

  static createUserChat(Chat chat) {
    try {
      _firebase
          .collection('Users')
          .doc(user()!.uid)
          .collection('Chats')
          .doc(chat.id)
          .set(chat.toMap());
    } catch (e) {
      print('CREATE USER CHAT ERROR $e');
    }
  }
}
