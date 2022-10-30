import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:drivel/models/chat.dart';
import 'package:drivel/models/chatMessage.dart';
import 'package:drivel/providers/chatProvider.dart/chatProvider.dart';
import 'package:drivel/providers/user/userMessageProvider.dart';
import 'package:drivel/providers/user/userProvider.dart';
import 'package:drivel/services/chatServices/chatServices.dart';
import 'package:drivel/services/userService/userService.dart';
import 'package:drivel/utils/sizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

class SendMessageBox extends ConsumerWidget {
  final Chat chat;
  SendMessageBox({required this.chat, Key? key}) : super(key: key);

  TextEditingController _chatMessageController = TextEditingController();

  GlobalKey sendMessageBoxKey = GlobalKey();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BlurryContainer(
        blur: 12,
        padding: EdgeInsets.zero,
        borderRadius: BorderRadius.zero,
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 16, right: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                key: sendMessageBoxKey,
                constraints: BoxConstraints(
                    maxHeight: 155, maxWidth: SizeConfig.width * 0.75),
                decoration: BoxDecoration(
                    color: Colors.grey.shade800.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(25)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 10),
                  child: TextField(
                    maxLines: null,
                    style: TextStyle(color: Colors.white),
                    controller: _chatMessageController,
                    onChanged: (r) {
                      double contianerHeight =
                          (sendMessageBoxKey.currentContext!.findRenderObject()
                                  as RenderBox)
                              .size
                              .height;
                      if (contianerHeight > 70) {
                        ref.read(lowerMessagePadding.notifier).state =
                            contianerHeight + 10;
                      }
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Type a message here',
                        hintStyle: TextStyle(color: Colors.grey.shade500)),
                  ),
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  if (_chatMessageController.text.isNotEmpty)
                    createMessage(ref);
                },
                child: CircleAvatar(
                  radius: 22,
                  backgroundColor: Colors.amber,
                  child: Transform.rotate(
                    angle: 75,
                    child: const Padding(
                      padding: EdgeInsets.only(left: 4),
                      child: Icon(
                        Icons.send,
                        color: Colors.white,
                        size: 22,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }

  void createMessage(WidgetRef ref) async {
    if (!chat.amIinChat()) {
      ref.read(chatsProvider.notifier).addUserChat(chat);

      ChatServices.addChatUser(chat);
      UserService.createUserChat(chat);
    }

    if (!chat.notificationSubscribers
        .any((element) => element == ref.watch(userFCMProvider))) {
      ChatServices.addUserFCM(chat, ref);
    }

    ChatServices.createChatMessage(ChatMessage(
        id: Uuid().v4(),
        chatId: chat.id,
        text: _chatMessageController.text.trimRight(),
        createdAt: DateTime.now(),
        owner: UserService.getUserChatUser()));

    var data = <String, dynamic>{
      "targetDevices": chat.notificationSubscribers,
      "messageTitle": "New message in ${chat.name}",
      "messageBody": _chatMessageController.text.trimRight()
    };

    _chatMessageController.clear();

    updateNumberOfUserMessages(ref);

    ref.read(lowerMessagePadding.notifier).state = 70.0;

    var func = FirebaseFunctions.instanceFor(region: 'europe-west1')
        .httpsCallable("notifySubscribers");
    var res = await func.call(data);

    print("message was ${res.data as bool ? "sent!" : "not sent!"}");
  }

  void updateNumberOfUserMessages(WidgetRef ref) {
    ref.read(userMessageProvider.notifier).state += 1;
    UserService.updateNumberOfUserMessages(ref.watch(userMessageProvider));
  }
}

var lowerMessagePadding = StateProvider<double>((ref) => 70);
