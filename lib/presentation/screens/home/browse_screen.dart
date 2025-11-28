import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../providers/book_provider.dart';
import '../../providers/swap_provider.dart';
import '../../providers/auth_provider.dart';
import '../../data/models/book_model.dart';

class BrowseScreen extends StatelessWidget {
  const BrowseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Browse Books'),
      ),
      body: Consumer3<BookProvider, SwapProvider, AuthProvider>(
        builder: (context, bookProvider, swapProvider, authProvider, child) {
          return StreamBuilder<List<BookModel>>(
            stream: bookProvider.getAllBooks(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              
              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(
                  child: Text('No books available'),
                );
              }
              
              return GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final book = snapshot.data![index];
                  final isOwnBook = book.ownerId == authProvider.user!.id;
                  
                  return Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: book.imageUrl.isNotEmpty
                              ? CachedNetworkImage(
                                  imageUrl: book.imageUrl,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                )
                              : const Icon(Icons.book, size: 50),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                book.title,
                                style: const TextStyle(fontWeight: FontWeight.bold),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                book.author,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    book.condition,
                                    style: TextStyle(color: Colors.grey[600]),
                                  ),
                                  Text(
                                    book.status.toUpperCase(),
                                    style: TextStyle(
                                      color: book.status == 'available' 
                                          ? Colors.green 
                                          : Colors.orange,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              if (!isOwnBook && book.status == 'available')
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () => _requestSwap(context, swapProvider, book, authProvider.user!.id),
                                    child: const Text('Swap'),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
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

  void _requestSwap(BuildContext context, SwapProvider swapProvider, BookModel book, String userId) async {
    final error = await swapProvider.createSwapRequest(
      bookId: book.id,
      bookOwnerId: book.ownerId,
      requesterId: userId,
    );

    if (error != null && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error)),
      );
    } else if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Swap request sent!')),
      );
    }
  }
}