import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/swap_model.dart';

class SwapRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createSwapRequest(SwapModel swap) async {
    final batch = _firestore.batch();
    
    // Add swap request
    batch.set(_firestore.collection('swaps').doc(swap.id), swap.toMap());
    
    // Update book status to pending
    batch.update(_firestore.collection('books').doc(swap.bookId), {
      'status': 'pending'
    });
    
    await batch.commit();
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