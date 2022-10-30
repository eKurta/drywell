import 'package:drivel/providers/chatProvider.dart/chatProvider.dart';
import 'package:drivel/providers/user/userMessageProvider.dart';
import 'package:drivel/services/userService/userService.dart';
import 'package:drivel/utils/columnPage.dart';
import 'package:drivel/utils/spacing.dart';
import 'package:drivel/utils/widgets/userAvatar.dart';
import 'package:drivel/view/profile/widgets/profileTile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return columnPage(children: [
      SizedBox(
        width: double.infinity,
      ),
      verticalSpacing(32),
      Stack(
        children: [
          userAvatar(64),
          Positioned(
            right: 0,
            child: CircleAvatar(
              backgroundColor: Colors.black,
              radius: 22,
              child: CircleAvatar(
                backgroundColor: Theme.of(context).primaryColor,
                child: Icon(
                  Icons.photo_camera,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
      verticalSpacing(16),
      Text(
        UserService.user()!.displayName!,
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.w700, fontSize: 32),
      ),
      verticalSpacing(16),
      analitycs(),
      verticalSpacing(32),
      Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey.shade800.withOpacity(0.6)),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            child: Column(
              children: [
                ProfileTile(
                    icon: Icons.store_outlined, text: 'Upgrade your account'),
                ProfileTile(
                    icon: Icons.account_circle_outlined, text: 'Edit profile'),
                ProfileTile(icon: Icons.notifications, text: 'Notifications'),
                ProfileTile(icon: Icons.save, text: 'Saved messages'),
              ],
            ),
          )),
      Spacer(),
      logOut(context)
    ]);
  }

  Widget logOut(context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        UserService.logoutUser(context);
      },
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey.shade800.withOpacity(0.6)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(
                  Icons.logout_outlined,
                  color: Colors.red,
                  size: 30,
                ),
                horizontalSpacing(16),
                Text(
                  'Log out',
                  style: TextStyle(color: Colors.red, fontSize: 16),
                ),
              ],
            ),
          )),
    );
  }

  Widget analitycs() {
    return Consumer(builder: (_, ref, __) {
      var myChats = ref.watch(chatsProvider);
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Text(ref.watch(userMessageProvider).toString(),
                  style: TextStyle(
                    color: Colors.amber,
                    fontWeight: FontWeight.w500,
                    fontSize: 32,
                  )),
              Text('Messages',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                  ))
            ],
          ),
          Column(
            children: [
              Text(myChats.length.toString(),
                  style: TextStyle(
                    color: Colors.amber,
                    fontWeight: FontWeight.w500,
                    fontSize: 32,
                  )),
              Text('Current chats',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                  ))
            ],
          ),
          // Column(
          //   children: [
          //     Text('64',
          //         style: TextStyle(
          //           color: Colors.white,
          //           fontWeight: FontWeight.w500,
          //           fontSize: 32,
          //         )),
          //     Text('Reactions',
          //         style: TextStyle(
          //           color: Colors.white,
          //           fontWeight: FontWeight.w400,
          //           fontSize: 12,
          //         ))
          //   ],
          // )
        ],
      );
    });
  }
}
