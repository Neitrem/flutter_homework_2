import 'package:flutter_application_1/domain/models/chat_model.dart';

sealed class ChatState {}

final class ChatBuildState extends ChatState {}

final class ChatListenState extends ChatState {}

final class ChatInitial extends ChatBuildState {}

final class ChatLoading extends ChatBuildState {}

final class ChatError extends ChatListenState {
  final String error;

  ChatError({required this.error});
}

final class ChatData extends ChatBuildState {
  final List<ChatModel> chats;

  ChatData({required this.chats});
}

sealed class ChatViewState {}

final class ChatViewBuildState extends ChatViewState {}

final class ChatViewInitial extends ChatViewBuildState {}

final class Rebuild extends ChatViewBuildState {}
