class MessageDTO {
  final int id;
  final int chatId;
  final String text;
  final BigInt time;
  final bool unread;

  MessageDTO({
    required this.id,
    required this.chatId,
    required this.text,
    required this.time,
    required this.unread
  });
}