import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drivel/models/chatUser.dart';

class ChatMessage {
  final String id;
  final String chatId;
  final String text;
  final DateTime createdAt;
  ChatUser owner;

  ChatMessage(
      {required this.id,
      required this.chatId,
      required this.text,
      required this.createdAt,
      required this.owner});

  factory ChatMessage.fromJson(Map<dynamic, dynamic> json) {
    return ChatMessage(
        id: json['id'],
        chatId: json['chatId'],
        text: json['message'],
        createdAt: (json['createdAt'] as Timestamp).toDate(),
        owner: ChatUser.fromJson(json['owner']));
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'chatId': chatId,
      'owner': {'id': owner.id, 'name': owner.name, 'photoUrl': owner.photoUrl},
      'createdAt': createdAt,
      'message': text,
    };
    return map;
  }
}
