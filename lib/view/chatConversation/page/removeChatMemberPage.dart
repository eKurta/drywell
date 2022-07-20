import 'package:drivel/models/chat.dart';
import 'package:drivel/utils/columnPage.dart';
import 'package:drivel/utils/widgets/appBarDefault.dart';
import 'package:drivel/utils/widgets/chatDefaultIcon.dart';
import 'package:drivel/utils/widgets/userAvatar.dart';
import 'package:flutter/material.dart';

class RemoveChatMemberPage extends StatelessWidget {
  final Chat chat;
  const RemoveChatMemberPage({Key? key, required this.chat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return columnPage(children: [
      const Padding(
        padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: AppBarDefault(
          title: 'Remove a user',
        ),
      ),
      ...chat.chatMembers.map((e) => ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.grey.shade300,
              radius: 24,
              foregroundImage:
                  e.photoUrl != null ? NetworkImage(e.photoUrl!) : null,
            ),
            title: Text(e.name),
            trailing: const Icon(
              Icons.remove_circle_outline_outlined,
            ),
          ))
    ], padding: EdgeInsets.zero);
  }
}
