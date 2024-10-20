import 'dart:convert';

class Message {
  final String text;
  final bool isSentByMe;
  final String freelanceId;
  final String clientId;
  final String jobId;

  Message({
    required this.text,
    required this.isSentByMe,
    required this.freelanceId,
    required this.clientId,
    required this.jobId,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      text: json['text'] ?? '',
      isSentByMe: json['isSentByMe'] ?? false,
      freelanceId: json['freelanceId'] ?? '',
      clientId: json['clientId'] ?? '',
      jobId: json['jobId'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'isSentByMe': isSentByMe,
      'freelanceId': freelanceId,
      'clientId': clientId,
      'jobId': jobId,
    };
  }
}