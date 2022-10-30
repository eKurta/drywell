import 'dart:io';

import 'package:drivel/models/chat.dart';
import 'package:drivel/models/chatUser.dart';
import 'package:drivel/providers/user/userProvider.dart';
import 'package:drivel/services/photoService/photoService.dart';
import 'package:drivel/services/userService/userService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

class CreateChatProvider extends ChangeNotifier {
  String? name;
  String? description;
  bool allowOtherToRespond = true;

  void setName(String name) {
    this.name = name;
    notifyListeners();
  }

  void setDescription(String description) {
    this.description = description;
    notifyListeners();
  }

  void toggleAllowOtherToRespond(bool? value) {
    allowOtherToRespond = value ?? !allowOtherToRespond;
    notifyListeners();
  }

  bool canCreate() {
    return name != null;
  }

  Future<Chat> getCreatedChat(WidgetRef ref, [File? image]) async {
    String? photoUrl;
    String id = Uuid().v4();

    if (image != null) {
      photoUrl = await PhotoService.uploadPhoto(id + 'CHAT_PHOTO', image);
    }

    return Chat(
        id: id,
        ownerId: UserService.user()!.uid,
        name: name!,
        description: description,
        photoUrl: photoUrl,
        canOthersRespond: allowOtherToRespond,
        chatMembers: [
          ChatUser(
              id: UserService.user()!.uid,
              name: UserService.user()!.displayName!,
              photoUrl: UserService.user()!.photoURL)
        ],
        notificationSubscribers: [
          ref.watch(userFCMProvider)
        ]);
  }

  void resetToInit() {
    name = null;
    description = null;
    allowOtherToRespond = true;
  }
}

var createChatProvider = ChangeNotifierProvider((_) => CreateChatProvider());
