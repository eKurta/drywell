import 'package:drivel/models/chat.dart';
import 'package:drivel/models/chatMessage.dart';
import 'package:drivel/services/chatServices/chatServices.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

class SendMessageBox extends ConsumerWidget {
  final Chat chat;
  SendMessageBox({required this.chat, Key? key}) : super(key: key);

  TextEditingController _chatMessageController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        constraints: const BoxConstraints(maxHeight: 155),
        decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(4)),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 4),
                  child: TextField(
                    maxLines: null,
                    controller: _chatMessageController,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Type a message here',
                        hintStyle: TextStyle(color: Colors.grey.shade700)),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(right: 8, bottom: 8, top: 8, left: 8),
                child: GestureDetector(
                  onTap: () {
                    createMessage();
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
                ),
              )
            ]),
      ),
    );
  }

  void createMessage() {
    if (!chat.amIinChat()) {
      ChatServices.addChatUser(chat);
    }
    ChatServices.createChatMessage(ChatMessage(
        id: Uuid().v4(),
        chatId: chat.id,
        text: _chatMessageController.text,
        createdAt: DateTime.now(),
        ownerId: chat.chatOwner().id));
    _chatMessageController.clear();
  }
}
