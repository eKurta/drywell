import 'package:cached_network_image/cached_network_image.dart';
import 'package:drivel/models/chat.dart';
import 'package:drivel/providers/chatProvider.dart/chatProvider.dart';
import 'package:drivel/utils/navigator.dart';
import 'package:drivel/utils/sizeConfig.dart';
import 'package:drivel/utils/spacing.dart';
import 'package:drivel/utils/widgets/chatDefaultIcon.dart';
import 'package:drivel/view/chatConversation/page/chatConversationPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExploreChatInbox extends StatelessWidget {
  final EdgeInsets padding;
  final Chat chat;
  const ExploreChatInbox(
      {Key? key, this.padding = EdgeInsets.zero, required this.chat})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: padding,
        child: Consumer(builder: ((context, ref, child) {
          return GestureDetector(
            onTap: () {
              ref.read(chatsProvider.notifier).setSelectedChat(chat);
              navigatorPush(
                  ChatConversationPage(
                    chat: chat,
                  ),
                  context);
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                children: [
                  chatIcon(photoUrl: chat.photoUrl),
                  Padding(
                    padding: const EdgeInsets.only(top: 4, left: 8, bottom: 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: SizeConfig.width * 0.65,
                          child: Text(
                            chat.name,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: chat.name.length > 22 ? 18 : 24,
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              chat.chatMembersCount().toString(),
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                            horizontalSpacing(4),
                            const Icon(
                              Icons.groups_sharp,
                              color: Colors.amber,
                            )
                          ],
                        ),
                        SizedBox(
                          width: SizeConfig.width * 0.65,
                          child: Text(
                            chat.description ?? '',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: TextStyle(fontSize: 12, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        })));
  }
}
