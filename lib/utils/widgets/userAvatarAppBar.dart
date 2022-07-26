import 'package:drivel/utils/widgets/userAvatar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserAvatarAppBar extends ConsumerWidget {
  final String title;

  UserAvatarAppBar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    User user = FirebaseAuth.instance.currentUser!;
    return SizedBox(
      height: 32,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          userAvatar(24),
          Expanded(
              child: Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 32),
                    child: Text(
                      title,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ))),
          IconButton(
            onPressed: () {},
            padding: EdgeInsets.zero,
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {},
            padding: EdgeInsets.zero,
            icon: Icon(
              Icons.notifications_outlined,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
