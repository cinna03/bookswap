import 'package:flutter/material.dart';

class MyListingsScreen extends StatelessWidget {
  const MyListingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Books'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // TODO: Navigate to add book screen
            },
          ),
        ],
      ),
      body: const Center(
        child: Text(
          'Your book listings will appear here',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}