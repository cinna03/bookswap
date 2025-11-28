import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/swap_model.dart';
import 'chat_repository.dart';

class SwapRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final ChatRepository _chatRepository = ChatRepository();

  Future<void> createSwapRequest(SwapModel swap) async {
    final batch = _firestore.batch();
    
    // Add swap request
    batch.set(_firestore.collection('swaps').doc(swap.id), swap.toMap());
    
    // Update book status to pending
    batch.update(_firestore.collection('books').doc(swap.bookId), {
      'status': 'pending'
    });
    
    await batch.commit();
    
    // Create chat for this swap
    await _chatRepository.createChat(swap.id, [swap.requesterId, swap.bookOwnerId]);
  }

  Stream<List<SwapModel>> getUserSwapRequests(String userId) {
    return _firestore
        .collection('swaps')
        .where('requesterId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => SwapModel.fromMap({...doc.data(), 'id': doc.id}))
            .toList());
  }

  Stream<List<SwapModel>> getIncomingSwapRequests(String userId) {
    return _firestore
        .collection('swaps')
        .where('bookOwnerId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => SwapModel.fromMap({...doc.data(), 'id': doc.id}))
            .toList());
  }
}