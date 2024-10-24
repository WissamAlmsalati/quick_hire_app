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
      final url = 'ws://10.0.2.2:3001'; // Update to your WebSocket server URL
      _channel = WebSocketChannel.connect(Uri.parse(url));

      // Join the chat room
      _channel.sink.add(json.encode({
        'event': 'joinRoom',
        'jobId': widget.jobId,
        'userId': userId,
      }));

      _channel.stream.listen((data) {
        final decodedData = json.decode(data);
        if (decodedData['event'] == 'previousMessages') {
          final messages = (decodedData['data'] as List)
              .map((message) => Message.fromJson(message))
              .toList();
          setState(() {
            _messages.addAll(messages);
          });
        } else if (decodedData['event'] == 'receiveMessage') {
          final message = Message.fromJson(decodedData['data']);
          setState(() {
            _messages.add(message);
          });
        }
        print('Message received: ${decodedData['data']}');
      }, onError: (error) {
        print('WebSocket error: $error');
      }, onDone: () {
        print('WebSocket connection closed');
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

        _channel.sink.add(json.encode({
          'event': 'sendMessage',
          'jobId': widget.jobId,
          'sender': userId,
          'message': _controller.text,
        }));

        print('Message sent: ${_controller.text}');

        setState(() {
          _messages.add(message);
          _controller.clear();
        });
      }
    } else {
      print('Message is empty, not sent');
    }
  }

  @override
  Widget build(BuildContext context) {
    print(widget.jobId);

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