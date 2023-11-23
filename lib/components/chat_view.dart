import 'package:flutter/material.dart';
import 'package:flutter_application_1/domain/models/chat_model.dart';
import 'package:flutter_application_1/domain/models/message_model.dart';
import 'package:flutter_application_1/features/chats/chat_state.dart';
import 'package:flutter_application_1/features/chats/chats_cubit.dart';
import 'package:flutter_application_1/styles/styles.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatView extends StatelessWidget {
  final ChatModel chat;

  const ChatView({super.key, required this.chat});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        title: Text(chat.name),
      ),
      body: BlocProvider(
        create: (context) => ChatViewCubit(chat),
        child: BlocBuilder<ChatViewCubit, ChatViewState>(
          builder: (context, state) {
            return Column(
              children: <Widget>[
                Expanded(
                  flex: 10,
                  child: MessageList(messages: chat.messages),
                ),
                Expanded(
                  flex: 1,
                  child: InputBar(chat: chat),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class InputBar extends StatefulWidget {
  final ChatModel chat;

  const InputBar({
    super.key,
    required this.chat,
  });

  @override
  State<InputBar> createState() => _InputBarState();
}

class _InputBarState extends State<InputBar> {
  final inputController = TextEditingController();

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
          const Icon(
            Icons.add_a_photo,
            color: serviceColor,
            size: 30,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: TextField(
                controller: inputController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Message',
                  hintStyle: TextStyle(color: serviceColor),
                ),
              ),
            ),
          ),
          IconButton(
              onPressed: () {
                if (inputController.text.isNotEmpty) {
                  context.read<ChatCubit>().sendMessage(widget.chat, inputController.text);
                  inputController.clear();
                  context.read<ChatViewCubit>().rebuild();
                }
              },
              icon: const Icon(
                Icons.send,
                size: 30.0,
              ))
        ],
      ),
    );
  }
}

class MessageList extends StatelessWidget {
  final List<MessageModel> messages;

  const MessageList({super.key, required this.messages});

  _messageBuilder(MessageModel message, bool isMe) {
    return Container(
      color: isMe
          ? Color.fromARGB(255, 28, 133 + message.id * 20, 225)
          : Color.fromARGB(255, 225, 100 + message.id * 20, 17),
      margin: isMe
          ? const EdgeInsets.only(bottom: 8.0, left: 80.0, right: 8.0)
          : const EdgeInsets.only(bottom: 8.0, left: 8.0, right: 80.0),
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[Text(message.time), Text(message.text)],
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
        itemCount: messages.length,
        itemBuilder: (context, index) {
          final bool isMe = messages[index].sendler == "you";
          return _messageBuilder(messages[index], isMe);
        },
      ),
    );
  }
}
