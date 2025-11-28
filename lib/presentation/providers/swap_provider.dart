import 'package:flutter/material.dart';
import '../../data/models/swap_model.dart';
import '../../data/repositories/swap_repository.dart';

class SwapProvider extends ChangeNotifier {
  final SwapRepository _repository = SwapRepository();
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<String?> createSwapRequest({
    required String bookId,
    required String bookOwnerId,
    required String requesterId,
  }) async {
    try {
      _isLoading = true;
      notifyListeners();

      final swapId = DateTime.now().millisecondsSinceEpoch.toString();
      final swap = SwapModel(
        id: swapId,
        bookId: bookId,
        bookOwnerId: bookOwnerId,
        requesterId: requesterId,
        status: 'pending',
        createdAt: DateTime.now(),
      );

      await _repository.createSwapRequest(swap);
      return null;
    } catch (e) {
      return e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Stream<List<SwapModel>> getUserSwapRequests(String userId) =>
      _repository.getUserSwapRequests(userId);

  Stream<List<SwapModel>> getIncomingSwapRequests(String userId) =>
      _repository.getIncomingSwapRequests(userId);
}