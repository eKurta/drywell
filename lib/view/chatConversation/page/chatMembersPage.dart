import 'package:drivel/models/chat.dart';
import 'package:drivel/utils/columnPage.dart';
import 'package:drivel/utils/widgets/appBarDefault.dart';
import 'package:flutter/material.dart';

class ChatMembersPage extends StatelessWidget {
  final Chat chat;
  const ChatMembersPage({Key? key, required this.chat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return columnPage(children: [
      const Padding(
        padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: AppBarDefault(
          title: 'Chat members',
        ),
      ),
      ...chat.chatMembers.map((e) => ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.grey.shade300,
              radius: 24,
              foregroundImage:
                  e.photoUrl != null ? NetworkImage(e.photoUrl!) : null,
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  e.name,
                  style: const TextStyle(color: Colors.white),
                ),
                if (e.id == chat.ownerId)
                  const Text(
                    'Owner',
                    style: TextStyle(color: Colors.white, fontSize: 11),
                  )
              ],
            ),
          ))
    ], padding: EdgeInsets.zero);
  }
}
