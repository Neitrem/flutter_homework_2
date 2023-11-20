class MessageDTO {
  final int id;
  final String text;
  final String time;
  final String sendler;
  final bool unread;

  MessageDTO({
    required this.id,
    required this.text,
    required this.time,
    required this.sendler,
    required this.unread
  });
  
  factory MessageDTO.fromJson(Map<String, dynamic> json) => MessageDTO(
    id: json["id"],
    text: json["text"],
    time: json["time"],
    sendler: json["sendler"],
    unread: json["unread"],
  );

}