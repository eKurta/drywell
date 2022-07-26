import 'package:drivel/models/chat.dart';
import 'package:drivel/models/chatMessage.dart';
import 'package:drivel/utils/sizeConfig.dart';
import 'package:drivel/utils/spacing.dart';
import 'package:flutter/material.dart';

class ReceivingChatBubble extends StatelessWidget {
  final ChatMessage message;

  ReceivingChatBubble({required this.message, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              constraints: BoxConstraints(maxWidth: SizeConfig.width * 0.8),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(8),
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8)),
                color: Colors.grey.shade800.withOpacity(0.7),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  message.text,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            verticalSpacing(1),
            RichText(
                text: TextSpan(children: [
              const TextSpan(
                  text: 'Sent by ',
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey)),
              TextSpan(
                  text: message.owner.name,
                  style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: Colors.grey))
            ]))
          ],
        ),
      ),
    );
  }
}
