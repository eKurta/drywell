import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drivel/models/chat.dart';
import 'package:drivel/models/chatMessage.dart';
import 'package:drivel/models/chatUser.dart';
import 'package:drivel/services/chatServices/chatServices.dart';
import 'package:drivel/services/userService/userService.dart';
import 'package:drivel/utils/columnPage.dart';
import 'package:drivel/utils/widgets/line.dart';
import 'package:drivel/view/chatConversation/widgets/receivingChatBubble.dart';
import 'package:drivel/view/chatConversation/widgets/sendMessageBox.dart';
import 'package:drivel/view/chatConversation/widgets/chatConversationAppBar.dart';
import 'package:drivel/view/chatConversation/widgets/sendingChatBubble.dart';
import 'package:flutter/material.dart';

class ChatConversationPage extends StatefulWidget {
  final Chat chat;
  const ChatConversationPage({Key? key, required this.chat}) : super(key: key);

  @override
  State<ChatConversationPage> createState() => _ChatConversationPageState();
}

class _ChatConversationPageState extends State<ChatConversationPage> {
  @override
  void initState() {
    ChatServices.updateChat(widget.chat);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return columnPage(children: [
      ChatConversationAppBar(chat: widget.chat),
      line(),
      Expanded(
          child: Column(children: [
        Expanded(
          child: StreamBuilder<QuerySnapshot<Map<dynamic, dynamic>>>(
              stream: FirebaseFirestore.instance
                  .collection('Chats')
                  .doc(widget.chat.id)
                  .collection('Messages')
                  .orderBy('createdAt', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      reverse: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (ctx, index) {
                        ChatMessage message = ChatMessage.fromJson(
                            snapshot.data!.docs[index].data());
                        return message.ownerId == UserService.user()!.uid
                            ? SendingChatBubble(message: message)
                            : ReceivingChatBubble(
                                message: message,
                                chat: widget.chat,
                              );
                      });
                }
                return CircularProgressIndicator();
              }),
        )
      ])),
      line(),
      SendMessageBox(
        chat: widget.chat,
      )
    ]);
  }
}