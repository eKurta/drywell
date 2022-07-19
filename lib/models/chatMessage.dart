import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drivel/models/chatUser.dart';

class ChatMessage {
  final String id;
  final String chatId;
  final String text;
  final DateTime createdAt;
  final String ownerId;

  ChatMessage(
      {required this.id,
      required this.chatId,
      required this.text,
      required this.createdAt,
      required this.ownerId});

  factory ChatMessage.fromJson(Map<dynamic, dynamic> json) {
    return ChatMessage(
        id: json['id'],
        chatId: json['chatId'],
        text: json['message'],
        createdAt: (json['createdAt'] as Timestamp).toDate(),
        ownerId: json['ownerId']);
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'chatId': chatId,
      'ownerId': ownerId,
      'createdAt': createdAt,
      'message': text,
    };
    return map;
  }
}
