import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/data/models/chat_dto.dart';

class ChatRepository {
  List<ChatDTO> chatList = [];

  Future<List<ChatDTO>?> getChats() async {
    final String response = await rootBundle.loadString('assets/data_chats.json');
    final data = await json.decode(response)["chats"] as List<dynamic>;

    return (data.cast<Map<String, dynamic>>()).map((e) => ChatDTO.fromJson(e)).toList();
  }

}