import 'dart:io';

import 'package:drivel/providers/chatProvider.dart/createChatProvider.dart';
import 'package:drivel/providers/photo/singlePhotoProvider.dart';
import 'package:drivel/utils/sizeConfig.dart';
import 'package:drivel/utils/spacing.dart';
import 'package:drivel/utils/widgets/line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatPreview extends ConsumerWidget {
  const ChatPreview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var createChatNotifier = ref.watch(createChatProvider);
    var photo = ref.watch(photoProvider);
    return Column(
      children: [
        const Text(
          'CHAT PREVIEW',
          style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.3),
        ),
        verticalSpacing(8),
        line(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              children: [
                Container(
                  height: 76,
                  width: 76,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      image: photo != null
                          ? DecorationImage(
                              image: Image.file(File(photo.path)).image,
                              fit: BoxFit.fill)
                          : const DecorationImage(
                              image: AssetImage(
                                  'assets/images/defaultChatIcon.png'))),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4, left: 8, bottom: 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (createChatNotifier.name != null)
                        SizedBox(
                          width: SizeConfig.width * 0.65,
                          child: Text(
                            createChatNotifier.name!,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: createChatNotifier.name!.length > 22
                                    ? 18
                                    : 24,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      if (createChatNotifier.name != null)
                        Row(
                          children: [
                            const Text(
                              '1',
                              style: TextStyle(fontSize: 16),
                            ),
                            horizontalSpacing(4),
                            const Icon(
                              Icons.groups_sharp,
                              color: Colors.amber,
                            )
                          ],
                        ),
                      if (createChatNotifier.description != null)
                        SizedBox(
                          width: SizeConfig.width * 0.65,
                          child: Text(
                            createChatNotifier.description!,
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
        ),
        line(),
      ],
    );
  }
}
