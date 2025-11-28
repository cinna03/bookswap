import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../data/models/book_model.dart';
import '../../data/repositories/book_repository.dart';

class BookProvider extends ChangeNotifier {
  final BookRepository _repository = BookRepository();
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<String?> addBook({
    required String title,
    required String author,
    required String condition,
    required String ownerId,
    File? imageFile,
  }) async {
    try {
      _isLoading = true;
      notifyListeners();

      final bookId = DateTime.now().millisecondsSinceEpoch.toString();
      String imageUrl = '';

      if (imageFile != null) {
        imageUrl = await _repository.uploadImage(imageFile, bookId);
      }

      final book = BookModel(
        id: bookId,
        title: title,
        author: author,
        condition: condition,
        imageUrl: imageUrl,
        ownerId: ownerId,
        status: 'available',
        createdAt: DateTime.now(),
      );

      await _repository.addBook(book);
      return null;
    } catch (e) {
      return e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<String?> updateBook(BookModel book, {File? newImageFile}) async {
    try {
      _isLoading = true;
      notifyListeners();

      String imageUrl = book.imageUrl;
      if (newImageFile != null) {
        imageUrl = await _repository.uploadImage(newImageFile, book.id);
      }

      final updatedBook = BookModel(
        id: book.id,
        title: book.title,
        author: book.author,
        condition: book.condition,
        imageUrl: imageUrl,
        ownerId: book.ownerId,
        status: book.status,
        createdAt: book.createdAt,
      );

      await _repository.updateBook(updatedBook);
      return null;
    } catch (e) {
      return e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<String?> deleteBook(String bookId) async {
    try {
      await _repository.deleteBook(bookId);
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  Stream<List<BookModel>> getAllBooks() => _repository.getAllBooks();
  Stream<List<BookModel>> getUserBooks(String userId) => _repository.getUserBooks(userId);

  Future<File?> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    return pickedFile != null ? File(pickedFile.path) : null;
  }
}