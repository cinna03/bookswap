import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/chat_model.dart';

class ChatRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> createChat(String swapId, List<String> participants) async {
    final chatId = DateTime.now().millisecondsSinceEpoch.toString();
    final chat = ChatModel(
      id: chatId,
      swapId: swapId,
      participants: participants,
      lastMessage: '',
      lastMessageTime: DateTime.now(),
    );

    await _firestore.collection('chats').doc(chatId).set(chat.toMap());
    return chatId;
  }

  Future<void> sendMessage(MessageModel message) async {
    final batch = _firestore.batch();
    
    // Add message
    batch.set(
      _firestore.collection('chats').doc(message.chatId).collection('messages').doc(message.id),
      message.toMap(),
    );
    
    // Update chat last message
    batch.update(_firestore.collection('chats').doc(message.chatId), {
      'lastMessage': message.content,
      'lastMessageTime': message.timestamp.millisecondsSinceEpoch,
    });
    
    await batch.commit();
  }

  Stream<List<ChatModel>> getUserChats(String userId) {
    return _firestore
        .collection('chats')
        .where('participants', arrayContains: userId)
        .orderBy('lastMessageTime', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => ChatModel.fromMap({...doc.data(), 'id': doc.id}))
            .toList());
  }

  Stream<List<MessageModel>> getChatMessages(String chatId) {
    return _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => MessageModel.fromMap({...doc.data(), 'id': doc.id}))
            .toList());
  }
}