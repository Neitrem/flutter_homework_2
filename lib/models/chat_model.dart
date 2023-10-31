import 'package:flutter_application_1/models/message_model.dart';

class Chat {
  final String name;
  final List<Message> messages;

  Chat({
    required this.name,
    required this.messages
  });
}