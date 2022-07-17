import 'dart:io';

import 'package:drivel/providers/chatProvider.dart/createChatProvider.dart';
import 'package:drivel/providers/photo/singlePhotoProvider.dart';
import 'package:drivel/services/chatServices/chatServices.dart';
import 'package:drivel/utils/buttons/bigDefaultButton.dart';
import 'package:drivel/utils/columnPage.dart';
import 'package:drivel/utils/loading.dart';
import 'package:drivel/utils/navigator.dart';
import 'package:drivel/utils/sizeConfig.dart';
import 'package:drivel/utils/spacing.dart';
import 'package:drivel/utils/widgets/appBarDefault.dart';
import 'package:drivel/utils/widgets/line.dart';
import 'package:drivel/utils/widgets/namedTextField.dart';
import 'package:drivel/view/explore/pages/explorePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class CreateChatPage extends ConsumerWidget {
  const CreateChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var createChatNotifier = ref.watch(createChatProvider);
    var isLoading = ref.watch(loadingProvider);
    return columnPage(children: [
      const AppBarDefault(title: 'Create new chat'),
      verticalSpacing(16),
      addChatLogo(ref.watch(photoProvider), ref, context),
      verticalSpacing(16),
      NamedTextField(
        name: 'CHAT NAME',
        onChanged: (text) =>
            ref.read(createChatProvider.notifier).setName(text),
      ),
      NamedTextField(
        name: 'CHAT DESCRIPTION',
        onChanged: (text) =>
            ref.read(createChatProvider.notifier).setDescription(text),
        maxLines: null,
      ),
      verticalSpacing(8),
      CheckboxListTile(
        value: createChatNotifier.allowOtherToRespond,
        onChanged: (value) {
          createChatNotifier.toggleAllowOtherToRespond(value);
        },
        title: const Text('Allow others to respond to this chat'),
        controlAffinity: ListTileControlAffinity.leading,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        contentPadding: EdgeInsets.zero,
      ),
      const Spacer(),
      const ChatPreview(),
      verticalSpacing(16),
      bigDefaultButton('Create chat', () async {
        if (!isLoading) {
          print('OPPP');
          ref.read(loadingProvider.notifier).state = true;

          File? photo = ref.watch(photoProvider) != null
              ? File(ref.watch(photoProvider)!.path)
              : null;

          if (createChatNotifier.canCreate()) {
            if (await ChatServices.createChat(
                await createChatNotifier.getCreatedChat(photo))) {
              navigatorPush(const ExplorePage(), context);
            }
            ;
          }
          ref.refresh(loadingProvider);
        }
      }, context, isLoading)
    ]);
  }

  Widget addChatLogo(photo, ref, context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () async {
            ref.read(photoProvider.notifier).state = await ImagePicker()
                    .pickImage(source: ImageSource.gallery, imageQuality: 10) ??
                photo;
          },
          child: Container(
            height: 160,
            width: 160,
            decoration: BoxDecoration(
                image: photo != null
                    ? DecorationImage(
                        image: Image.file(File(photo.path)).image,
                        fit: BoxFit.fill)
                    : const DecorationImage(
                        image: AssetImage('assets/images/defaultChatIcon.png')),
                borderRadius: BorderRadius.circular(80),
                border: Border.all(
                    color: Theme.of(context).primaryColor, width: 2)),
          ),
        ),
        Positioned(
          right: 16,
          child: GestureDetector(
            onTap: () async {
              if (ref.watch(photoProvider) == null) {
                ref.read(photoProvider.notifier).state = await ImagePicker()
                    .pickImage(source: ImageSource.gallery, imageQuality: 10);
              } else {
                ref.read(photoProvider.notifier).state = null;
              }
            },
            child: Container(
              height: 32,
              width: 32,
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(16)),
              child: AnimatedRotation(
                turns: photo != null ? 0.125 : 0,
                duration: const Duration(milliseconds: 300),
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

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
