import 'package:drivel/models/chatUser.dart';
import 'package:flutter/material.dart';

@immutable
class Chat {
  final String id;
  final String ownerId;
  final String name;
  final String? description;
  final String? photoUrl;
  final bool canOthersRespond;
  final List<ChatUser> chatMembers;

  const Chat(
      {required this.id,
      required this.ownerId,
      required this.name,
      this.description,
      this.photoUrl,
      this.canOthersRespond = true,
      required this.chatMembers});

  int chatMembersCount() {
    return chatMembers.length;
  }

  factory Chat.fromJson(Map<dynamic, dynamic> json) {
    List<ChatUser> chatMembers = [];
    // json['chatMembers'].forEach((member) {
    //   chatMembers.add(ChatUser.fromJson(member));
    // });

    return Chat(
        id: json['id'],
        name: json['name'],
        ownerId: json['ownerId'],
        description: json['description'],
        photoUrl: json['photoUrl'],
        canOthersRespond: json['canOthersRespond'],
        chatMembers: chatMembers);
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'name': name,
      'ownerId': ownerId,
      'description': description,
      'photoUrl': photoUrl,
      'canOthersRespond': canOthersRespond
      //'chatMembers': chatMembers,
    };
    return map;
  }
}
