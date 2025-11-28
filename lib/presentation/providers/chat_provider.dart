import 'package:flutter/material.dart';
import '../../data/models/chat_model.dart';
import '../../data/repositories/chat_repository.dart';

class ChatProvider extends ChangeNotifier {
  final ChatRepository _repository = ChatRepository();
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<String?> createChat(String swapId, List<String> participants) async {
    try {
      return await _repository.createChat(swapId, participants);
    } catch (e) {
      return null;
    }
  }

  Future<String?> sendMessage({
    required String chatId,
    required String senderId,
    required String content,
  }) async {
    try {
      final messageId = DateTime.now().millisecondsSinceEpoch.toString();
      final message = MessageModel(
        id: messageId,
        chatId: chatId,
        senderId: senderId,
        content: content,
        timestamp: DateTime.now(),
      );

      await _repository.sendMessage(message);
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  Stream<List<ChatModel>> getUserChats(String userId) =>
      _repository.getUserChats(userId);

  Stream<List<MessageModel>> getChatMessages(String chatId) =>
      _repository.getChatMessages(chatId);
}