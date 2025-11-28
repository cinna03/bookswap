class ChatEntity {
  final String id;
  final String swapId;
  final List<String> participants;
  final String lastMessage;
  final DateTime lastMessageTime;

  const ChatEntity({
    required this.id,
    required this.swapId,
    required this.participants,
    required this.lastMessage,
    required this.lastMessageTime,
  });
}

class MessageEntity {
  final String id;
  final String chatId;
  final String senderId;
  final String content;
  final DateTime timestamp;

  const MessageEntity({
    required this.id,
    required this.chatId,
    required this.senderId,
    required this.content,
    required this.timestamp,
  });
}