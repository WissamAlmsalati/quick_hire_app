import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quick_hire/core/widgets/custom_text_field.dart';
import 'package:quick_hire/freelancefeatures/inbox_feature/presentation/screen/inbox_screen.dart';

import '../../../../core/utils/app_icon.dart';
import '../../../../core/utils/constants.dart';
import '../../data/models/message_model.dart';
import '../widgets/chat_bubble.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<Message> _messages = [];
  final TextEditingController _controller = TextEditingController();

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _messages.add(Message(text: _controller.text, isSentByMe: true));
        _controller.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        leading: IconButton(
          icon: SvgPicture.asset(
            AppIcons.backIcon,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const InboxScreen()),
            );
          },
        ),
        actions: [
          SvgPicture.asset(
            AppIcons.userIcon,
            color: Colors.white,
          ),
          SizedBox(width: MediaQuery.of(context).size.width * 0.02),
        ],
        automaticallyImplyLeading: false,
        title: Text(
          'Job Chat',
          style: Theme.of(context)
              .textTheme
              .displayLarge
              ?.copyWith(color: Colors.white),
        ),
      ),
      backgroundColor: AppColors.backgroundColor,
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return ChatBubble(message: _messages[index]);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: CustomTextField(controller: _controller, obscureText: false, hintText: 'Type a message'
                      ,
                  ),
                  // child: TextField(

                  //   controller: _controller,
                  //   decoration: InputDecoration(
                  //     hintText: 'Type a message',
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(10.0),
                  //     ),
                  //   ),
                  // ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: IconButton(

                    icon: SvgPicture.asset(AppIcons.sendIcon, color: AppColors.primaryColor,),
                    onPressed: _sendMessage,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}