import '../../domain/entities/swap_entity.dart';

class SwapModel extends SwapEntity {
  const SwapModel({
    required super.id,
    required super.bookId,
    required super.bookOwnerId,
    required super.requesterId,
    required super.status,
    required super.createdAt,
  });

  factory SwapModel.fromMap(Map<String, dynamic> map) {
    return SwapModel(
      id: map['id'] ?? '',
      bookId: map['bookId'] ?? '',
      bookOwnerId: map['bookOwnerId'] ?? '',
      requesterId: map['requesterId'] ?? '',
      status: map['status'] ?? 'pending',
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] ?? 0),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'bookId': bookId,
      'bookOwnerId': bookOwnerId,
      'requesterId': requesterId,
      'status': status,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }
}