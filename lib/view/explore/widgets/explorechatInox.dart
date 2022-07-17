import 'package:cached_network_image/cached_network_image.dart';
import 'package:drivel/models/chat.dart';
import 'package:drivel/utils/sizeConfig.dart';
import 'package:drivel/utils/spacing.dart';
import 'package:flutter/material.dart';

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
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          children: [
            chat.photoUrl != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: CachedNetworkImage(
                        fadeInDuration: const Duration(milliseconds: 300),
                        fit: BoxFit.fill,
                        height: 76,
                        width: 76,
                        imageUrl: chat.photoUrl!),
                  )
                : Container(
                    height: 76,
                    width: 76,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        image: const DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage(
                                'assets/images/defaultChatIcon.png'))),
                  ),
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
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        chat.chatMembersCount().toString(),
                        style: TextStyle(fontSize: 16),
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
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
