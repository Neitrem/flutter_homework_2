import 'package:flutter_application_1/data/models/message_dto.dart';
import 'package:intl/intl.dart';

class MessageModel {
  final int id;
  final String text;
  final String time;
  final String sendler;
  bool unread;

  MessageModel({
    required this.id,
    required this.text,
    required this.time,
    required this.sendler,
    required this.unread
  });
  
  factory MessageModel.fromDTO(MessageDTO dto) => MessageModel(
    id: dto.id,
    text: dto.text,
    time: dto.time,
    sendler: dto.sendler,
    unread: dto.unread,
  );

  factory MessageModel.newMessage(int id, String text, String sendler) {
    DateTime now = DateTime.now();
    String time = DateFormat.jm().format(now);
    final unread = sendler == "you" ? false : true;

    return MessageModel(id: id, text: text, time: time, sendler: sendler, unread: unread);
  }
}