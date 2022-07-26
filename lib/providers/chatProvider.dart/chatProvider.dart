import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drivel/models/chat.dart';
import 'package:drivel/models/chatUser.dart';
import 'package:drivel/services/userService/userService.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatNotifier extends StateNotifier<List<Chat>> {
  ChatNotifier() : super([]);

  Chat? selectedChat;

  void getUserChats() async {
    List<Chat> chats = [];
    var firebaseChats = await FirebaseFirestore.instance
        .collection('Users')
        .doc(UserService.user()!.uid)
        .collection('Chats')
        .get();

    firebaseChats.docs.forEach((element) {
      chats.add(Chat.fromJson(element.data()));
    });

    state = chats;
  }

  void setSelectedChat(Chat chat) {
    selectedChat = chat;
  }

  void addUserChat(Chat chat) {
    state = [...state, chat];
  }

  void removeChat(String chatId) {
    state = [
      for (final chat in state)
        if (chat.id != chatId) chat,
    ];
  }
}

final chatsProvider = StateNotifierProvider<ChatNotifier, List<Chat>>((ref) {
  return ChatNotifier();
});
