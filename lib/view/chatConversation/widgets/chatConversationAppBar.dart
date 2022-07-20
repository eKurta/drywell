import 'package:drivel/models/chat.dart';
import 'package:drivel/utils/widgets/chatDefaultIcon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatConversationAppBar extends ConsumerWidget {
  final Chat chat;
  final GlobalKey<ScaffoldState>? scaffoldKey;
  const ChatConversationAppBar({required this.chat, Key? key, this.scaffoldKey})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 96,
      child: Row(
        children: [
          CircleAvatar(
            radius: 32,
            child: chatIcon(photoUrl: chat.photoUrl, height: 64, width: 64),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 18),
              child: Text(
                chat.name,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.more_horiz_outlined),
            onPressed: () {
              scaffoldKey!.currentState!.openEndDrawer();
            },
            splashColor: Colors.grey.shade300,
            iconSize: 32,
          ),
        ],
      ),
    );
  }
}
