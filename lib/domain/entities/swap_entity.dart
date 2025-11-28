class SwapEntity {
  final String id;
  final String bookId;
  final String bookOwnerId;
  final String requesterId;
  final String status; // pending, accepted, rejected
  final DateTime createdAt;

  const SwapEntity({
    required this.id,
    required this.bookId,
    required this.bookOwnerId,
    required this.requesterId,
    required this.status,
    required this.createdAt,
  });
}