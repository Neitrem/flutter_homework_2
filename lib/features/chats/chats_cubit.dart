import 'package:flutter_application_1/domain/models/chat_model.dart';
import 'package:flutter_application_1/domain/models/message_model.dart';
import 'package:flutter_application_1/domain/services/chat_service.dart';
import 'package:flutter_application_1/features/chats/chat_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  final _service = ChatService();

  Future<void> getData() async {
    try {
      emit(ChatLoading());
      final chats = await _service.getChats();
      emit(
        ChatData(chats: chats),
      );
    } catch (e) {
      emit(
        ChatError(error: e.toString(),),
      );
    }
  }

  Future<void> update(List<ChatModel> chats) async {
    _service.update(chats);
  }

  Future<void> sendMessage(ChatModel chat, String text) async {
    _service.sendMessage(chat, text);
  }
}
