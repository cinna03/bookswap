class BookEntity {
  final String id;
  final String title;
  final String author;
  final String condition;
  final String imageUrl;
  final String ownerId;
  final String status; // available, pending, swapped
  final DateTime createdAt;

  const BookEntity({
    required this.id,
    required this.title,
    required this.author,
    required this.condition,
    required this.imageUrl,
    required this.ownerId,
    required this.status,
    required this.createdAt,
  });
}