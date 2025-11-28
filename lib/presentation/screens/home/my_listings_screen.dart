import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../providers/book_provider.dart';
import '../../providers/auth_provider.dart';
import '../../data/models/book_model.dart';
import 'add_book_screen.dart';
import 'my_offers_screen.dart';

class MyListingsScreen extends StatelessWidget {
  const MyListingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Books'),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AddBookScreen()),
                );
              },
            ),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(text: 'My Books'),
              Tab(text: 'My Offers'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            _MyBooksTab(),
            MyOffersScreen(),
          ],
        ),
      ),
    );
  }
}

class _MyBooksTab extends StatelessWidget {
  const _MyBooksTab();

  @override
  Widget build(BuildContext context) {
    return Consumer2<BookProvider, AuthProvider>(
        builder: (context, bookProvider, authProvider, child) {
          return StreamBuilder<List<BookModel>>(
            stream: bookProvider.getUserBooks(authProvider.user!.id),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              
              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(
                  child: Text('No books listed yet\nTap + to add your first book'),
                );
              }
              
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final book = snapshot.data![index];
                  return Card(
                    child: ListTile(
                      leading: book.imageUrl.isNotEmpty
                          ? CachedNetworkImage(
                              imageUrl: book.imageUrl,
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            )
                          : const Icon(Icons.book),
                      title: Text(book.title),
                      subtitle: Text('${book.author} • ${book.condition} • ${book.status.toUpperCase()}'),
                      trailing: PopupMenuButton(
                        itemBuilder: (context) => [
                          const PopupMenuItem(
                            value: 'delete',
                            child: Text('Delete'),
                          ),
                        ],
                        onSelected: (value) {
                          if (value == 'delete') {
                            _deleteBook(context, bookProvider, book.id);
                          }
                        },
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  static void _deleteBook(BuildContext context, BookProvider bookProvider, String bookId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Book'),
        content: const Text('Are you sure you want to delete this book?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              final error = await bookProvider.deleteBook(bookId);
              if (error != null && context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(error)),
                );
              }
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}