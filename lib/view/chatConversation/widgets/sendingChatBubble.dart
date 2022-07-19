import 'package:drivel/models/chatMessage.dart';
import 'package:drivel/utils/sizeConfig.dart';
import 'package:flutter/material.dart';

class SendingChatBubble extends StatelessWidget {
  final ChatMessage message;
  SendingChatBubble({required this.message, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Container(
          constraints: BoxConstraints(maxWidth: SizeConfig.width * 0.8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(8),
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8)),
            color: Colors.amber.shade400,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(message.text),
          ),
        ),
      ),
    );
  }
}
