import 'package:flutter_application_1/data/models/message_dto.dart';

class ChatDTO {
  final int id;
  final String name;
  List<MessageDTO> messages;

  ChatDTO({
    required this.id,
    required this.name,
    required this.messages
  });

  factory ChatDTO.fromJson(Map<String, dynamic> json) {
    final messagesData = json["messages"] as List<dynamic>;
    List<MessageDTO> messages = (messagesData.cast<Map<String, dynamic>>()).map((e) => MessageDTO.fromJson(e)).toList();
    return ChatDTO(
      id: json["id"],
      name: json["name"],
      messages: messages
    );
  }
}