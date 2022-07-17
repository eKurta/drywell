import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drivel/models/chat.dart';

class ChatServices {
  static final _firebase = FirebaseFirestore.instance;

  static Future<bool> createChat(Chat chat) async {
    if (chat.name == null) {
      return false;
    }

    try {
      _firebase.collection('Chats').doc(chat.id).set(chat.toMap());
    } catch (e) {
      print('CREATE CHAT ERROR $e');
      return false;
    }

    return true;
  }

  static Stream<Chat> exploreChats() async* {
    //  yield _firebase.collection('Chats').snapshots();

    /*
  then((value) async* {
      for (var element in value.docs) {
        yield Chat.fromJson(element.data());
      }
    }); */
  }
}
