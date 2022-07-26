import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drivel/models/chat.dart';
import 'package:drivel/models/chatMessage.dart';
import 'package:drivel/providers/chatProvider.dart/chatProvider.dart';
import 'package:drivel/services/userService/userService.dart';
import 'package:drivel/utils/spacing.dart';

import 'package:drivel/view/chatConversation/widgets/editChatDrawer.dart';
import 'package:drivel/view/chatConversation/widgets/receivingChatBubble.dart';
import 'package:drivel/view/chatConversation/widgets/sendMessageBox.dart';
import 'package:drivel/view/chatConversation/widgets/chatConversationAppBar.dart';
import 'package:drivel/view/chatConversation/widgets/sendingChatBubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatConversationPage extends StatefulWidget {
  final Chat chat;
  const ChatConversationPage({Key? key, required this.chat}) : super(key: key);

  @override
  State<ChatConversationPage> createState() => _ChatConversationPageState();
}

class _ChatConversationPageState extends State<ChatConversationPage> {
  final GlobalKey<ScaffoldState> _chatConversationScaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Scaffold(
            key: _chatConversationScaffoldKey,
            endDrawer: const EditChatDrawer(),
            body: SafeArea(
                child: Stack(
              children: [
                Consumer(builder: (ctx, ref, child) {
                  double lowerPadding = ref.watch(lowerMessagePadding);
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
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

                                  return message.owner.id ==
                                          UserService.user()!.uid
                                      ? Column(
                                          children: [
                                            if (index ==
                                                snapshot.data!.docs.length - 1)
                                              verticalSpacing(90),
                                            SendingChatBubble(message: message),
                                            if (index == 0)
                                              verticalSpacing(lowerPadding),
                                          ],
                                        )
                                      : Column(
                                          children: [
                                            if (index ==
                                                snapshot.data!.docs.length - 1)
                                              verticalSpacing(90),
                                            ReceivingChatBubble(
                                              message: message,
                                            ),
                                            if (index == 0)
                                              verticalSpacing(lowerPadding),
                                          ],
                                        );
                                });
                          }
                          return const Center(
                            child: SizedBox(
                                height: 42,
                                width: 42,
                                child: CircularProgressIndicator()),
                          );
                        }),
                  );
                }),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SendMessageBox(
                    chat: widget.chat,
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: ChatConversationAppBar(
                    chat: widget.chat,
                    scaffoldKey: _chatConversationScaffoldKey,
                  ),
                ),
              ],
            ))));
  }
}
