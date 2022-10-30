import 'package:drivel/models/chat.dart';
import 'package:drivel/providers/chatProvider.dart/chatProvider.dart';
import 'package:drivel/services/chatServices/chatServices.dart';
import 'package:drivel/services/userService/userService.dart';
import 'package:drivel/utils/navigator.dart';
import 'package:drivel/utils/sizeConfig.dart';
import 'package:drivel/utils/spacing.dart';
import 'package:drivel/utils/widgets/chatDefaultIcon.dart';
import 'package:drivel/utils/widgets/line.dart';
import 'package:drivel/view/chatConversation/page/chatMembersPage.dart';
import 'package:drivel/view/chatConversation/page/removeChatMemberPage.dart';
import 'package:drivel/view/explore/pages/explorePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditChatDrawer extends ConsumerWidget {
  const EditChatDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Chat chat = ref.watch(chatsProvider.notifier).selectedChat!;
    return Drawer(
      backgroundColor: Colors.grey.shade900,
      width: SizeConfig.width * 0.8,
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            chatIcon(photoUrl: chat.photoUrl, height: 120, width: 120),
            verticalSpacing(12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                chat.name,
                maxLines: 5,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: chat.name.length > 30
                        ? 14
                        : chat.name.length > 22
                            ? 18
                            : 24,
                    overflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
            ),
            verticalSpacing(16),
            sectionTitle('Chat facts'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Messages in chat',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w400),
                  ),
                  Text(
                    chat.numberOfChatMessages.toString(),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w400),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(16, 0, 16, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Most messages in chat',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w400),
                  ),
                  Text(
                    chat.biggestChatter!,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w400),
                  )
                ],
              ),
            ),

            verticalSpacing(16),
            sectionTitle('Chat info'),
            ListTile(
              leading: const Icon(Icons.groups_sharp, color: Colors.white),
              title: const Text(
                'Members',
                style: TextStyle(color: Colors.white),
              ),
              subtitle: const Text('See all chat members',
                  style: TextStyle(color: Colors.white)),
              onTap: () {
                navigatorPush(ChatMembersPage(chat: chat), context);
              },
            ),

            // const ListTile(
            //   leading: Icon(Icons.settings_outlined, color: Colors.white),
            //   title: Text('Settings', style: TextStyle(color: Colors.white)),
            //   subtitle: Text('Change chat settings, appearance, etc.',
            //       style: TextStyle(color: Colors.white)),
            // ),
            if (chat.amIChatOwner())
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  verticalSpacing(16),
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text(
                      'Admin command panel',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.remove_circle_outline_outlined,
                        color: Colors.white),
                    title: Text('Remove a member',
                        style: TextStyle(color: Colors.white)),
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

  Widget sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: SizedBox(
        width: double.infinity,
        child: Text(
          text,
          textAlign: TextAlign.left,
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
