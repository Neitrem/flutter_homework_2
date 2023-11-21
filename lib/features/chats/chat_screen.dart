import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/chat_list.dart';
import 'package:flutter_application_1/features/chats/chat_state.dart';
import 'package:flutter_application_1/features/chats/chats_cubit.dart';
import 'package:flutter_application_1/styles/styles.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatState();
}

class _ChatState extends State<ChatPage> {
  final ChatCubit cubit =  ChatCubit();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        elevation: 0.0,
        leading: const Icon(Icons.menu),
        title: const Text("Chat List"),
      ),
      body: Center(
        child: BlocProvider(
          create: (context) => ChatCubit(),
          child: BlocConsumer<ChatCubit, ChatState>(
            listener: (context, state) {
              if (state is ChatError) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('error'),
                      content: Text(state.error),
                    );
                  },
                );
              }
            },
            buildWhen: (previous, current) => current is ChatBuildState,
            builder: (context, state) {
              

              if(state is ChatLoading) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.red,
                  ),
                );
              } else if(state is ChatData) {
                void update() {
                  context.read<ChatCubit>().update(state.chats);
                }
                return ChatLIst(
                  chats: state.chats,
                  update: update,
                  sendMessage: context.read<ChatCubit>().,
                );
              } else if (state is ChatInitial) {
                context.read<ChatCubit>().getData();
              }
              return const Text("Error");
            },
          ),
        )
      ),
    );
  }
}

