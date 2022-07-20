import 'package:drivel/models/chat.dart';
import 'package:drivel/providers/chatProvider.dart/chatProvider.dart';
import 'package:drivel/services/chatServices/chatServices.dart';
import 'package:drivel/services/userService/userService.dart';
import 'package:drivel/utils/navigator.dart';
import 'package:drivel/utils/sizeConfig.dart';
import 'package:drivel/utils/spacing.dart';
import 'package:drivel/utils/widgets/appBarDefault.dart';
import 'package:drivel/utils/widgets/chatDefaultIcon.dart';
import 'package:drivel/view/chatConversation/page/removeChatMemberPage.dart';
import 'package:drivel/view/explore/pages/explorePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditChatDrawer extends ConsumerWidget {
  final Chat chat;
  const EditChatDrawer({Key? key, required this.chat}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      backgroundColor: Colors.white,
      width: SizeConfig.width * 0.8,
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            chatIcon(photoUrl: chat.photoUrl, height: 120, width: 120),
            verticalSpacing(8),
            Align(
              alignment: Alignment.center,
              child: Text(
                chat.name,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
              ),
            ),
            verticalSpacing(16),
            const ListTile(
              leading: Icon(Icons.groups_sharp),
              title: Text('Members'),
              subtitle: Text('See all chat members'),
            ),
            const ListTile(
              leading: Icon(Icons.settings_outlined),
              title: Text('Settings'),
              subtitle: Text('Change chat settings, appearance, etc.'),
            ),
            if (chat.amIChatOwner())
              Column(
                children: [
                  ListTile(
                    leading: const Icon(
                      Icons.remove_circle_outline_outlined,
                    ),
                    title: Text('Remove a member'),
                    onTap: () {
                      navigatorPush(RemoveChatMemberPage(chat: chat), context);
                    },
                  ),
                ],
              ),
            const Spacer(),
            ListTile(
              leading: const Icon(
                Icons.logout_outlined,
                color: Colors.red,
              ),
              title: const Text(
                'Leave chat',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
              subtitle: const Text(
                'Leave this dry well',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
              onTap: () {
                ref.read(chatsProvider.notifier).removeChat(chat.id);
                ChatServices.removeChatMember(chat, UserService.user()!.uid);
                Navigator.pushReplacement(
                    context,
                    (MaterialPageRoute<void>(
                      builder: (BuildContext context) => const ExplorePage(),
                    )));
              },
            ),
          ],
        ),
      ),
    );
  }
}
