import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/chat_view.dart';
import 'package:flutter_application_1/domain/models/chat_model.dart';
import 'package:flutter_application_1/features/chats/chats_cubit.dart';
import 'package:flutter_application_1/styles/styles.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatLIst extends StatefulWidget {
  final List<ChatModel> chats;
  final dynamic Function() update;

  const ChatLIst({super.key, required this.chats, required this.update});

  @override
  State<ChatLIst> createState() => _ChatLIstState();
}

class _ChatLIstState extends State<ChatLIst> {

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: context.read<ChatCubit>().update,
      child: ListView.separated(
        itemCount: widget.chats.length,
        separatorBuilder: (BuildContext context, int index) {
          return const Divider(
            indent: 90.0,
          );
        },
        itemBuilder: (context, index) {
          return ChatCard(
            model: widget.chats[index],
          );
        },
        
      ),
    );
  }
}

class ChatCard extends StatefulWidget {
  final ChatModel model;


  const ChatCard({super.key, required this.model});

  @override
  State<ChatCard> createState() => _ChatCardState();
}

class _ChatCardState extends State<ChatCard> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap:() {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ChatView(
              chat: widget.model,
            )
          ),
        );
        setState(() {
          widget.model.readAll();
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: <Widget>[
                const Icon(Icons.person, size: 60,),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        widget.model.name,
                        style: chatTitleStyle,
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        widget.model.messages.first.text,
                        style: chatLastMessStyle,
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(widget.model.messages.last.time),
                if (widget.model.unreadCount > 0)
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                      color: mainColor,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      widget.model.unreadCount.toString(),
                    ),
                  ),
               
              ],
            )
          ],
        ),
      ),
    );
  }
}