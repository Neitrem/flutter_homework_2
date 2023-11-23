import 'package:flutter/material.dart';
import 'package:flutter_application_1/domain/models/chat_model.dart';
import 'package:flutter_application_1/domain/models/message_model.dart';
import 'package:flutter_application_1/styles/styles.dart';
import 'dart:developer';

class ChatView extends StatefulWidget {
  dynamic Function(String text) sendMessage;
  ChatModel chat;
  ChatView({super.key, required this.chat, required this.sendMessage});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {

 void addMessage(String message) {
  setState(() {
    widget.sendMessage(message);
  });
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        title: Text(widget.chat.name),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 10,
            child: MessageList(messages: widget.chat.messages),
          ),
          Expanded(
            flex: 1,
            child: InputBar(sendMessage: widget.sendMessage,),
          ),
        ],
      ) 
    );
  }
}

class InputBar extends StatefulWidget {
  dynamic Function(String text) sendMessage;
  InputBar({super.key, required this.sendMessage});

  @override
  State<InputBar> createState() => _InputBarState();
}

class _InputBarState extends State<InputBar> {


  final inputController = TextEditingController();

  void send() {
    setState(() {
      if (inputController.text.isNotEmpty) {
        widget.sendMessage(inputController.text);
        inputController.clear();
      }
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          children: <Widget>[
            const Icon(Icons.add_a_photo ,color: serviceColor, size: 30,),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: TextField(
                  controller: inputController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Message',
                    hintStyle: TextStyle(
                      color: serviceColor
                    ),
                  ),
                ),
              ),
            ),
            IconButton(onPressed: send, icon: const Icon(Icons.send, size: 30.0,))
          ],
        ),
    );
  }
}

class MessageList extends StatefulWidget {
  List<MessageModel> messages;
  MessageList({super.key, required this.messages});

  @override
  State<MessageList> createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> {

   _messageBuilder(MessageModel message, bool isMe) {
    return Container(
      color: isMe
      ? Color.fromARGB(255, 28, 133 + message.id * 20, 225)
      : Color.fromARGB(255, 225, 100 + message.id * 20, 17),
      margin: isMe
        ? const EdgeInsets.only(
          bottom: 8.0,
          left: 80.0,
          right: 8.0
        )
        : const EdgeInsets.only(
          bottom: 8.0,
          left: 8.0,
          right: 80.0
        ),
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(message.time),
          Text(message.text)
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: ListView.builder(
        physics: const ClampingScrollPhysics(),
        reverse: true,
        itemCount: widget.messages.length,
        itemBuilder: (context, index) {
          final bool isMe = widget.messages[index].sendler == "you";
          return _messageBuilder(widget.messages[index], isMe);
        },
      ),
    );
  }
}