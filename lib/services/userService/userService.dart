import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drivel/models/chat.dart';
import 'package:drivel/providers/chatProvider.dart/chatProvider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserService {
  static var _firebase = FirebaseFirestore.instance;

  static User? user() {
    return FirebaseAuth.instance.currentUser;
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
