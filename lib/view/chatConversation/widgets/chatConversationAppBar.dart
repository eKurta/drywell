import 'package:blurrycontainer/blurrycontainer.dart';
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
    return BlurryContainer(
      blur: 12,
      padding: EdgeInsets.zero,
      borderRadius: BorderRadius.zero,
      height: 90,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 32,
              child: chatIcon(photoUrl: chat.photoUrl, height: 64, width: 64),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  chat.name,
                  textAlign: TextAlign.center,
                  maxLines: 5,
                  style: TextStyle(
                      fontSize: chat.name.length > 30
                          ? 14
                          : chat.name.length > 22
                              ? 18
                              : 24,
                      overflow: TextOverflow.ellipsis,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.more_horiz_outlined),
              onPressed: () {
                scaffoldKey!.currentState!.openEndDrawer();
              },
              color: Colors.white,
              splashColor: Colors.white,
              iconSize: 32,
            ),
          ],
        ),
      ),
    );
  }
}
