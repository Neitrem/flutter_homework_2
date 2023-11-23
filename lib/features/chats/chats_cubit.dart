import 'package:flutter_application_1/domain/models/chat_model.dart';
import 'package:flutter_application_1/domain/services/chat_service.dart';
import 'package:flutter_application_1/features/chats/chat_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatCubit extends Cubit<ChatState> {
  List<ChatModel> chats = [];

  ChatCubit() : super(ChatInitial());

  final _service = ChatService();

  Future<void> getData() async {
    try {
      emit(ChatLoading());
      chats = await _service.getChats();
      emit(
        ChatData(chats: chats),
      );
    } catch (e) {
      emit(
        ChatError(
          error: e.toString(),
        ),
      );
    }
  }

  Future<void> update() async {
    _service.update(chats);
    emit(
      ChatData(chats: chats),
    );
  }

  Future<void> sendMessage(ChatModel chat, String text) async {
    _service.sendMessage(chat, text);
    emit(
      ChatData(chats: chats),
    );
  }

  void rebuild() {
    emit(
      ChatData(chats: chats),
    );
  }
}

class ChatViewCubit extends Cubit<ChatViewState> {
  final ChatModel model;
  ChatViewCubit(this.model) : super(ChatViewInitial());

  final _service = ChatService();

  void rebuild() {
    emit(Rebuild());
  }
}
