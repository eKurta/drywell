import 'package:drivel/models/chat.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatNotifier extends StateNotifier<List<Chat>> {
  ChatNotifier() : super([]);

  void addChat(Chat chat) {
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
