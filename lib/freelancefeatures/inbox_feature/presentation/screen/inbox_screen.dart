import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/utils/app_icon.dart';
import '../../../../core/utils/constants.dart';
import '../../../chat_feature/presentation/screens/chat_screen.dart';
class InboxScreen extends StatefulWidget {
  const InboxScreen({super.key});

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.primaryColor,
        title: Text(
          'Inbox',
          style: Theme.of(context)
              .textTheme
              .displayLarge
              ?.copyWith(color: Colors.white),
        ),

      ),
      backgroundColor: AppColors.backgroundColor,
    body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          ElevatedButton(onPressed: (){

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const ChatScreen()),
            );
          }, child: Text("go to chat temp"))
        ],

      ),
    ),



    );
  }
}
