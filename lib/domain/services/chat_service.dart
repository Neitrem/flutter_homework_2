import 'dart:async';
import 'dart:math';
import 'package:flutter_application_1/data/repository/chat_repository.dart';
import 'package:flutter_application_1/domain/models/chat_model.dart';
import 'package:flutter_application_1/domain/models/message_model.dart';

extension MoveElement<T> on List<T> {
    void move(int from, int to) {
      RangeError.checkValidIndex(from, this, "from", length);
      RangeError.checkValidIndex(to, this, "to", length);
      var element = this[from];
      if (from < to) {
        this.setRange(from, to, this, from + 1);
      } else {
        this.setRange(to + 1, from + 1, this, to);
      }
      this[to] = element;
    }
  }

class ChatService {
  final _repository = ChatRepository();

  Future<List<ChatModel>> getChats() async {
    Future.delayed(const Duration(seconds: 1), () {});
    final list = await _repository.getChats();
    if (list==null) return [];
    return list.map((e) => ChatModel.fromDTO(e)).toList();
  }

  void update(List<ChatModel> data) {
    final rInt = Random().nextInt(2);
    switch(rInt) {
      case 0:
        addNewChat(data);
        break;
      case 1:
        rAddNewMessage(data);
        break;
    }
  }

  void addNewChat(List<ChatModel> data) {
    final int newChatId = data.length;
    final String name = getRandomString(10);
    ChatModel chat = ChatModel(id: newChatId, name: name, messages: []);
    for (int i = 0; i < 5; i++) {
      addNewMessage(chat);
    }
    data.insert(0, chat);
  }

  void rAddNewMessage(List<ChatModel> data) {
    final rChatId = Random().nextInt(data.length);
    for (int i = 0; i < data.length; i++) {
      if (data[i].id == rChatId) {
        addNewMessage(data[i]);
        data.move(i, 0);
        break;
      }
    }
  }

  

  void addNewMessage(ChatModel chat) {
    final int lastId;
    if (chat.messages.isNotEmpty) {
      lastId = chat.messages.first.id;
    } else {
      lastId = 0;
    }
    
    chat.messages.insert(0, MessageModel.newMessage(lastId + 1, getRandomString(10), "other"));
  }

  String getRandomString(int length) {
      Random rnd = Random();
      const chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
      return String.fromCharCodes(Iterable.generate(
        length, (_) => chars.codeUnitAt(rnd.nextInt(chars.length),),),);
    }
}