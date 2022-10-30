import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drivel/models/chat.dart';
import 'package:drivel/models/chatMessage.dart';
import 'package:drivel/models/chatUser.dart';
import 'package:drivel/providers/user/userProvider.dart';
import 'package:drivel/services/userService/userService.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatServices {
  static final _firebase = FirebaseFirestore.instance;

  static Future<bool> createChat(Chat chat, WidgetRef ref) async {
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

  static Future<Chat?> getChat(String id) async {
    try {
      var chat = await _firebase.collection('Chats').doc(id).get();

      return Chat.fromJson(chat.data()!);
    } catch (e) {
      print('CREATE CHAT MESSAGE ERROR $e');
    }
  }

  static List<ChatUser> getChatMembers(String chatId) {
    List<ChatUser> members = [];
    try {
      _firebase
          .collection('Chats')
          .doc(chatId)
          .get()
          .then((value) => value.data()!['chatMembers'].forEach((member) {
                members.add(ChatUser.fromJson(member));
              }));
      return members;
    } catch (e) {
      print('GET CHAT MEMBER ERROR $e');
      return [];
    }
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

  static addUserFCM(Chat chat, WidgetRef ref) {
    chat.notificationSubscribers.add(ref.watch(userFCMProvider));
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

  static Future<String> getUserWithMostMessagesInChat(String chatID) async {
    String name = '';
    var value = await FirebaseFirestore.instance
        .collection('Chats')
        .doc(chatID)
        .collection('Messages')
        .orderBy('owner.id', descending: true)
        .get();

    int counter1 = 0;
    int counter2 = 0;
    if (value.docs.length == 0) return '';

    if (value.docs.length == 1) {
      return value.docs[0].data()['owner']['name'];
    }

    for (int i = 0; value.docs.length - 1 > i; i++) {
      if (value.docs[i].data()['owner']['id'] ==
          value.docs[i + 1].data()['owner']['id']) {
        counter1 += 1;
      } else {
        if (counter1 > counter2) {
          name = value.docs[i].data()['owner']['name'];
          counter2 = counter1;
        }
        counter1 = 0;
      }
    }
    print(name);
    return name;
  }
}
