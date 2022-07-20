import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drivel/models/chat.dart';
import 'package:drivel/models/chatMessage.dart';
import 'package:drivel/models/chatUser.dart';
import 'package:drivel/services/userService/userService.dart';
import 'package:drivel/view/chatConversation/page/removeChatMemberPage.dart';
import 'package:flutter/material.dart';

class ChatServices {
  static final _firebase = FirebaseFirestore.instance;

  static Future<bool> createChat(Chat chat) async {
    if (chat.name == null) {
      return false;
    }

    try {
      _firebase.collection('Chats').doc(chat.id).set(chat.toMap());
      UserService.createUserChat(chat);
    } catch (e) {
      print('CREATE CHAT ERROR $e');
      return false;
    }

    return true;
  }

  static createChatMessage(ChatMessage message) async {
    try {
      _firebase
          .collection('Chats')
          .doc(message.chatId)
          .collection('Messages')
          .doc(message.id)
          .set(message.toMap());
    } catch (e) {
      print('CREATE CHAT MESSAGE ERROR $e');
      return false;
    }

    return true;
  }

  static addChatUser(Chat chat) {
    chat.chatMembers.add(ChatUser(
        id: UserService.user()!.uid,
        name: UserService.user()!.displayName!,
        photoUrl: UserService.user()!.photoURL));

    _firebase.collection('Chats').doc(chat.id).update(chat.toMap());
  }

  static removeChatMember(Chat chat, String memberID) {
    try {
      chat.chatMembers.removeWhere((element) => element.id == memberID);
      _firebase.collection('Chats').doc(chat.id).update(chat.toMap());
    } catch (e) {
      print('REMOVE CHAT USER ERROR $e');
      return false;
    }
  }
}
