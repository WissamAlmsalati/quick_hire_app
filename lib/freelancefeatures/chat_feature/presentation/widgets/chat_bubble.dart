// chat_bubble.dart
import 'package:flutter/material.dart';
import 'package:quick_hire/core/utils/constants.dart';

import '../../data/models/message_model.dart';


class ChatBubble extends StatelessWidget {
  final Message message;

  const ChatBubble({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: message.isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 10.0),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: message.isSentByMe ? AppColors.primaryColor : Colors.grey[300],
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Text(
          message.text,
          style: TextStyle(color: message.isSentByMe ? Colors.white : AppColors.typographyColor),
        ),
      ),
    );
  }
}