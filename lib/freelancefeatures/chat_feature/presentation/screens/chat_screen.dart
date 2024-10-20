import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quick_hire/core/widgets/custom_text_field.dart';
import 'package:quick_hire/freelancefeatures/inbox_feature/presentation/screen/inbox_screen.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../../core/utils/app_icon.dart';
import '../../../../core/utils/constants.dart';
import '../../../authintication_screens/data/datasources/local/auth_local_data_source.dart';
import '../../data/models/message_model.dart';
import '../widgets/chat_bubble.dart';

class ChatScreen extends StatefulWidget {
  final String jobId;
  const ChatScreen({super.key, required this.jobId});


  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<Message> _messages = [];
  final TextEditingController _controller = TextEditingController();
  late WebSocketChannel _channel;
  late AuthLocalDataSource _authLocalDataSource;

  @override
  void initState() {
    super.initState();
    _authLocalDataSource = AuthLocalDataSource(FlutterSecureStorage());
    _initializeWebSocket();
  }

  Future<void> _initializeWebSocket() async {
    final userType = await _authLocalDataSource.getUserType();
    final userId = await _authLocalDataSource.getId();

    if (userType != null && userId != null) {
      final freelancerId = userType == 'freelance' ? userId : '';
      final clientId = userType == 'client' ? userId : '';

      final url = 'http://blooming-inlet-19967-0478a7dc2f5d.herokuapp.com/api/chats/${widget.jobId}/$freelancerId/$clientId';
      _channel = WebSocketChannel.connect(Uri.parse(url));

      _channel.stream.listen((data) {
        final message = Message.fromJson(json.decode(data));
        setState(() {
          _messages.add(message);
        });
      });
    }
  }

  @override
  void dispose() {
    _channel.sink.close();
    _controller.dispose();
    super.dispose();
  }

  Future<void> _sendMessage() async {
    if (_controller.text.isNotEmpty) {
      final userType = await _authLocalDataSource.getUserType();
      final userId = await _authLocalDataSource.getId();

      if (userType != null && userId != null) {
        final message = Message(
          text: _controller.text,
          isSentByMe: true,
          freelanceId: userType == 'freelance' ? userId : '',
          clientId: userType == 'client' ? userId : '',
          jobId: widget.jobId,
        );

        _channel.sink.add(json.encode(message.toJson()));

        // Log success message to console
        print('Message sent successfully: ${_controller.text}');

        setState(() {
          _messages.add(message);
          _controller.clear();
        });
      }
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
                  child: CustomTextField(
                    controller: _controller,
                    obscureText: false,
                    hintText: 'Type a message',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: IconButton(
                    icon: SvgPicture.asset(
                      AppIcons.sendIcon,
                      color: AppColors.primaryColor,
                    ),
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