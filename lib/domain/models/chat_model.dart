import 'package:flutter_application_1/data/models/chat_dto.dart';
import 'package:flutter_application_1/domain/models/message_model.dart';

class ChatModel {
  final int id;
  final String name;
  List<MessageModel> messages;

  ChatModel({
    required this.id,
    required this.name,
    required this.messages
  });

  factory ChatModel.fromDTO(ChatDTO dto)  {
    List<MessageModel> messages = (dto.messages.map((e) => MessageModel.fromDTO(e))).toList();
    return ChatModel(
      id: dto.id,
      name: dto.name,
      messages: messages
    );
  }

  int get unreadCount {
    int count = 0;
    for (MessageModel m in messages) {
      if (m.unread) count += 1;
    }
    return count;
  }

  void readAll() {
    for (MessageModel message in messages) {
      message.unread = false;
    }
  }
}