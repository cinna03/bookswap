import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/swap_provider.dart';
import '../../providers/auth_provider.dart';
import '../../data/models/swap_model.dart';

class MyOffersScreen extends StatelessWidget {
  const MyOffersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Offers'),
      ),
      body: Consumer2<SwapProvider, AuthProvider>(
        builder: (context, swapProvider, authProvider, child) {
          return StreamBuilder<List<SwapModel>>(
            stream: swapProvider.getUserSwapRequests(authProvider.user!.id),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              
              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(
                  child: Text('No swap requests sent yet'),
                );
              }
              
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final swap = snapshot.data![index];
                  return Card(
                    child: ListTile(
                      title: Text('Swap Request'),
                      subtitle: Text('Book ID: ${swap.bookId}'),
                      trailing: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: _getStatusColor(swap.status),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          swap.status.toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
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

  Color _getStatusColor(String status) {
    switch (status) {
      case 'pending':
        return Colors.orange;
      case 'accepted':
        return Colors.green;
      case 'rejected':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}