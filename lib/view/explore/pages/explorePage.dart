import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drivel/models/chat.dart';
import 'package:drivel/providers/chatProvider.dart/chatProvider.dart';
import 'package:drivel/providers/chatProvider.dart/createChatProvider.dart';
import 'package:drivel/providers/photo/singlePhotoProvider.dart';
import 'package:drivel/services/userService/userService.dart';
import 'package:drivel/utils/navigator.dart';
import 'package:drivel/utils/sizeConfig.dart';
import 'package:drivel/utils/widgets/chatDefaultIcon.dart';
import 'package:drivel/view/chatConversation/page/chatConversationPage.dart';
import 'package:drivel/view/createChat/createChatPage.dart';
import 'package:drivel/view/explore/widgets/explorechatInox.dart';
import 'package:drivel/utils/widgets/userAvatarAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExplorePage extends ConsumerWidget {
  const ExplorePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var myChats = ref.watch(chatsProvider);

    return Scaffold(
        body: WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(children: [
            UserAvatarAppBar(
              title: 'Explore chats',
            ),
            SizedBox(
                height: 90,
                width: SizeConfig.width,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () {
                            UserService.logoutUser(context);
                          },
                          icon: Icon(
                            Icons.logout,
                            color: Colors.white,
                          )),
                      GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            clearCreateChatPage(ref);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const CreateChatPage()));
                          },
                          child: Container(
                            height: 64,
                            width: 64,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(32),
                                color: Colors.white),
                            child: const Icon(
                              Icons.add,
                              color: Colors.black,
                              size: 32,
                            ),
                          )),
                      ...myChats.map((chat) {
                        return Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: GestureDetector(
                              onTap: () {
                                ref
                                    .read(chatsProvider.notifier)
                                    .setSelectedChat(chat);
                                navigatorPush(
                                    ChatConversationPage(
                                      chat: chat,
                                    ),
                                    context);
                              },
                              child: chatIcon(
                                  photoUrl: chat.photoUrl,
                                  height: 64,
                                  width: 64),
                            ));
                      }).toList()
                    ],
                  ),
                )),
            Flexible(
              child: StreamBuilder<QuerySnapshot<Map<dynamic, dynamic>>>(
                  stream: FirebaseFirestore.instance
                      .collection('Chats')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const CircularProgressIndicator();
                    }
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.size,
                        itemBuilder: ((context, index) {
                          Chat chat =
                              Chat.fromJson(snapshot.data!.docs[index].data());

                          return ExploreChatInbox(
                            chat: chat,
                            padding: const EdgeInsets.symmetric(vertical: 8),
                          );
                        }));
                  }),
            )
          ]),
        ),
      ),
    ));
  }

  void clearCreateChatPage(ref) {
    ref.read(photoProvider.notifier).state = null;
    ref.read(createChatProvider.notifier).resetToInit();
  }
}
